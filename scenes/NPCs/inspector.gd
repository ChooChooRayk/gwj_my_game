class_name Inspector
extends BodyMotor

@export var scouting_targets: Path2D
@export var scouting_speed  := 50.

@onready var catching_zone: Area2D = %CatchingZone
