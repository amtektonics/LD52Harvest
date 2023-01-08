extends Area2D

var _active_seed = -1

var has_seed = false

var _stage = 0

var _max_stage = 0

var _health = 0

var _attack_queue = []

var _is_mouse_over = false

onready var GameStage = get_node("/root/StageHandler/GameStage")

onready var _field_info_label = $FieldInfo

onready var _health_sprite = $Health
onready var _health_label = $Health/HealthLabel

onready var _time_sprite = $Time
onready var _time_label = $Time/TimeLabel

onready var _attack_sprite = $Attack
onready var _attack_label = $Attack/AttackLabel
onready var _attack_seed_sprite = $Attack/AttackSeedSprite

onready var _click_to_harvest = $ClickToHarvest

onready var _effect_label = $EffectLabel

onready var _anim_player = $AnimationPlayer

func step():
	if(_active_seed != -1):
		if(_stage != _max_stage):
			_stage += 1
			_time_label.text = str(_stage) + "/" + str(_max_stage)
			if(_stage == _max_stage):
				_click_to_harvest.visible = true
		
	var attack_range = _attack_queue.pop_front()
	if(attack_range != Vector2.ZERO):
		var divisor = (int(attack_range.y) - int(attack_range.x) + 1)
		var attack = randi() % divisor + attack_range.x 
		damage(attack)
		
	if(_attack_queue.size() > 0):
		var next_range = _attack_queue[0]
		if(next_range != Vector2.ZERO):
			_attack_sprite.visible = true
			_attack_label.text = str(next_range.x) + "-" + str(next_range.y)
		else:
			_attack_sprite.visible = false
			_attack_label.text = ""

func harvest_field():
	#TODO coin animation
	var amount = CardRepo.seeds[_active_seed]["sell"]
	GameStage.add_money(amount)
	_effect_label.text = "+" + str(amount)
	_anim_player.play("Money")
	$Harvest.play()
	$Harvest.play()
	clear_field()

func kill_crop():
	#play sad sound/animatino
	clear_field()

func clear_field():
	_active_seed = -1
	_stage = 0
	_health_sprite.visible = false
	_time_sprite.visible = false
	_field_info_label.text = "Empty"
	_click_to_harvest.visible = false
	has_seed = false

func damage(amount:int):
	_effect_label.text = "-" + str(amount)
	_anim_player.play("Damage")
	_health -= amount
	_health_label.text = str(_health)
	if(_health <= 0):
		kill_crop()

func heal(amount:int):
	_effect_label.text = "+" + str(amount)
	_anim_player.play("Heal")
	_health += amount
	_health_label.text = str(_health)
	$Heal.play()

func queue_next_attack(attack_range:Vector2):
	_attack_queue.append(attack_range)


func set_seed(value):
	has_seed = true
	_active_seed = value 
	_stage = 0
	
	var name = CardRepo.seeds[_active_seed]["name"]
	var time = CardRepo.seeds[_active_seed]["time"]
	var health = CardRepo.seeds[_active_seed]["health"]
	
	_field_info_label.text = name
	
	_health_sprite.visible = true
	_health_label.text = str(health)
	_health = health
	
	_time_sprite.visible = true
	_time_label.text = str(_stage) + "/" + str(time)
	
	_max_stage = time
	$Plant.play()

func is_harvestable():
	return (_stage == _max_stage)

func _on_Field_mouse_entered():
	_is_mouse_over = true


func _on_Field_mouse_exited():
	_is_mouse_over = false


func _on_Field_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if(event.pressed && event.button_index == BUTTON_LEFT && _is_mouse_over):
			if(_stage >= _max_stage):
				harvest_field()
