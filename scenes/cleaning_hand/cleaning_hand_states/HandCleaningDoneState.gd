class_name HandCleaningDoneState
extends HandState





# ====== PROCESS ====== #

func process_input(event: InputEvent) -> void:
    if event.is_pressed():
        var forensic := raycast_check_for_forensic_scientist() as ForensicScientist
        if is_instance_valid(forensic):
            if PlayerStatistics.current_framing_tool.clickable_zone.is_point_in_zone(forensic.foot_position.global_position):
                hide_crime_evidence_in_forensic(forensic)
        get_tree().root.set_input_as_handled()

# ====== MANAGEMENT ====== #

func enter()->void:
    Input.set_custom_mouse_cursor(cleaning_hand.cursor_outzone_aspect, Input.CURSOR_ARROW, Vector2(1,1))
    EventBus.FrozePlayerRequested.emit(false)
    EventBus.EnableFramingZoneDisplay.emit()
    return
    
func exit()->void:
    EventBus.EnableCleaningZoneDisplay.emit()
    return

func raycast_check_for_forensic_scientist()->CharacterBody2D:
    var space_state := cleaning_hand.get_world_2d().direct_space_state
    var query       := PhysicsPointQueryParameters2D.new()
    query.position   = cleaning_hand.get_global_mouse_position()
    query.collide_with_bodies = false
    query.collide_with_areas  = true
    query.collision_mask = GlobalSettings.LAYER_NAMES.DETECTION
    # ---
    var result :Array[Dictionary] = space_state.intersect_point(query)
    if (result.size()!=0):
        for i in result.size():
            var body :CharacterBody2D = (result[i].collider as Area2D).get_parent()
            if body.is_in_group("forensic_scientists"):
                return body
    # ---
    return null

func hide_crime_evidence_in_forensic(forensic:ForensicScientist)->void:
    if forensic.is_inspector:
        forensic.play_inspector_reveal()
        EventBus.SuspectCaught.emit(cleaning_hand.player)
        return
    # ---
    cleaning_hand.crime_evidence_hidden()
    ChangeStateRequested.emit(self, STATES.OutZone)
    return
