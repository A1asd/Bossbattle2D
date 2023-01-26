extends "res://Actors/Actor.gd"

onready var animationPlayer = $AnimationPlayer

func _on_EnemyActor_death():
	queue_free()
	disconnect("damaged", $".", "_on_EnemyActor_damaged")

func _on_EnemyActor_damaged():
	animationPlayer.play("Hit")
	yield(animationPlayer, "animation_finished")
	animationPlayer.play("Idle")
