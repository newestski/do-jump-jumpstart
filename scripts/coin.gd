extends Node2D

@onready var area_2d: Area2D = $Area2D
@onready var audio_coin: AudioStreamPlayer2D = $AudioCoin

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_2d.body_entered.connect(_on_collect)


func _on_collect(_body):
	StuffManager.collect_coin()
	audio_coin.pitch_scale = randf_range(0.9, 1.1)
	audio_coin.play()
	visible = false
	area_2d.set_deferred("monitoring", false)
	await audio_coin.finished
	queue_free()
