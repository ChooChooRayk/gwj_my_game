class_name AudioManager
extends Node



enum BUS_TYPE {MASTER=0,MUSIC=1,SFX=2}
@export var bus_type:BUS_TYPE

var bus_volume_db : float = 0.0:
    set = set_bus_volume
var bus_volume_multiplier :float= 0.0:
    set(value):
        bus_volume_multiplier = value
        AudioServer.set_bus_volume_db(int(bus_type), bus_volume_db - 80.*bus_volume_multiplier)

enum TRANS_TYPE {IN,OUT}
@export var trans_time :float=0.5 # [s]
var tween : Tween

# ====== INITIALIZATION ======  #

func _ready() -> void:
    bus_volume_db = AudioServer.get_bus_volume_db(int(bus_type))

# ====== MANAGEMENT ======  #

func set_bus_volume(value)->void:
    bus_volume_db = value
    AudioServer.set_bus_volume_db(int(bus_type), bus_volume_db - 80.*bus_volume_multiplier)
    return

func play_audio(audio:AudioStream, single=false, transition=false)->void:
    # single : if we want audio to be the only thing that is played
    # transition : if we want some kind of fading effect
    if single:
        stop_audio()
    # ---
    if single and transition:
        audio_transition(TRANS_TYPE.OUT)
        await tween.finished
    # ---
    print(bus_volume_db)
    print(bus_volume_multiplier)
    # ---
    var audio_player := find_first_unoccupied_audio_streamer()
    audio_player.stream = audio
    audio_player.play()
    # ---
    if single and transition:
        audio_transition(TRANS_TYPE.IN)
        await tween.finished
    # ---
    return
    
func find_first_unoccupied_audio_streamer()->AudioStreamPlayer:
    for audio_player:AudioStreamPlayer in get_children():
        if not audio_player.playing:
            return audio_player
    return null

func stop_audio()->void:
    for audio_player:AudioStreamPlayer in get_children():
        audio_player.stop()
    return
    
func audio_transition(trans_type:TRANS_TYPE)->void:
    tween = get_tree().create_tween()
    match trans_type:
        TRANS_TYPE.IN:
            tween.tween_property(self, "bus_volume_multiplier", 0.0, trans_time)
        TRANS_TYPE.OUT:
            tween.tween_property(self, "bus_volume_multiplier", 1.0, trans_time)
        _:
            pass
    tween.play()
    # ---
    return
