
tool

extends EditorScript

var poke_script = load("res://logics/DB/pokemon.gd")

func _run():
	var scn = get_scene()
	if (scn == null || scn.get_name() != "DB"):
		print("WARNING: not in Database scene!")
		return
		
	var container = scn.get_node("pokemons")
	if (container == null):
		container = Node.new()
		container.set_name("pokemons")
		scn.add_child(container)
		container.set_owner(scn)
		
	var names = StringArray()
	names.push_back("None")

	for i in range(151):

		var text = get_json("/api/v1/pokemon/"+str(i+1)+"/")
		
		if (text == null || text == ""):
			print ("skipping type #"+str(i+1))
			continue
			
		var pkm = poke_script.new()
		container.add_child(pkm)
		pkm.set_owner(scn)
		
		var d = Dictionary()
		d.parse_json(text)
		pkm.set_name(str(i+1)+" - "+d["name"])
		names.push_back(d["name"])
		
		pkm.id=i+1
		pkm.attack=int(d["attack"])
		pkm.catch_rate=int(d["catch_rate"])
		pkm.name=d["name"]
		
		for e in d["evolutions"]:
			if (e["method"] == "level_up"):
				pkm.evol_method.push_back(0)
			elif (e["method"] == "trade"):
				pkm.evol_method.push_back(1)
			elif (e["method"] == "stone"):
				pkm.evol_method.push_back(2)
			if (e.has("level")):
				pkm.evol_lvl.push_back(e["level"])
			pkm.evol_pokemon_id.push_back(int(e["resource_uri"].split("/")[4]))
		
		var desc = Dictionary()
		desc.parse_json(get_json(d["descriptions"][0]["resource_uri"]))
		pkm.description = desc["description"]
		
		for l in d["moves"]:
			if (l["learn_type"]=="machine"):
				pkm.learn_type.push_back(1)
				pkm.learn_lvl.push_back(0)
				pkm.learn_move_id.push_back(int(l["resource_uri"].split("/")[4]))
			elif (l["learn_type"]=="level up"):
				pkm.learn_type.push_back(0)
				pkm.learn_lvl.push_back(l["level"])
				pkm.learn_move_id.push_back(int(l["resource_uri"].split("/")[4]))
			elif (l["learn_type"]=="evolve"):
				pkm.learn_type.push_back(2)
				pkm.learn_lvl.push_back(0)
				pkm.learn_move_id.push_back(int(l["resource_uri"].split("/")[4]))
				
		
		if (d["types"].size() > 0):
			pkm.type_a = int(d["types"][0]["resource_uri"].split("/")[4])
		if (d["types"].size() > 1):
			pkm.type_b = int(d["types"][1]["resource_uri"].split("/")[4])
		pkm.short_desc = d["species"]
		pkm.hp = int(d["hp"])
		pkm.defense = int(d["defense"])
		pkm.special = int(d["sp_atk"])
		pkm.speed = int(d["speed"])
		pkm.total = int(d["total"])
		pkm.ev_yield = d["ev_yield"]
		pkm.base_exp = int(d["exp"])
		pkm.growth_rate = d["growth_rate"]
		pkm.height = int(d["height"])
		pkm.weight = int(d["weight"])
		
		print("loaded pokemon: " + pkm.get_name())
	
	scn.pokedex = str(names)

func get_json(uri):
	
	var err=0
	var http = HTTPClient.new() # Create the Client
	var err = http.connect("www.pokeapi.co",80) # Connect to host/port
	assert( err == OK )
	while( http.get_status()==HTTPClient.STATUS_CONNECTING or http.get_status()==HTTPClient.STATUS_RESOLVING):
			#Wait until resolved and connected
		http.poll()
		OS.delay_msec(50)
	assert( http.get_status() == HTTPClient.STATUS_CONNECTED ) # Could not connect
	var headers=[]
	err = http.request(HTTPClient.METHOD_GET,uri,headers) # Request a page from the site (this one was chunked..)
	assert( err == OK ) # Make sure all is OK
	while (http.get_status() == HTTPClient.STATUS_REQUESTING):
		# Keep polling until the request is going on
		http.poll()
		OS.delay_msec(500)
	assert( http.get_status() == HTTPClient.STATUS_BODY or http.get_status() == HTTPClient.STATUS_CONNECTED ) # Make sure request finished well.
	if (http.has_response()):
		var rb = RawArray() #array that will hold the data
		while(http.get_status()==HTTPClient.STATUS_BODY):
			#While there is body left to be read
			http.poll()
			var chunk = http.read_response_body_chunk() # Get a chunk
			if (chunk.size()==0):
				#got nothing, wait for buffers to fill a bit
				OS.delay_usec(50)
			else:
				rb = rb + chunk # append to read bufer
		#done!
		var text = rb.get_string_from_ascii()
		return text
	return ""