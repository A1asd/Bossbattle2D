extends Node

onready var boss = $Boss/EnemyActor
#onready var ui = $HUD/Ui
onready var ui = $CanvasLayer/Ui

var boss_health_max_x_size = 440

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
	if ($Boss/EnemyActor):
		ui.get_node("BossHealth").rect_size.x = float(boss.cur_health)/boss.max_health*boss_health_max_x_size
	else:
		ui.get_node("BossHealth").rect_size.x = 0
	
	var _playerCollider = get_node("Players/PlayableActor/CollisionShape2D")
	var player = get_node("Players/PlayableActor")
	var _bossCollider = get_node("Boss/EnemyActor/CollisionShape2D")
	
	if ($Boss/EnemyActor):
		if (boss.position.y > player.position.y):
			get_node("Boss/EnemyActor").z_index = 2
		else:
			get_node("Boss/EnemyActor").z_index = 0


func _on_StonesArea_body_entered(body):
	if body.is_in_group("players"):
		body.set_prompt_text("Grab Stone")
		body.activate_button_prompt()
		body.connect("action_use", self, "_pickup_stones")


func _on_StonesArea_body_exited(body):
	if body.is_in_group("players"):
		body.set_prompt_text("")
		body.deactivate_button_prompt()
		body.disconnect("action_use", self, "_pickup_stones")

func _pickup_stones():
	print("picking up stones")
