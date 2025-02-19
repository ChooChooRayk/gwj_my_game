class_name ClickableZoneDisplayer
extends Node2D


@export var clickable_zone : ClickableZone

@export var pts_nbr     := 50
@export var line_width  := 5.
@export var color       := Color.WHITE
@export var dash_speed  := 0.1
var dash_offset         := 0.

var player_body : BodyMotor

var enable_cleaning_zone :bool = true:
    set(value):
        set_process(value)
        enable_cleaning_zone = value

# ====== INITIALIZATION ====== #

func _ready() -> void:
    player_body = get_parent()

# ====== PROCESS ====== #

func _draw() -> void:
    var points_arr := PackedVector2Array()
    for i in range(pts_nbr):
        var agl    := TAU * float(i)/float(pts_nbr) + dash_offset
        var new_pt := Vector2(
            clickable_zone.ellps_a*cos(agl),
            clickable_zone.ellps_b*sin(agl),
        )
        new_pt += clickable_zone.center_offset
        points_arr.append(new_pt)
        # ---
    draw_multiline(points_arr, color, line_width)
    return
    
func _process(delta: float) -> void:
    queue_redraw()
    clickable_zone.center_zone = player_body.global_position
    dash_offset += dash_speed*delta

# ====== MANAGEMENT ====== #

func enable_zone_aspect(_enable:bool)->void:
    visible = _enable
    set_process(_enable)
