extends 'res://bullets/bullet.gd'

onready var timer = get_node('Timer')
onready var main = get_node('../../')

func _ready():
	timer.connect('timeout', self, '_queue_free')
	timer.start()
	set_fixed_process(true)

func _fixed_process(delta):
	if get_node("../../Floor").world_to_map(self.get_pos()) > Vector2(50, 50) or get_node("../../Floor").world_to_map(self.get_pos()) < Vector2(-50, -50):
		self.queue_free()
		
func apply_speed(delta):
	var motionScale = self.speed * delta * self.speed_factor
	var motion = move( motionScale )
	
	if (is_colliding()):
		var collider = get_collider()
		var normal = get_collision_normal()
		motion = normal.reflect(motion)
		self.speed = normal.reflect(self.speed)
		move(motion)

func _queue_free():
	self.queue_free()
