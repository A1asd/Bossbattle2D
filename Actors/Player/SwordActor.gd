extends PlayerActor

const ATTACK_ANIMATION_STRING = "Attack"
const STRONG_ANIMATION_STRING = "Attack2"
const BLOCK_ANIMATION_STRING = "Block"
const CURRENT_ANIMATION = "Idle"

export (bool) var in_chain = false

func input():
	.input()
	
	if Input.is_action_pressed("action_block") and !is_busy():
		moveable = false
		blocking = true
		startAnimation(BLOCK_ANIMATION_STRING)
		yield(animationPlayer, "animation_finished")
		blocking = false
		moveable = true
	
	if Input.is_action_just_pressed("action_attack"):# and !is_busy():
		moveable = false
		if (in_chain):
			queueAnimation(STRONG_ANIMATION_STRING)
		else:
			startAnimation(ATTACK_ANIMATION_STRING)
		yield(animationPlayer, "animation_finished")
		moveable = true

	#if Input.is_action_just_pressed("action_strong_attack") and !is_busy():
	#	moveable = false
	#	startAnimation(STRONG_ANIMATION_STRING)
	#	yield(animationPlayer, "animation_finished")
	#	moveable = true

func _on_AttackArea_body_entered(body):
	if !body.is_in_group("enemy"): return
	body.take_damage($Weapon.get_damage(), body, self)
