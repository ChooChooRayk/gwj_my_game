extends CanvasLayer

@onready var victory: Control = $Victory
@onready var defeat: Control = $Defeat


func _ready() -> void:
    EventBus.SuspectCaught.connect(on_suspect_caught)

func on_suspect_caught(body:BodyMotor)->void:
    defeat.visible = true
    get_tree().paused = true
    return
