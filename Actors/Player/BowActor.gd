extends PlayerActor

const BOW_READY_ANIMATION_STRING = "Ready_Bow"
const BOW_DRAW_ANIMATION_STRING = "Bow_Drawing"
const BOW_RELEASE_ANIMATION_STRING = "Bow_Release"
const CURRENT_ANIMATION = IDLE_ANIMATION_STRING

export (bool) var in_chain = false

var bow_readied = false

func is_bow_ready():
	return bow_readied

func input():
	.input()
	
	if Input.is_action_just_pressed("action_attack") and !is_busy():
		moveable = false
		bow_readied = true
		animationPlayer.play(BOW_READY_ANIMATION_STRING)
	
	if Input.is_action_pressed("action_attack"):
		animationPlayer.queue(BOW_DRAW_ANIMATION_STRING)
	
	if Input.is_action_just_released("action_attack") and is_bow_ready():
		startAnimation(BOW_RELEASE_ANIMATION_STRING)
		bow_readied = false
		moveable = true

func _on_AttackArea_body_entered(body):
	if !body.is_in_group("enemy"): return
	body.take_damage($Weapon.get_damage(), body, self)
