extends Control

var swordDude = preload("res://WIP/sword-dude-big.png")
var rangerDude = preload("res://WIP/ranger-big.png")

var skill_json = "res://Skills/Skills.json"
var skill_data = {}

var skill_icon_path = "res://Interface/SkillIcons/"

var user_loadouts_json = "res://Actors/Loadouts.json"
var user_loadouts_data = {}

onready var sprite = $VBoxContainer/HBoxContainer/Sprite
onready var skill_bar = $VBoxContainer/HBoxContainer/SkillContainer/SkillBar
onready var skill_container = $VBoxContainer/HBoxContainer/SkillContainer/SkillGrid
onready var loadouts_select = $VBoxContainer/ControlButtons/LoadoutsSelect

func prepare_skill_buttons():
	var file = File.new()
	
	if not file.file_exists(skill_json): return
	
	file.open(skill_json, file.READ)
	var text = file.get_as_text()
	skill_data = parse_json(text)
	
	for skill in skill_data:
		var skill_button = _new_texture_button_from_skill(skill_data[skill])
		skill_container.add_child(skill_button)
	
	file.close()

func load_from_user_data():
	var file = File.new()
	
	if not file.file_exists(user_loadouts_json): return
	
	file.open(user_loadouts_json, file.READ)
	var text = file.get_as_text()
	user_loadouts_data = parse_json(text)
	
	set_loadout_skills()
	
	file.close()

func set_loadout_skills():
	var skill_array = user_loadouts_data.loadout1
	loadouts_select.add_item(skill_array.name)
	for skill_id in skill_array.skills:
		skill_id = skill_array.skills[skill_id]
		var skill_button = _new_texture_button_from_skill(skill_data[skill_id])
		skill_bar.add_child(skill_button)

func _ready():
	prepare_skill_buttons()
	load_from_user_data()

func _new_texture_button_from_skill(skill):
	var skill_button = TextureButton.new()
	skill_button.texture_normal = load(skill_icon_path + skill.icon)
	skill_button.hint_tooltip = skill.name + "\n" + skill.tooltip
	skill_button.expand = true
	skill_button.rect_size = Vector2(64, 64)
	skill_button.rect_min_size = Vector2(64, 64)
	skill_button.connect("button_up", self, "_save_in_loadout", [skill])
	return skill_button

func _save_in_loadout(skill):
	print(skill.name)

func _on_SwordDud_button_up():
	sprite.set_texture(swordDude)

func _on_BowDud_button_up():
	sprite.set_texture(rangerDude)

func _on_BackButton_button_up():
	get_tree().change_scene("res://Interface/MainMenu.tscn")

func _on_SaveButton_button_up():
	pass # Replace with function body.

func _on_LoadButton_button_up():
	pass # Replace with function body.

func _on_TestButton_button_up():
	pass # Replace with function body.
