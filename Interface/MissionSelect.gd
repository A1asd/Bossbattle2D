extends Control

const TUTORIAL_MAP = "res://Maps/GameWorld.tscn"

func _on_TutorialLevel_button_up():
	get_tree().change_scene(TUTORIAL_MAP)
