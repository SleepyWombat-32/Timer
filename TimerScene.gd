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
	var h_to_display : int = 0
	h_to_display = $Timer.time_left / 3600
	var m_to_display : int = ($Timer.time_left / 60) - (h_to_display * 60)
	var s_to_display : int = $Timer.time_left - (h_to_display * 3600) - (m_to_display * 60)
	var to_display : String
	if h_to_display == 0:
		to_display = str(m_to_display) + " Minutes  " + \
	str(s_to_display) + " Seconds  "
	elif hours == 1:
		to_display = str(h_to_display) + " Hour  " + \
		str(m_to_display) + " Minutes  " + \
		str(s_to_display) + " Seconds  "
	else:
		to_display = str(h_to_display) + " Hours  " + \
		str(m_to_display) + " Minutes  " + \
		str(s_to_display) + " Seconds  "
	$TimeLeft.text = to_display
	$FullScreenPopup/Label.text = to_display

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

func _on_StopTimerButton_pressed():
	$TimerFinished.stop()
	$StartTimerButton.show()
	$StopTimerButton.hide()
