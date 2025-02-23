class_name Tutorial
extends CanvasLayer


@onready var tuto_panel_1: PanelContainer = %TutoPanel1
@onready var tuto_panel_2: PanelContainer = %TutoPanel2
@onready var tuto_panel_3: PanelContainer = %TutoPanel3

@onready var animation_player: AnimationPlayer = %AnimationPlayer

@export var wait_to_start      : float = 1. # [s]
@export var time_between_panel : float = 5. # [s]
@export var time_between_anim  : float = 2. # [s]
var panel_count    : int   = 0

var tuto_started   := false

var anim_keys_tuto_1  : Array[String] = ["mvmt_up_down","mvmt_right_left","drag_in_zone","cleaning"]
var anim_keys_tuto_2  : Array[String] = ["frame_forensic","inspector_detection_1","inspector_detection_2"]
var anim_keys_tuto_3  : Array[String] = ["under_cover_inpctr","under_cover_catch"]
var anim_keys_to_play : Array[String]

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
    # ---
    start_tuto_panel()

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
    await get_tree().create_timer(wait_to_start)
    # ---
    tuto_started      = true
    #get_tree().paused = true
    for i in range(4):
        await next_tuto_panel()
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
            anim_keys_to_play    = anim_keys_tuto_1.duplicate(true)
        1:
            tuto_panel_2.visible = true
            anim_keys_to_play    = anim_keys_tuto_2.duplicate(true)
        2:
            tuto_panel_3.visible = true
            anim_keys_to_play    = anim_keys_tuto_3.duplicate(true)
        _:
            GlobalSettings.current_game_settings["tutorial"] = false
            get_tree().paused = false
            queue_free()
            return
    # ---
    await play_totu_panel()
    await get_tree().create_timer(time_between_panel).timeout
    panel_count += 1
    return

# ------------ #

func play_totu_panel()->void:
    for key in anim_keys_to_play:
        animation_player.play(key)
        await animation_player.animation_finished
        var wait_time = time_between_anim
        if panel_count==0:
            wait_time = time_between_anim*0.3
        await get_tree().create_timer(wait_time).timeout

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
