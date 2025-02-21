class_name Inspector
extends BodyMotor

@export var scouting_targets: Path2D
@export var scouting_speed  := 50.

@onready var catching_zone: Area2D = %CatchingZone

# ====== INITIALIZATION ====== #

#func _ready() -> void:
    #catching_zone.body_entered.connect(on_catching_body)

# ====== MANAGEMENT ====== #

func on_catching_body(body:Node2D)->void:
    if body.is_in_group("player"):
        EventBus.SuspectCaught.emit(body)
    return
