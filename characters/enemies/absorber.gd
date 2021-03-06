extends 'enemy.gd'

const DIR = preload("res://characters/player/input/directions.gd")

onready var anim = get_node("Sprite/AnimationPlayer")

const DIR_ANIMS = [
	"up", "down"
]

var last_dir = -1
var shield = true

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
			anim.current_animation = DIR_ANIMS[1] + append
		else:
			anim.current_animation = DIR_ANIMS[0] + append
		last_dir = dir
	if shield and stunned > 0:
		shield = false
		get_node("Particles2D").emitting = false
	elif not shield and stunned <= 0:
		shield = true
		get_node("Particles2D").emitting =true

