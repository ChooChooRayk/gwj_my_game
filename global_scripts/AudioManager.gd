extends Node



enum BUS_TYPE {MASTER=0,MUSIC=1,SFX=2}
@export var bus_type:BUS_TYPE


# ====== MANAGEMENT ======  "

func play_audio(audio:AudioStream, single=false, transition=false)->void:
    # single : if we want audio to be the only thing that is played
    # transition : if we want some kind of fading effect
    if single:
        stop_audio()
    # ---
    var audio_player := find_first_unoccupied_audio_streamer()
    audio_player.stream = audio
    audio_player.play()
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
    
func audio_transition()->void:
    var init_vol_db :float=AudioServer.get_bus_volume_db(int(bus_type))
    AudioServer.set_bus_volume_db(int(bus_type), 0.)
    # DO STUFF
    AudioServer.set_bus_volume_db(int(bus_type), init_vol_db)
    # ---
    return
