tool

extends EditorScript

var type_script = load("res://logics/DB/pokemon_type.gd")

func _run():
	var scn = get_scene()
	if (scn == null || scn.get_name() != "DB"):
		print("WARNING: not in Database scene!")
		return
		
	var container = scn.get_node("pokemon_types")
	if (container == null):
		container = Node.new()
		container.set_name("pokemon_types")
		scn.add_child(container)
		container.set_owner(scn)
		
	var names = StringArray()
	names.push_back("None")

	for i in range(20):

		if (Input.is_key_pressed(KEY_ESCAPE)):
			return
		
		var text = get_json("/api/v1/type/"+str(i+1)+"/")
		
		if (text == null || text == ""):
			print ("skipping type #"+str(i+1))
			continue
		
		var p_type = type_script.new()
		container.add_child(p_type)
		p_type.set_owner(scn)
		
		var d = Dictionary()
		d.parse_json(text)
		p_type.set_name(str(i+1)+" - "+d["name"])
		names.push_back(d["name"])
		
		p_type.id=i+1
		p_type.name=d["name"]
		
		for inf in d["ineffective"]:
			p_type.ineffective.push_back(int(inf["resource_uri"].split("/")[4]))
		for n_e in d["no_effect"]:
			p_type.no_effect.push_back(int(n_e["resource_uri"].split("/")[4]))
		for res in d["resistance"]:
			p_type.resistance.push_back(int(res["resource_uri"].split("/")[4]))
		for s_e in d["super_effective"]:
			p_type.super_effective.push_back(int(s_e["resource_uri"].split("/")[4]))
		for weak in d["weakness"]:
			p_type.weakness.push_back(int(weak["resource_uri"].split("/")[4]))
		
		print("loaded pokemon type: " + p_type.get_name())
	
	scn.pokemon_types = str(names)

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