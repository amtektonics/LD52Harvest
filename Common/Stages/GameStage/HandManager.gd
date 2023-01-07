extends Node2D

export var card_size = Vector2(200, 260)

export var max_spacing = 100.0

var _cards = []

func _ready():
	update_hand_position()

func update_hand_position():
	_cards.clear()
	
	for c in get_children():
		if c.is_in_group("Card"):
			if(!c.is_card_consumed()):
				_cards.append(c)
	
	var card_count = _cards.size()
	var spacing = max_spacing - clamp(card_count * 20, 0, 225)
	var x_start = -((card_count / 2) * (card_size.x + spacing))
	if(card_count % 2 == 0):
		x_start = x_start + (card_size.x / 2) + (spacing / 2)
	
	for card in _cards:
		card.set_hand_position(Vector2(x_start + get_global_position().x, get_global_position().y))
		x_start += (card_size.x + spacing)
