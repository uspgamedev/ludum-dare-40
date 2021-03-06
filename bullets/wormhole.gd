extends 'res://bullets/bullet.gd'

var brother = false

onready var sfx = get_node("SFX")

func _ready():
	sfx.get_node('Warp').play()

func set_brother(b):
	brother = b
	get_node("Sprite").set_brother()

func _on_Area2D_area_entered(area):
	if (area.is_in_group('walls')):
		set_position(randi()%1280, randi()%720)
	if (area.is_in_group('enemy_area') or area.is_in_group('player_area')) and brother:
		var other = area.get_parent()
		var mem = other.get_position()
		other.set_position(brother.get_position())
		if (get_node('Area2D').get_overlapping_bodies().size() > 0):
			other.set_position(mem)
