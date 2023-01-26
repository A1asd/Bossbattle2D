extends KinematicBody2D
class_name BaseActor

export (int) var max_health
export (int) var cur_health

signal death
signal damaged

func take_damage(amount, _target, _caster):
	cur_health -= amount
	emit_signal("damaged")
	if (cur_health <= 0): emit_signal("death")

func heal(amount, _target, caster):
	cur_health += amount
	emit_signal("healed")
	if (cur_health > max_health):
		cur_health = max_health
		caster.increase_aggro(1)
