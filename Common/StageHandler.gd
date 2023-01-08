extends Node

var _active_stage = null

onready var _game_stage = load("res://Common/Stages/GameStage.tscn")

onready var _menu_stage = load("res://Common/Stages/MenuStage.tscn")

func _ready():
	load_menu_stage()


func load_game_stage():
	if(_active_stage != null):
		_active_stage.queue_free()
		_active_stage = null
	
	_active_stage = _game_stage.instance()
	add_child(_active_stage)


func load_menu_stage():
	if(_active_stage != null):
		_active_stage.queue_free()
		_active_stage = null
	
	_active_stage = _menu_stage.instance()
	add_child(_active_stage)
