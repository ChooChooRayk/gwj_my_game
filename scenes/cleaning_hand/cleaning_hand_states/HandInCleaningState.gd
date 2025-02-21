class_name HandInCleaningState
extends HandState


var cleaning_progress : TextureProgressBar
var cleaning_timer : Timer
var follow_mouse   : FollowMouse

func _ready() -> void:
    super()
    # ---
    follow_mouse      = Utilities.find_first_child_of_type(self, FollowMouse) as FollowMouse
    cleaning_progress = Utilities.find_first_child_of_type(self, TextureProgressBar) as TextureProgressBar
    cleaning_timer    = Timer.new()
    cleaning_timer.timeout.connect(on_cleaning_done)
    add_child(cleaning_timer)
    
# ====== PROCESS ====== #

func _process(_delta: float) -> void:
    if not PlayerStatistics.current_cleaning_tool.clickable_zone.is_point_in_zone(cleaning_hand.get_global_mouse_position()):
        ChangeStateRequested.emit(self, STATES.OutZone)
    if not(cleaning_timer.is_stopped()):
        cleaning_progress.value = 100. * (1 - cleaning_timer.time_left / cleaning_timer.wait_time)

func process_input(event: InputEvent) -> void:
    if event.is_released():
        ChangeStateRequested.emit(self, STATES.InZone)
        get_tree().root.set_input_as_handled()

# ====== MANAGEMENT ====== #

func enter()->void:
    #cleaning animation ??? Input.set_custom_mouse_cursor(cleaning_hand.cursor_inzone_aspect, Input.CURSOR_ARROW, Vector2(1,1))
    cleaning_progress.value   = 0
    cleaning_progress.visible = true
    follow_mouse.follow_mouse_enable = true
    # ---
    cleaning_timer.wait_time = PlayerStatistics.current_cleaning_tool.cleaning_duration
    cleaning_timer.start()
    # ---
    EventBus.FrozePlayerRequested.emit(true)
    # ---
    set_process(true)
    return
    
func exit()->void:
    set_process(false)
    cleaning_timer.stop()
    cleaning_progress.visible = false
    follow_mouse.follow_mouse_enable = false
    #EventBus.EvidenceCleaningStopped.emit()
    # ---
    EventBus.FrozePlayerRequested.emit(false)
    return

func on_cleaning_done()->void:
    cleaning_hand.crime_evidence_cleaned()
    ChangeStateRequested.emit(self, STATES.CleaningDone)
