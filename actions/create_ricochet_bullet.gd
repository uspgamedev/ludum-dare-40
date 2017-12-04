extends 'base_action.gd'

func _init():
	cooldown_time = .2
	name = "richochet_bullet"

func activate(action_handler):
	print("Ricochet Bullet")
	self.icon = preload('res://bullets/bounce_bullet/ricochet_bullet_sprite.tscn')
	var RicochetBullet = preload('res://bullets/ricochet_bullet.tscn')
	var b = RicochetBullet.instance()
	var pl = action_handler.get_parent()
	pl.sfx.play("Special")
	b.set_pos(pl.get_pos())
	b.speed = pl.get_look_dir().normalized() * 400
	pl.get_parent().add_child(b)
	return null
