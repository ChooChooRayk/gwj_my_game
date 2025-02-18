class_name Tutorial
extends CanvasLayer


@onready var tuto_panel_1: PanelContainer = %TutoPanel1
@onready var tuto_panel_2: PanelContainer = %TutoPanel2
@onready var tuto_panel_3: PanelContainer = %TutoPanel3

var panel_count    : int   = 0
var wait_time_read : float = 2. # [s]

# ====== INITIALIZATION ====== #

func _ready() -> void:
    tuto_panel_1.visible = false
    tuto_panel_2.visible = false
    tuto_panel_3.visible = false
    # ---
    process_mode = PROCESS_MODE_WHEN_PAUSED
    # ---
    var settings := Utilities.find_first_child_of_type(get_tree().root, SettingsMenu) as SettingsMenu
    if is_instance_valid(settings):
        if not(settings.setting_wdgt_dic["tutorial"]):
            queue_free()
        else:
            EventBus.ChangeSceneFinished.connect(func ():start_tuto_panel())
    return

# ====== PROCESS ====== #

func _input(event: InputEvent) -> void:
    if event.is_pressed():
        next_tuto_panel()
    return

# ====== MANAGEMENT ====== #

func start_tuto_panel()->void:
    get_tree().paused = true
    for i in range(4):
        next_tuto_panel()
        await get_tree().create_timer(wait_time_read).timeout
    return

func next_tuto_panel()->void:
    print(panel_count)
    match panel_count:
        0:
            tuto_panel_1.visible = true
        1:
            tuto_panel_1.visible = false
            tuto_panel_2.visible = true
        2:
            tuto_panel_2.visible = false
            tuto_panel_3.visible = true
        _:
            print("tuto finished")
            get_tree().paused = false
            queue_free()
            return
    panel_count += 1
    return
