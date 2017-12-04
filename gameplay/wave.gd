extends Node

signal ended
var main

onready var manager = get_parent()

var cur_points = 0
var enemy_count = 0
var enemies_id = []
var iterator = 0

func _ready():
	main = get_parent().get_parent()
	set_fixed_process(true)

func update_enemy_vector():
	if (manager.cur_wave%manager.NEW_ENEMY_TYPE == 0):
		var j = round((manager.NEW_ENEMY_PROPORTION*manager.wave_points)/ \
		              (manager.ENEMY_POINTS[manager.enemy_types - 1]))
		for i in range(j):
			enemies_id.append(manager.enemy_types)
			cur_points += manager.ENEMY_POINTS[manager.enemy_types]
	while (cur_points < manager.wave_points):
		var new_enemy = randi()%manager.enemy_types
		enemies_id.append(new_enemy)
		cur_points += manager.ENEMY_POINTS[new_enemy]
	shuffle()

func shuffle():
	for i in range(enemies_id.size() - 1):
		var j = i + randi()%(enemies_id.size() - i)
		var tmp = enemies_id[i]
		enemies_id[i] = enemies_id[j]
		enemies_id[j] = tmp

func create_enemy():
	if (iterator < enemies_id.size()):
		var new_enemy = enemies_id[iterator]
		var Enemy = manager.ENEMIES[new_enemy]
		iterator += 1
		enemy_count += 1
		var e = Enemy.instance()
		e.set_pos(main.get_valid_position())
	
		main.get_node("Props").add_child(e)
		get_node('EnemyTimer').set_wait_time(1 + randi()%3)
		get_node('EnemyTimer').start()

func check_wave_end():
	for i in main.get_node('Props').get_children():
		if i.is_in_group('enemy'):
			return
	if (iterator >= enemies_id.size() and cur_points != 0):
		enemy_count = 0
		cur_points = 0
		iterator = 0
		enemies_id.clear()
		manager.wave_ended()

func _fixed_process(delta):
	check_wave_end()

func start():
	var t = Timer.new()
	t.set_wait_time(rand_range(1, 3))
	t.start()
	t.set_name('EnemyTimer')
	t.connect('timeout', self, 'create_enemy')
	t.set_one_shot(true)
	add_child(t)
	update_enemy_vector()
