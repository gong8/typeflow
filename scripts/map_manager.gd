class_name MapManager

var changes : Dictionary = {}

func get_last_properties(time) -> Dictionary:
	var closest_time : float = -1.0
	var closest_index : int = -1
	
	#check if any keyframes before, if so copy
	for k in changes.keys():
		if changes[k]["time"] <= time && changes[k]["time"] > closest_time:
			closest_index = k
			closest_time = changes[k]["time"] 
	
	
	#if no keyframes before, look for keyframes after
	if closest_index == -1:
		closest_time = INF
		for k in changes.keys():
			if changes[k]["time"] >= time && changes[k]["time"] < closest_time:
				closest_index = k
				closest_time = changes[k]["time"] 
	
	#if this is first keyframe, default
	if closest_index == -1:
		return {"time" : time, "bpm" : 60, "tracks" : 1}
	else:
		return {"time" : time, "bpm" : changes[closest_index]["bpm"], "tracks" : changes[closest_index]["tracks"]}

func get_time_sorted_array():
	var arr = []
	var time_sorted_keys = changes.keys()
	time_sorted_keys.sort_custom(func(a,b): return changes[a]["time"] < changes[b]["time"])
	
	for k in time_sorted_keys:
		arr.push_back(changes[k])
	
	return arr
