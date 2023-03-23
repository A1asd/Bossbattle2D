extends Label

@onready var storage = get_node("../storage")

var strings : PackedStringArray = []

func _ready():
	if(storage == null):
		print("something went wrong")
	pass # Replace with function body.


func _process(_delta):
	strings.resize(0)
	strings.append("Stored Variables:\n")
	for key in storage.variables.keys():
		strings.append("\t%s : %s \n"%[key,storage.variables[key].as_string()])
	text = "".join(strings);




