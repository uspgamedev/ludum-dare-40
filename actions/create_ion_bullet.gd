extends 'base_action.gd'

func activate(action_handler):
	#self.icon = preload("res://bullets/ion_bullet_sprite.tscn")
	var ion = preload('res://bullets/ion_bullet.tscn').instance()
	var pl = action_handler.get_parent()
	ion.set_pos(pl.get_pos() + Vector2(0, -20))
	ion.speed = pl.get_look_dir().normalized() * 500
	pl.get_parent().add_child(ion)

func _init():
	cooldown_time = 5