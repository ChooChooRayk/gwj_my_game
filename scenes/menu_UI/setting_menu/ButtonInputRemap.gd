class_name ButtonInputRemap
extends Button
# from personnal toolbox : a button that remap inputs

@export var action : String
@export var event_idx:int=0

var current_event:InputEvent

# ====== INITIALIZATION ====== #

func _init() -> void:
    toggle_mode = true
    size_flags_horizontal = SizeFlags.SIZE_EXPAND_FILL
    
func _ready() -> void:
    #custom_minimum_size = Vector2(200,0)
    autowrap_mode = TextServer.AUTOWRAP_OFF
    clip_text     = true
    # ---
    set_process_unhandled_input(false)
    init_button_event()

func init_button_event()->void:
    current_event = InputMap.action_get_events(action)[event_idx]
    update_key_text()
    return

# ====== PROCESS ====== #

func _unhandled_input(event: InputEvent) -> void:
    if event.is_pressed():
        InputMap.action_erase_event(action, current_event)
        current_event = event
        InputMap.action_add_event(action, current_event)
        # ---
        button_pressed = false

# ====== MANAGEMENT ====== #

func update_key_text()->void:
    var event_list := InputMap.action_get_events(action)
    if event_idx>=event_list.size():
        push_error("not enough event in action")
        return
    # ---
    text = "{action_name}".format({"action_name":event_list[event_idx].as_text()})
    return

func _toggled(_toggled_on: bool) -> void:
    set_process_unhandled_input(button_pressed)
    if button_pressed:
        text = "... press input ..."
        release_focus()
    else:
        update_key_text()
        grab_focus()
    return
