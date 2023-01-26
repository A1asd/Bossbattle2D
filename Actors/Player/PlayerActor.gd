extends BaseActor
class_name PlayerActor

const WALK_ANIMATION_STRING = "Walk"
const IDLE_ANIMATION_STRING = "Idle"

var direction = Vector2(0, 0)
var in_control = true
var speed = 200

var aggro
var moveable = true
var blocking = false

var flip = 1

signal action_use

onready var animationPlayer = $AnimationPlayer

func startAnimation(animation):
	animationPlayer.play(animation)
	yield(animationPlayer, "animation_finished")
	animationPlayer.play(IDLE_ANIMATION_STRING)

func queueAnimation(animation):
	animationPlayer.queue(animation)
	yield(animationPlayer, "animation_finished")
	animationPlayer.play(IDLE_ANIMATION_STRING)

func input():
	direction = Vector2(0, 0)
	if !in_control: return
	if Input.is_action_pressed("move_left"):
		direction.x = -1
		if !is_busy():
			startAnimation(WALK_ANIMATION_STRING)
	if Input.is_action_pressed("move_right"):
		direction.x = 1
		if !is_busy():
			startAnimation(WALK_ANIMATION_STRING)
	if Input.is_action_pressed("move_up"):
		direction.y = -1
		if !is_busy():
			startAnimation(WALK_ANIMATION_STRING)
	if Input.is_action_pressed("move_down"):
		direction.y = 1
		if !is_busy():
			startAnimation(WALK_ANIMATION_STRING)
	
	if Input.is_action_just_pressed("action_use"):
		emit_signal("action_use")
	
	if (Input.is_action_just_released("move_down") or Input.is_action_just_released("move_right") or Input.is_action_just_released("move_up") or Input.is_action_just_released("move_left")) and !is_busy():
		startAnimation(IDLE_ANIMATION_STRING)
	
	if direction.x != 0 && flip != direction.x:
		flip = direction.x
		flip()

func is_busy():
	return !moveable

func move(delta):
	if !moveable: return
	
	direction = direction.normalized()
	direction = direction*speed*delta
	
	move_and_collide(direction)
	
	#position.x = clamp(direction.x + position.x, 0, get_viewport_rect().size.x)
	#position.y = clamp(direction.y + position.y, 0, get_viewport_rect().size.y)

func increase_aggro(value):
	aggro += value
	
func decrease_aggro(value):
	aggro -= value
	if aggro < 0: aggro = 0

func _ready():
	pass

func _physics_process(delta):
	input()
	move(delta)

func flip():
	scale.x = -1
	
	for node in get_tree().get_nodes_in_group("not_flippable"):
		if scale.x < 0:
			node.rect_scale.x *= -1
	#$Sprite.flip_h = facing

##########
### UI ###
##########

var image_types = {
	key = "Interface/Key.png",
	ps_cro = "Interface/PsCro.png",
	ps_cir = "Interface/PsCir.png",
	ps_squ = "Interface/PsSqu.png",
	ps_tri = "Interface/PsTri.png",
	ps_r1 = "Interface/PsR1.png",
	ps_r2 = "Interface/PsR2.png",
	ps_r3 = "Interface/PsR3.png",
	ps_l1 = "Interface/PsL1.png",
	ps_l2 = "Interface/PsL2.png",
	ps_l3 = "Interface/PsL3.png",
}

func set_prompt_text(prompt_text):
	$Camera2D/ButtonPrompt/Text.set_text(prompt_text)

func set_prompt_image(_type):
	$Camera2D/ButtonPrompt/Image.set_image()

func activate_button_prompt():
	$Camera2D/ButtonPrompt.visible = true

func deactivate_button_prompt():
	$Camera2D/ButtonPrompt.visible = false
