class_name InputRemappingSettings
extends PanelContainer
# from personal toolbox : extand panel to initialize the input remaping

var grid_cont : GridContainer = GridContainer.new()
var button_remap_L : Array[ButtonInputRemap] = []

func _ready() -> void:
    grid_cont.columns = 2
    add_child(grid_cont)
    # ---
    init_action_list()
    
func init_action_list()->void:
    for action in InputMap.get_actions():
        if not("ui_" in action):
            var label:Label = Label.new()
            label.text = action
            var remap_button : ButtonInputRemap = ButtonInputRemap.new()
            remap_button.action    = action
            remap_button.event_idx = 0
            button_remap_L.append(remap_button)
            # ---
            grid_cont.add_child(label)
            grid_cont.add_child(remap_button)
    return

# ====== MANAGEMENT ====== #

func reset_settings()->void:
    InputMap.load_from_project_settings()
    for _bttn in button_remap_L:
        _bttn.init_button_event()
    return
