extends "res://characters/enemies/enemy.gd"
const DIR = preload("res://characters/player/input/directions.gd")

onready var anim = get_node("Sprite/AnimationPlayer")

const DIR_ANIMS = ["up", "right", "down", "left"]

var last_dir = -1

func _physics_process(delta):
	var dir = self.get_look_dir_value()
	if dir != self.last_dir:
		anim.set_current_animation(DIR_ANIMS[dir])
		last_dir = dir
