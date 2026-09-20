extends Node

var coin_counter: int = 0
var total_coins: int = 0
var timer_length: float = 120
var start_time_msc: float = 0
var player: Player
var death_message: CanvasItem
var win_message: CanvasItem
var timer: SceneTreeTimer
var music: AudioStreamPlayer
var win_sound: AudioStreamPlayer

signal coin_counter_updated
signal game_failed
signal game_won

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func setup():
	print("setup")
	#setup coin counter
	coin_counter = 0
	total_coins = get_tree().get_nodes_in_group("coin").size()
	coin_counter_updated.emit()
	
	#setup timer
	start_time_msc = Time.get_ticks_msec()
	timer = get_tree().create_timer(timer_length)
	timer.timeout.connect(_on_timer_timout)
	
	#get player
	player = get_tree().get_nodes_in_group("player")[0]
	
	#get ui
	death_message = get_tree().get_nodes_in_group("death_message")[0]
	win_message = get_tree().get_nodes_in_group("win_message")[0]
	
	#get audio players
	music = get_tree().get_nodes_in_group("music")[0]
	win_sound = get_tree().get_nodes_in_group("win_sound")[0]





func collect_coin():
	coin_counter += 1
	coin_counter_updated.emit()
	print(coin_counter)
	if coin_counter >= total_coins:
		_on_all_coins_collected()


func _on_timer_timout():
	game_failed.emit()
	
	player.explode_violently()
	await get_tree().create_timer(1).timeout
	death_message.visible = true
	await get_tree().create_timer(8).timeout
	
	get_tree().reload_current_scene()


func _on_all_coins_collected():
	game_won.emit()
	timer.timeout.disconnect(_on_timer_timout)
	
	music.stop()
	win_sound.play()
	
	win_message.visible = true
	await get_tree().create_timer(3).timeout
	player.explode_violently()
	await get_tree().create_timer(5).timeout
	
	get_tree().reload_current_scene()
