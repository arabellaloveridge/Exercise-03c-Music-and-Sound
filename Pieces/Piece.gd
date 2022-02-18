extends Node2D

export (String) var color
var is_matched
var is_counted
var selected = false
var target_position = Vector2.ZERO

var Effects = null
var dying = false
var wiggle = 0.0
export var wiggle_amount = 3

export var transparent_time = 1.0
export var scale_time = 1.5
export var rot_time = 1.5

onready var Sound1 = get_node("/root/Game/Sound 1")
onready var Sound2 = get_node("/root/Game/Sound 2")
onready var Sound3 = get_node("/root/Game/Sound 3")

var Coin = preload("res://Coin/Coin.tscn")

func _ready():
	$Select.texture = $Sprite.texture
	$Select.scale = $Sprite.scale

func _physics_process(_delta):
	if dying:
		queue_free()
	elif position != target_position:
		position = target_position
	if selected:
		$Select.show()
		$Selected.emitting = true
		Sound1.play_sound()
	else:
		$Select.hide()
		$Selected.emitting = false

func generate(pos):
	position = Vector2(pos.x,-100)
	target_position = pos

func move_piece(change):
	target_position = target_position + change

func die():
	dying = true;
	Sound3.play_sound()
	if Effects == null:
		Effects = get_node_or_null("/root/Game/Effects")
	if Effects != null:
		var coin = Coin.instance()
		coin.position = target_position
		Effects.add_child(coin)
		Sound2.play_sound()
	
