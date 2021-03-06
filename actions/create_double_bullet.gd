extends 'base_action.gd'

func _init():
	cooldown_time = 1
	name = "double_bullet"
	icon = preload("res://bullets/double_bullet_icon.tscn")

func activate(action_handler, key):
	var SimpleBullet = preload('res://bullets/simple_bullet.tscn')
	var b1 = SimpleBullet.instance()
	var b2 = SimpleBullet.instance()
	var pl = action_handler.get_parent()
	pl.sfx.get_node("DoubleShoot").play()
	b1.set_position(pl.get_position())
	b2.set_position(pl.get_position())
	b1.speed = pl.get_look_dir().rotated(PI/6).normalized() * 400
	b2.speed = pl.get_look_dir().rotated(-PI/6).normalized() * 400
	pl.get_parent().add_child(b1)
	pl.get_parent().add_child(b2)
	return null
