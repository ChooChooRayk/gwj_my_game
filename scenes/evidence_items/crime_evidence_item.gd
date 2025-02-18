class_name CrimeEvidenceItem
extends Area2D

var is_cleaned := false
@export var dirty_aspect   : Texture2D
@export var cleaned_aspect : Texture2D

@onready var item_aspect: Sprite2D = %ItemAspect
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

# ====== INITIALIZATION ====== #

func _ready() -> void:
    if is_instance_valid(dirty_aspect):
        item_aspect.texture = dirty_aspect

# ====== MANAGEMENT ====== #

func set_cleaned()->void:
    is_cleaned = true
    if is_instance_valid(cleaned_aspect):
        item_aspect.texture = cleaned_aspect
    # ---
    collision_shape_2d.disabled = true
    disable_highlight_effect()

func disable_highlight_effect()->void:
    item_aspect.material = null
