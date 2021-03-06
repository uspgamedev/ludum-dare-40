extends 'enemy.gd'

const DIR = preload("res://characters/player/input/directions.gd")

onready var anim = get_node("Sprite/AnimationPlayer")

const DIR_ANIMS = ["up", "down"]

var last_dir = 1
var collider

func _physics_process(delta):
	var temp = self.speed
	var dir = 0
	if (temp.y != 0):
		dir = temp.y/abs(temp.y)
	var append = ""
	if self.speed.length_squared() > 1:
		append = "_moving"
	if dir != self.last_dir:
		if append.length() == 0:
			dir = last_dir
		if dir == 1:
			anim.set_current_animation(DIR_ANIMS[1] + append)
		else:
			anim.set_current_animation(DIR_ANIMS[0] + append)
		last_dir = dir

func apply_speed_scale(delta):
	var motionScale = Vector2()

	if self.dashTime > 0:
		motionScale = self.speed * DASHFACTOR
		self.dashTime -= delta
	else:
		motionScale = self.speed
		self.dashTime = 0

	move_and_slide( motionScale )
