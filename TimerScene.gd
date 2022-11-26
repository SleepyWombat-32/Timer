extends Control
var hours 
var minutes
var seconds

var paused = false
func _on_StartTimerButton_pressed():
	hours = $Time/Hours.text as int 
	minutes = $Time/Minutes.text as int
	seconds = $Time/Seconds.text as int 

	var time = (hours * 3600)\
	 + (minutes * 60)\
	 + (seconds)
	$Timer.wait_time = time
	$Timer.start()
	


func _on_SecondTimer_timeout():
	var h = calculate_hours()
	var m = calculate_minutes()
	var s = calculate_seconds()
	update_timer_text(h, m, s)

func update_timer_text(h : String, m : String, s : String):
	$TimeLeft/Hours.text = h
	$FullScreenPopup/TimeLeft/Hours.text = h
	
	$TimeLeft/Minutes.text = m
	$FullScreenPopup/TimeLeft/Minutes.text = m
	
	$TimeLeft/Seconds.text = s
	$FullScreenPopup/TimeLeft/Seconds.text = s

func calculate_hours():
	var h_to_display : int = $Timer.time_left / 3600
	if h_to_display == 1:
		return "1 hour"
	elif h_to_display == 0:
		return ""
	else:
		return str(h_to_display) + " hours"
func calculate_minutes():
	var m_to_display : int = int(($Timer.time_left / 60)) % 60
	if m_to_display == 1:
		return "1 minute"
	elif m_to_display == 0:
		return ""
	else:
		return str(m_to_display) + " minutes"
func calculate_seconds():
	var s_to_display : int = int(($Timer.time_left)) % 60
	if s_to_display == 1:
		return "1 second"
	elif s_to_display == 0:
		return ""
	else:
		return str(s_to_display) + " seconds"

func _on_Hours_text_entered(new_text):
	$Time/Minutes.grab_focus()
	$Time/Minutes.caret_position = len($Time/Minutes.text)

func _on_Minutes_text_entered(new_text):
	$Time/Seconds.grab_focus()
	$Time/Seconds.caret_position = len($Time/Seconds.text)
func _on_Seconds_text_entered(new_text):
	pass


func _on_FullScreen_pressed():
	if $FullScreenPopup.visible:
		$FullScreenPopup.hide()
	else:
		$FullScreenPopup.show()
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		$FullScreenPopup.hide()
		if $TimerFinished.playing:
			$TimerFinished.playing = false
	elif event.is_action_pressed("ui_select"): # space
		$Timer.paused = !paused
		paused = !paused


func _on_Timer_timeout():
	$TimerFinished.play()
	$StartTimerButton.hide()
	$StopTimerButton.show()
	$FullScreenPopup/Label.show()
	yield(get_tree().create_timer(1), "timeout")
	$FullScreenPopup/Label.hide()
func _on_StopTimerButton_pressed():
	$TimerFinished.stop()
	$StartTimerButton.show()
	$StopTimerButton.hide()
