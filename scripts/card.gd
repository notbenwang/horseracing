extends Node2D

@onready var cardback: Sprite2D = $Cardback
#@onready var cardfront: ColorRect = $ColorRect
@onready var labels: Node2D = $Labels

@onready var toplabel: Label = $cardfront/Labels/toplabel
@onready var botlabel: Label = $cardfront/Labels/botlabel
@onready var cardfront: Node2D = $cardfront

@onready var clubs: Node2D = %Clubs
@onready var spades: Node2D = %Spades
@onready var diamonds: Node2D = %Diamonds
@onready var hearts: Node2D = %Hearts

enum SUITS {SPADE, CLUB, DIAMOND, HEART}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#set("theme_override_colors/font_color", Color.RED)
	#change_label_value("7")
	#change_label_colors(Color.RED)
	pass # Replace with function body.

func change_label_colors(color: Color):
	toplabel.add_theme_color_override("font_color", color)
	botlabel.add_theme_color_override("font_color", color)

func change_label_value(text : String):	
	toplabel.text = text
	botlabel.text = text

func set_card(card):
	print(card["value"])
	change_label_value(card["value"])
	set_suit(card["suit"])
	if card["suit"] == "DIAMOND" or card["suit"] == "HEART":
		change_label_colors(Color.RED)
	else:
		change_label_colors(Color.BLACK)
func set_suit(suit : String):
	spades.visible = false
	clubs.visible = false
	diamonds.visible = false
	hearts.visible = false	
	
	match(suit):
		"SPADE":
			spades.visible =true
		"CLUB":
			clubs.visible=true
		"DIAMOND":
			diamonds.visible=true
		"HEART":
			hearts.visible=true
			
func flip_over():
	cardback.visible = not cardback.visible
	cardfront.visible = not cardfront.visible

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("Click"):
		flip_over()
		pass
