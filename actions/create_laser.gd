extends 'base_action.gd'

const poly = PoolVector2Array([Vector2(-8, -16), Vector2(8, -16),
						   Vector2(8, 16), Vector2(-8, 16)])

func _init():
	cooldown_time = 5
	name = 'laser'
	self.icon = preload("res://area_effects/laser/sprite.tscn")

func activate(action_handler, key):
	var Laser = preload('res://area_effects/laser.tscn')
	var pl = action_handler.get_parent()
	var wall_tm = pl.get_parent()
	var b = Laser.instance()
	b.player = pl
	wall_tm.add_child(b)
	return b
