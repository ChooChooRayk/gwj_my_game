class_name SfxUiSetter
extends Node

@export var sfx_hover : AudioStream
@export var sfx_click : AudioStream

var parent_ctrl : Control

# ====== INITIALIZATION ====== #

func _ready() -> void:
    parent_ctrl = get_parent()
    if not(is_instance_valid(parent_ctrl)):
        push_error("Noe control parent for SfxUiSetter.")
        queue_free()
    # ---
    if is_instance_valid(sfx_hover):
        parent_ctrl.mouse_entered.connect(play_hover)
    # ---
    if is_instance_valid(sfx_click):
        if   (parent_ctrl is ShopItemUI) or (parent_ctrl is InventoryToolStack):
            parent_ctrl.double_ckicked.connect(play_clicked)
        elif (parent_ctrl is Button):
            parent_ctrl.pressed.connect(play_clicked)        
        
    # ---


# ====== MANAGEMENT ====== #

func play_hover()->void:
    SFXManager.play_audio(sfx_hover)
    return

func play_clicked()->void:
    SFXManager.play_audio(sfx_click)
    return
