class_name HandOutZoneState
extends HandState

var default_cursor : Texture2D = load("res://assets/icons/cursor.svg") as Texture2D

# ====== PROCESS ====== #

func _process(_delta: float) -> void:
    update_state()

# ====== MANAGEMENT ====== #

func enter()->void:
    #Input.set_custom_mouse_cursor(default_cursor)
    EventBus.EnableCleaningZoneDisplay.emit()
    set_process(true)
    return

func exit()->void:
    set_process(false)
    return

func update_state()->void:
    if cleaning_hand.cleaning_tool.clickable_zone.is_point_in_zone(cleaning_hand.get_global_mouse_position()):
        ChangeStateRequested.emit(self, STATES.InZone)
    return
