extends Node2D

var cur = 0
onready var pg_bar = get_node("ProgressBar")
onready var icon_spot = get_node("IconSpot")
var icon

signal cooldown_end

func _ready():
	set_fixed_process(true)
	icon_spot.add_child(icon.instance())

func set_max(mx):
	pg_bar.set_max(mx)
	cur = mx

func _fixed_process(dt):
	cur -= dt
	pg_bar.set_value(cur)
	if cur <= 0:
		get_parent().fix_y(self)
		queue_free()
		emit_signal('cooldown_end')
