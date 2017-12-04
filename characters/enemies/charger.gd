extends 'enemy.gd'

const DIR = preload("res://characters/player/input/directions.gd")

onready var anim = get_node("Sprite/AnimationPlayer")

const DIR_ANIMS = [
	"up", "down"
]

var last_dir = -1

func _fixed_process(delta):
	var temp = get_speed()
	var dir = temp.y/abs(temp.y)
	if dir != self.last_dir:
		var append = ""
		if self.speed.length_squared() > 1:
			append = "_moving"
		else:
			dir = last_dir
		if dir == 1:
			anim.set_current_animation(DIR_ANIMS[1] + append)
		else:
			anim.set_current_animation(DIR_ANIMS[0] + append)
		last_dir = dir

func apply_speed(delta):
	var motionScale = Vector2()

	if self.dashTime > 0:
		motionScale = self.speed * delta * DASHFACTOR
		self.dashTime -= delta
	else:
		motionScale = self.speed * delta
		self.dashTime = 0

	var motion = move( motionScale )
	if (is_colliding() and self.ai.state != self.ai.CHARGE):
		var collider = get_collider()
		var normal = get_collision_normal()
		motion = normal.slide(motion)
		self.speed = normal.slide(self.speed)
		move(motion)

	