class_name AllowedCleaningZone
extends Node2D


@export var cleanable_zone : CleanableZone

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
    #cleanable_zone._init()
    #print(cleanable_zone.ellps_a)
    #print(cleanable_zone.ellps_b)
    player_body = get_parent()

# ====== PROCESS ====== #

func _draw() -> void:
    var points_arr := PackedVector2Array()
    for i in range(pts_nbr):
        var agl    := TAU * float(i)/float(pts_nbr) + dash_offset
        var new_pt := Vector2(
            cleanable_zone.ellps_a*cos(agl),
            cleanable_zone.ellps_b*sin(agl),
        )
        new_pt += cleanable_zone.center_offset
        points_arr.append(new_pt)
        # ---
    draw_multiline(points_arr, color, line_width)
    return
    
func _process(delta: float) -> void:
    queue_redraw()
    cleanable_zone.center_zone = player_body.global_position
    dash_offset += dash_speed*delta
