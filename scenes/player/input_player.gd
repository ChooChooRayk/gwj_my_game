class_name InputPlayer
extends Node

var player_body : BodyMotor
var is_player_frozen := false
var player_state_machine : PlayerStateMachine

# ====== INITIALIZATION =====+ #

func _ready() -> void:
    player_body = get_parent() as BodyMotor
    player_state_machine = Utilities.find_first_child_of_type(self, PlayerStateMachine) as PlayerStateMachine
    # ---
    EventBus.FrozePlayerRequested.connect(set_player_frozen)

# ====== PROCESS ===== #

func _process(_delta: float) -> void:
    if not is_player_frozen:
        player_body.movement_direction = Input.get_vector("left","right","up","down")
    else:
        player_body.movement_direction = Vector2.ZERO
    # ---  --- #
    return

# ====== MANAGEMENT ===== #


func set_player_frozen(is_frozen:bool)->void:
    is_player_frozen = is_frozen
