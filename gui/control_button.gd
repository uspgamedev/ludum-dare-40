extends OptionButton

func _ready():
	add_item("Arrows", 0)
	add_item("Mouse", 1)
	if get_node('/root/input').control_type == get_node('/root/input').MOUSE:
		select(1)
	else:
		select(0)

onready var input = get_node('/root/input')

func _on_OptionButton_item_selected( id ):
	if id == 0:
		input.set_control_type(input.KEYBOARD2)
	elif id == 1:
		input.set_control_type(input.MOUSE)
