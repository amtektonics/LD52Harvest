extends Node

var seeds= {
	0:{"name":"Corn", "time":2, "health":4,"cost":1, "sell":3, "count":60, "icon":"res://Assets/Sprites/Seeds/CornSeed.png"},
	1:{"name":"Soy", "time":3, "health": 3, "cost":1, "sell":6, "count": 35, "icon":"res://Assets/Sprites/Seeds/Soy.png"},
	2:{"name":"Carrot", "time":4, "health": 4, "cost":2, "sell":7, "count":15, "icon":"res://Assets/Sprites/Seeds/Carrot.png"},
}

var buffs = {
	0:{"name":"Rain Storm", "health":2, "cost":2, "count": 20, "icon":"res://Assets/Sprites/Buffs/RainStorm.png"},
	1:{"name":"Irrigation", "health":3, "cost":5,"count": 10, "icon":"res://Assets/Sprites/Buffs/Irigatino.png"},
	2:{"name":"Pest Control", "health":5, "cost":7, "count": 5, "icon":"res://Assets/Sprites/Buffs/PestControl.png"},
}



var attacks = {
	1:{"x":0, "y":0, "count":30},
	2:{"x":0, "y":1, "count": 35},
	3:{"x":2, "y":3, "count":20},
	4:{"x":0, "y":4, "count":10},
	5:{"x":3, "y":5, "count":5},
	6:{"x":1, "y":3, "count":60}
	
}
