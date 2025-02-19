class_name CleanableZone
extends Resource


@export var radius        := 10.
@export var ellps_e       := 1. # eccentricity = b/a
@export var center_offset := Vector2.ZERO
@export var center_zone   := Vector2.ZERO

var ellps_a       : float: #radius
    get:
        return radius
var ellps_b       : float: #ellps_a * ellps_e
    get:
        return radius * ellps_e

func is_point_in_zone(point:Vector2)->bool:
    return ((point-center_zone-center_offset)/Vector2(ellps_a,ellps_b)).length()<=1
