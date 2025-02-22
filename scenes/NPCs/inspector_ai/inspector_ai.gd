class_name InspectorAI
extends Node

var cleaning_hand : CleaningHand

var npc_body       : BodyMotor
var detection_zone : Area2D
var looking_speed  := 10.
@onready var inspector_state_machine: InspectorStateMachine = $InspectorStateMachine

@onready var nav_agent_2d: NavigationAgent2D = %NavigationAgent2D
var target_position : Vector2 = Vector2.ZERO
var target_to_chase : BodyMotor

var go_to_target  := true

var current_path_pos_idx := 0
var path_index_list :Array[int]= []

# ====== INITIALIZATION ====== #

func _ready() -> void:
    npc_body        = get_parent() as Inspector
    npc_body.SPEED  = npc_body.scouting_speed
    # ---
    detection_zone  = Utilities.find_first_child_of_type(npc_body, Area2D)
    # ---
    nav_agent_2d.navigation_finished.connect(target_reached)
    # ---
    var path_length = (npc_body as Inspector).scouting_targets.curve.point_count
    for i in range(path_length):
        path_index_list.append(i)
    if path_length>=3:
        for i in range(path_length-2):
            path_index_list.append(path_length-2-i)
    # ---
    var level : Level = Utilities.find_first_parent_of_type(self, Level) as Level
    if is_instance_valid(level):
        cleaning_hand = Utilities.find_first_child_of_type(level, CleaningHand) as CleaningHand
    return

# ====== PROCESS ====== #

func _process(delta: float) -> void:
    if go_to_target:
        npc_body.movement_direction  = npc_body.global_position.direction_to(nav_agent_2d.get_next_path_position()).normalized()
        manage_detection_zone(delta)
    else:
        npc_body.movement_direction  = Vector2.ZERO
    # ---

# ====== MANAGEMENT ====== #

func move_to(target_pos:Vector2)->void:
    target_position = target_pos
    nav_agent_2d.target_position = target_position

func target_reached()->void:
    go_to_target = false
    inspector_state_machine.target_reached()
    return

func move_to_next_path_position()->void:
    current_path_pos_idx += 1
    current_path_pos_idx  = current_path_pos_idx%path_index_list.size()
    # ---
    var next_path_pos_idx := path_index_list[current_path_pos_idx]
    var next_target_pos   := (npc_body as Inspector).scouting_targets.curve.get_point_position(next_path_pos_idx)
    move_to(next_target_pos)
    go_to_target = true
    return

func manage_detection_zone(delta:float)->void:
    var to_agl := npc_body.movement_direction.angle()
    detection_zone.rotation = lerp(detection_zone.rotation, to_agl, looking_speed*delta)
    detection_zone.scale    = Vector2(0.5+abs(cos(to_agl))/2., 1.)
    return
    
func on_player_deteted(body:Node2D)->void:
    if body.is_in_group("player"):
        var player := body as BodyMotor
        var cleaning_state:HandState.STATES = cleaning_hand.hand_state_machine.current_state.state
        if cleaning_state==HandState.STATES.InCleaning or cleaning_state==HandState.STATES.CleaningDone:
            EventBus.SuspectDetected.emit(player)
            target_to_chase = player
        pass
