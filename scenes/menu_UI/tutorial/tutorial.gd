class_name Tutorial
extends CanvasLayer


@onready var tuto_bck_gnd: ColorRect      = %TutoBckGnd
@onready var tuto_panel_1: PanelContainer = %TutoPanel1
@onready var tuto_panel_2: PanelContainer = %TutoPanel2
@onready var tuto_panel_3: PanelContainer = %TutoPanel3
@onready var tuto_panel_4: PanelContainer = %TutoPanel4

@onready var animation_player: AnimationPlayer = %AnimationPlayer

@export var wait_to_start      : float = 1. # [s]
@export var time_between_panel : float = 3. # [s]
@export var time_between_anim  : float = 1. # [s]
var panel_count    : int   = 0
var panel_nbr_tot  : int   = 4
var tuto_started   := false

var anim_keys_tuto_1  : Array[String] = ["mvmt_up_down","mvmt_right_left","drag_in_zone","cleaning"]
var anim_keys_tuto_2  : Array[String] = ["frame_forensic","inspector_detection_1","inspector_detection_2"]
var anim_keys_tuto_3  : Array[String] = ["hiding_mechanic"]
var anim_keys_tuto_4  : Array[String] = ["under_cover_inpctr","under_cover_catch","timer_mechanic"]
var anim_keys_to_play : Array[String]

@export var debug := false

# ====== INITIALIZATION ====== #

func _ready() -> void:
    hide_all()
    # ---
    if !debug:
        process_mode = PROCESS_MODE_WHEN_PAUSED
        # ---
        if not(GlobalSettings.current_game_settings["tutorial"]):
            queue_free()
        else:
            EventBus.ChangeSceneFinished.connect(func ():start_tuto_panel())
    else:
        start_tuto_panel()

# ====== PROCESS ====== #

func _input(event: InputEvent) -> void:
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
        panel_count += 1
        #next_tuto_panel()
        key_interuption()
    elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.is_pressed():
        panel_count = maxi(0, panel_count-1)
        #next_tuto_panel()
        key_interuption()
    return

# ====== MANAGEMENT ====== #

func start_tuto_panel()->void:
    if !debug:
        get_tree().paused = true
    # ---
    tuto_bck_gnd.visible = true
    tuto_started      = true
    await get_tree().create_timer(wait_to_start).timeout
    # ---
    for i in range(panel_nbr_tot+1):
        await next_tuto_panel()
        panel_count += 1
    return

func hide_all()->void:
    tuto_bck_gnd.visible = false
    tuto_panel_1.visible = false
    tuto_panel_2.visible = false
    tuto_panel_3.visible = false
    tuto_panel_4.visible = false

func next_tuto_panel()->void:
    if not tuto_started:
        return
    # ---
    hide_all()
    tuto_bck_gnd.visible = true
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
        3:
            tuto_panel_4.visible = true
            anim_keys_to_play    = anim_keys_tuto_4.duplicate(true)
        _:
            GlobalSettings.current_game_settings["tutorial"] = false
            get_tree().paused = false
            queue_free()
            return
    # ---
    await play_totu_panel()
    await get_tree().create_timer(time_between_panel).timeout
    return

func key_interuption()->void:
    animation_player.stop()
    await next_tuto_panel()

# ------------ #

func play_totu_panel()->void:
    for i in range(anim_keys_to_play.size()):
        if i>=anim_keys_to_play.size():
            return
        var key = anim_keys_to_play[i]
        # ---
        animation_player.play(key)
        await animation_player.animation_finished
        # ---
        var wait_time = time_between_anim
        if panel_count==0:
            wait_time = time_between_anim*0.3
        if i == anim_keys_to_play.size()-1:
            wait_time = 0.1
        await get_tree().create_timer(wait_time).timeout

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
