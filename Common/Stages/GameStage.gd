extends Node

var _money = 10

var _money_earned = 0

var _fields = []

var _should_spawn_seed = true

var _step_count = 0

onready var _money_label = $HudLayer/Hud/CoinTex/MoneyLabel

onready var _turn_label = $HudLayer/Hud/TurnLabel

onready var _popup_handler = $HudLayer/Hud/PopupHandler

onready var _seed_deck =  $SeedDeck

onready var _buff_deck = $BuffDeck

onready var _StageHandler = get_node("/root/StageHandler")

onready var _game_end_panel = $HudLayer/Hud/GameEndPanel

onready var _game_end_label = $HudLayer/Hud/GameEndPanel/CenterContainer/Panel/EndGameLabel


func _ready():
	randomize()
	_fields.append($Field)
	_fields.append($Field2)
	_fields.append($Field3)
	
	_money_label.text = str(_money)
	
	for f in _fields:
		f.queue_next_attack(Vector2(0, 0))
	
	for i in range(3):
		_seed_deck.spawn_random_card()
	
	_buff_deck.spawn_random_card()
	
	$BMusic.play()

func step():
	_money_label.text = str(_money)
	for f in _fields:
		var pull_list = []
		for a in CardRepo.attacks:
			var amount = CardRepo.attacks[a]["count"]
			for i in range(amount):
				pull_list.append(a)
				
		var index = randi() % pull_list.size()
		var x = CardRepo.attacks[pull_list[index]]["x"]
		var y = CardRepo.attacks[pull_list[index]]["y"]
		f.queue_next_attack(Vector2(x, y))
		f.step()
	
	_step_count += 1
	_turn_label.text = "Turn " + str(_step_count)
	
	if(_money > 0):
		if(_should_spawn_seed):
			_seed_deck.spawn_random_card()
		else:
			_buff_deck.spawn_random_card()
	else:
		var _harvestable = false
		for f in _fields:
			if(f.is_harvestable()):
				_harvestable = true
		if(!_harvestable):
			_game_end_panel.visible = true
			var val = "You survived for \n" + str(_step_count) + " Turns \nand made " + str(_money_earned)
			_game_end_label.text = val

func get_money():
	return _money

func add_money(amount:int):
	_money += amount
	_money_earned += amount
	_money_label.text = str(_money)

func remove_money(amount:int):
	if(_money < amount):
		return false
	_money -= amount
	if(_money == 0):
		#DO something here
		pass
	_money_label.text = str(_money)
	return true


#signal
func _on_EndTurnBtn_pressed():
	_popup_handler.visible = true


func _on_SeedBtn_pressed():
	_should_spawn_seed = true
	_popup_handler.visible = false
	step()


func _on_EffectBtn_pressed():
	_should_spawn_seed = false
	_popup_handler.visible = false
	step()


func _on_MusicButton_pressed():
	if($BMusic.is_playing()):
		$BMusic.stop()
	else:
		$BMusic.play()


func _on_EndGameBtn_pressed():
	_StageHandler.load_menu_stage()


func _on_CloseTutorialBtn_pressed():
	$HudLayer/Hud/TutorialPanel.visible = false


func _on_TutorialBtn_pressed():
	$HudLayer/Hud/TutorialPanel.visible = true


func _on_MenuBtn_pressed():
	_StageHandler.load_menu_stage()
