extends Area2D

export var card_id = 0

var _is_dragging = false

var _is_mouse_over = false

var _should_return = true

var _is_consumed = false

var _hand_position = Vector2()

var _mouse_offset = Vector2()


onready var _cost_label = $Cost

onready var _name_label = $Name

onready var _time_label = $Time

onready var _health_label = $Health

onready var _icon_sprite = $Icon


func _ready():
	_hand_position = get_global_position()
	_cost_label.text = str(CardRepo.seeds[card_id]["cost"])
	_name_label.text = CardRepo.seeds[card_id]["name"]
	_time_label.text = str(CardRepo.seeds[card_id]["time"])
	_health_label.text = str(CardRepo.seeds[card_id]["health"])
	_icon_sprite.texture = load(CardRepo.seeds[card_id]["icon"])
	

func _test_for_interaction():
	if(_is_dragging):
		_is_dragging = false
		for a in get_overlapping_areas():
			if(a.is_in_group("Field")):
				if(!a.has_seed):
					_should_return = false
					a.set_seed(card_id)
					_is_consumed = true
					get_parent().update_hand_position()
					queue_free()

func _process(delta):
	if(_is_dragging):
		set_global_position(get_global_mouse_position() - _mouse_offset)
	elif(!_is_dragging && _should_return):
		set_global_position(lerp(get_global_position(), _hand_position, 9 * delta))

func set_hand_position(pos):
	_hand_position = pos

func is_card_consumed():
	return _is_consumed

func _on_SeedCard_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if(event.pressed == true && event.button_index == BUTTON_LEFT && !_is_dragging && _is_mouse_over):
			
			var has_priority = true
			for a in get_overlapping_areas():
				if(a.is_in_group("Card")):
					if(self.get_index() < a.get_index() && a._is_mouse_over):
						has_priority = false
			
			if(has_priority):
				_is_dragging = true
				_hand_position = get_global_position()
				_mouse_offset = get_global_mouse_position() - _hand_position
			
		if(event.pressed == false && event.button_index == BUTTON_LEFT && _is_dragging):
			_test_for_interaction()

func _on_SeedCard_mouse_entered():
	_is_mouse_over = true
	z_index = 1


func _on_SeedCard_mouse_exited():
	_is_mouse_over = false
	z_index = 0
