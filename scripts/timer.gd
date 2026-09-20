extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var time_passed = Time.get_ticks_msec()
	var timer_length = StuffManager.timer_length * 1000
	var time_started = StuffManager.start_time_msc
	text = "Time: " + format_m_ss_mmm_from_msec(timer_length - (time_passed - time_started))


func format_m_ss_mmm_from_msec(time):
	time = abs(time)
	return str(floori(time/60000)%60) + ":" + str(floori(time/1000)%60).pad_zeros(2) + "." + str(floori(time)%1000).pad_zeros(3)
