extends Node

var _money = 10

var _fields = []

onready var _money_label = $HudLayer/Hud/CoinTex/MoneyLabel

func _ready():
	_fields.append($Field)
	_fields.append($Field2)
	_fields.append($Field3)
	
	_money_label.text = str(_money)

func step():
	_money_label.text = str(_money)
	for f in _fields:
		f.step()




func _on_EndTurnBtn_pressed():
	step()
