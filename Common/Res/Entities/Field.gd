extends Area2D

var active_seed = 0

var has_seed = false

var stage = 0

var _max_stage = 0

var _health = 0

onready var _field_info_label = $FieldInfo

onready var _health_sprite = $Health
onready var _health_label = $Health/HealthLabel

onready var _time_sprite = $Time
onready var _time_label = $Time/TimeLabel

func set_seed(value):
	has_seed = true
	active_seed = value 
	stage = 0
	
	var name = CardRepo.seeds[active_seed]["name"]
	var time = CardRepo.seeds[active_seed]["time"]
	var health = CardRepo.seeds[active_seed]["health"]
	
	_field_info_label.text = name
	
	_health_sprite.visible = true
	_health_label.text = str(health)
	_health = health
	
	_time_sprite.visible = true
	_time_label.text = str(stage) + "/" + str(time)
	
	_max_stage = time

func clear_field():
	active_seed = 0
	_health_sprite.visible = false
	_time_sprite.visible = false
	_field_info_label.text = "Empty"

func step():
	if(stage != _max_stage):
		stage += 1
		_time_label.text = str(stage) + "/" + str(_max_stage)
