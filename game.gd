extends Node2D


# Called when the node enters the scene tree for the first time.
enum SUITS {SPADE, CLUB, DIAMOND, HEART}
var deck : Deck
var current_index = 0
var next_landmark = 0
var aceObjects = []
var landmarkObjects = []
@onready var cardObject = preload("res://nodes/card.tscn")


func _ready() -> void:
	deck = Deck.new()
	deck.shuffle()
	deck.move_aces_top()
	init_aces()
	init_landmarks()
	
func prepare_card(card, pos, angle=-90):
	card.set_card(deck.get_card(current_index))
	card.rotation_degrees = angle
	card.scale=Vector2(0.6,0.6)
	card.position = pos
	current_index+=1

func init_aces():
	for i in range(4):
		var card = cardObject.instantiate()
		add_child(card)
		aceObjects.append(card)
		
		var position = Vector2(135, 200 + 200*(i+1))
		prepare_card(card, position)
		card.flip_over()
		
func init_landmarks():
	for i in range(6):
		var card = cardObject.instantiate()
		add_child(card)
		landmarkObjects.append(card)
		
		var position = Vector2(135 + 250*i, 200)
		prepare_card(card, position)


class Deck:
	var _order = []
	
	func _init()->void:
		for suit in SUITS:
			for i in range(1,14):
				_order.append({"value" : _get_value_from_num(i), "suit": suit})
	func shuffle():
		randomize()
		_order.shuffle()
	func add_card(value, suit):
		_order.append({"value" : value, "suit": suit})
	func get_card(index):
		if typeof(index) != TYPE_INT:
			return false
		if index < 0:
			return false
		if index > len(_order):
			return false
		return _order[index]
	func move_aces_top():
		var indices = []
		for i in range(len(_order)):
			var card = _order[i]
			if card["value"] == "A":
				indices.append(i)
		
		for i in range(4):
			var tmp_card = _order[i]
			_order[i] = _order[indices[i]]
			_order[indices[i]] = tmp_card
			
		var suits = ["SPADE", "CLUB", "DIAMOND", "HEART"]
		for i in range(4):
			var ace = _order[i]
			ace["suit"] = suits[i]
	func _get_value_from_num(num):
		if typeof(num) != TYPE_INT:
			return
		if num < 1 or num > 13:
			return
		match num:
			1:
				return "A"
			11:
				return "J"
			12:
				return "Q"
			13:
				return "K"
			_:
				return str(num)
