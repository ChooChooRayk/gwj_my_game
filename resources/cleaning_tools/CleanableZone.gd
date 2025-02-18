class_name CleanableZone
extends Resource


@export var ellps_a       := 1.
@export var ellps_b       := 1.
@export var center_offset := Vector2.ZERO
@export var center_zone   := Vector2.ZERO


func is_point_in_zone(point:Vector2)->bool:
    return ((point-center_zone-center_offset)/Vector2(ellps_a,ellps_b)).length()<=1
