extends Area2D


onready var GameStage = get_node("/root/StageHandler/GameStage")

onready var HandManager = get_node("/root/StageHandler/GameStage/HandManager")

onready var _buff_card_scene = load("res://Common/Res/Cards/BuffCard.tscn")



var _mouse_over = false

var _was_pressed = false


func buy_card():
	if(HandManager.get_card_count() < 6):
		if(GameStage.remove_money(2)):
			spawn_random_card()

func spawn_random_card():
	var pull_list = []
	for b in CardRepo.buffs:
		var amount = CardRepo.buffs[b]["count"]
		for i in range(amount):
			pull_list.append(b)
	
	var index = randi() % (pull_list.size())
	spawn_card(pull_list[index])

func spawn_card(id:int):
	var card = _buff_card_scene.instance()
	card.card_id = id
	card.position = get_position()
	HandManager.add_child(card)
	HandManager.update_hand_position()




func _on_BuffDeck_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if(event.pressed && event.button_index == BUTTON_LEFT && _mouse_over):
			_was_pressed = true
			buy_card()
			
		
		if(!event.pressed && event.button_index == BUTTON_LEFT):
			_was_pressed = false


func _on_BuffDeck_mouse_entered():
	_mouse_over = true


func _on_BuffDeck_mouse_exited():
	_mouse_over = false



