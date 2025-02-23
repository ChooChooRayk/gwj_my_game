class_name MissionResource
extends Resource

@export var time_to_succeed       : float # [s]
@export var crime_evidence_number : int
@export var money_start_mission   : int = 100 # [$USD]
@export var money_reward          : int = 200 # [$USD]
@export var mission_call_start    : MissionConversations.CONV
@export var mission_conversation  : MissionConversations.CONV
@export var mission_call_success  : MissionConversations.CONV
@export var level_music           : AudioStream
@export_category("Level scene")
@export var mision_level          : PackedScene
