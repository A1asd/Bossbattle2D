extends Control

func _on_StartButton_button_up():
	#$SceneAnimator.play("toWorldMap")
	#await $SceneAnimator.animation_finished
	#get_tree().change_scene_to_file("res://Interface/WorldMap.tscn")
	get_tree().change_scene_to_file("res://Interface/MissionSelect.tscn")

func _on_LoadoutButton_button_up():
	#$SceneAnimator.play("toLoadouts")
	#await $SceneAnimator.animation_finished
	get_tree().change_scene_to_file("res://Interface/Loadouts.tscn")

func _on_OptionsButton_button_up():
	$SceneAnimator.play("toOptions")
	await $SceneAnimator.animation_finished
	get_tree().change_scene_to_file("res://Interface/Options.tscn")

func _on_QuitButton_button_up():
	get_tree().quit()
