extends Node2D

onready var tb_bg = get_node("Text Box BG")
onready var anim_player = tb_bg.get_node("AnimationPlayer")
onready var tb = get_node("Text Box")
onready var active = false
onready var infobox = load("res://gui/dialog_box/info_box.tscn")
onready var infoboxes = get_node("Info Boxes")

var delay_time

func _ready():
	pass
	
func activate_box():
	active = true
	anim_player.play("Activate")
	
func deactivate_box():
	active = false
	anim_player.play("Deactivate")
	tb.set_bbcode("")
	tb.set_visible_characters(0)
	var timer = get_node("Deactivate Timer")
	timer.stop()
	get_node("Text Tween").stop_all()
	clear_all_info_boxes()

func is_active():
	return active

func display_new_ability(name, key, description, icon):
	var ib = infobox.instance()
	
	#Configure info box
	ib.set_top_text("[center]NEW ABILITY [color=blue]UNLOCKED:[/color][/center]")
	ib.set_title("[center][color=yellow][u]"+name+"[/u][/color][/center]")
	ib.set_icon(icon)
	ib.set_description("[center]"+description+"[/center]")
	ib.set_bottom_text("[center][color=yellow]Press[/color][color=black] "+key+" [/color][color=yellow]to use it![/color][/center]")
	ib.set_bg_color("ability")
	
	#Add ib to info boxes and re-arrange them
	infoboxes.add_child(ib)
	ib.activate()
	fix_info_boxes()

func display_new_enemy(name, health, description, icon):
	var ib = infobox.instance()
	
	#Configure info box
	ib.set_top_text("[center]NEW ENEMY [color=lime]UNLOCKED:[/color][/center]")
	ib.set_title("[center][color=yellow][u]"+name+"[/u][/color][/center]")
	ib.set_icon(icon)
	ib.set_description("[center]"+description+"[/center]")
	ib.set_bottom_text("[center][color=yellow]Enemy Health: [/color][color=black]"+health+" [/color][/center]")
	ib.set_bg_color("enemy")
	
	#Add ib to info boxes and re-arrange them
	infoboxes.add_child(ib)
	ib.activate()
	fix_info_boxes()

func fix_info_boxes():
	var n = infoboxes.get_child_count()
	if n <= 0:
		return
	var gap = 20
	var w = infoboxes.get_child(0).get_width()
	var total_width = (n-1)*w + (n-1)*gap
	var x_pos = -total_width/2 #Inicial x position for a infobox
	for infob in infoboxes.get_children():
		infob.set_pos(Vector2(x_pos, infob.get_pos().y))
		x_pos += w + gap

func clear_all_info_boxes():
	for infob in infoboxes.get_children():
		infob.deactivate()

#Delay will be the time dialog box will wait after text is shown before deactivating everything
func display_text(text, delay = 3):
	delay_time = delay
	var text_tween = get_node("Text Tween")
	if is_active():
		var timer = get_node("Deactivate Timer")
		timer.stop()
		text_tween.stop_all()
	else:
		activate_box()
		
	tb.set_bbcode(text)
	tb.set_visible_characters(0)
	
	#Create gradual text effect
	var raw_text = tb.get_text()
	var len = raw_text.length()
	var text_speed = 20
	var d = max(1, len/text_speed)
	var delay = .3
	text_tween.interpolate_property(tb, "visible_characters", 0, len, d, Tween.TRANS_LINEAR, Tween.EASE_IN, delay)
	text_tween.start()
	
	#Make cientist talk while text appear
	var portrait = get_parent().get_node("Cientist_Portrait")
	portrait.start_talking()
	
func _text_tween_complete( object, key ):
	var portrait = get_parent().get_node("Cientist_Portrait")
	portrait.stop_talking()
	start_deactivate_timer()
	
func start_deactivate_timer():
	var timer = get_node("Deactivate Timer")
	timer.set_wait_time(delay_time)
	timer.start()

