class_name Tutorial
extends CanvasLayer


@onready var tuto_panel_1: PanelContainer = %TutoPanel1
@onready var tuto_panel_2: PanelContainer = %TutoPanel2
@onready var tuto_panel_3: PanelContainer = %TutoPanel3

var panel_count    : int   = 0
var wait_time_read : float = 2. # [s]

var tuto_started   := false

# ====== INITIALIZATION ====== #

func _ready() -> void:
    hide_all()
    # ---
    process_mode = PROCESS_MODE_WHEN_PAUSED
    # ---
    if not(GlobalSettings.current_game_settings["tutorial"]):
        queue_free()
    else:
        EventBus.ChangeSceneFinished.connect(func ():start_tuto_panel())
    return

# ====== PROCESS ====== #

func _input(event: InputEvent) -> void:
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
        next_tuto_panel()
    elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.is_pressed():
        panel_count = maxi(0, panel_count-1)
        next_tuto_panel()
    return

# ====== MANAGEMENT ====== #

func start_tuto_panel()->void:
    tuto_started      = true
    get_tree().paused = true
    for i in range(4):
        next_tuto_panel()
        await get_tree().create_timer(wait_time_read).timeout
    return

func hide_all()->void:
    tuto_panel_1.visible = false
    tuto_panel_2.visible = false
    tuto_panel_3.visible = false

func next_tuto_panel()->void:
    if not tuto_started:
        return
    # ---
    hide_all()
    match panel_count:
        0:
            tuto_panel_1.visible = true
        1:
            tuto_panel_2.visible = true
        2:
            tuto_panel_3.visible = true
        _:
            GlobalSettings.current_game_settings["tutorial"] = false
            get_tree().paused = false
            queue_free()
            return
    panel_count += 1
    return
