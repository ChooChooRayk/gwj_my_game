class_name PhoneCallAutoWrite
extends Node

signal WritingFinished()
signal TextUpdated(char:String)

@export var phone_transcription : PackedStringArray  = ["first line","second [b]line[/b]"]
var writing_speed       := 1. # [char/s]
var next_line_time      := 0.5 # [s]

var next_char_line_timer : Timer = Timer.new()
#var next_line_timer      : Timer = Timer.new()

var display_text : String = ""
var text_line    : String
var line_count   : int = 0
var char_count   : int = 0

var balise_known := [
    "b" ,"i" ,"u" ,"p" ,"s" ,
    "/b","/i","/u","/p","/s",
]

# ====== INITIALIZATION ====== #

func _ready() -> void:
    next_char_line_timer.wait_time = 1/writing_speed
    next_char_line_timer.one_shot  = false
    next_char_line_timer.autostart = false
    next_char_line_timer.timeout.connect(write_next_char_of_text_line)
    add_child(next_char_line_timer)
    # ---
    return

func init_phone_call_text()->void:
    display_text = ""

# ====== MANAGEMENT ====== #

func start_auto_write()->void:
    line_count = 0
    char_count = 0
    # ---
    text_line  = phone_transcription[line_count]
    next_char_line_timer.start()
    return

func end_phone_call()->void:
    next_char_line_timer.stop()
    WritingFinished.emit()
    return

func start_new_line()->void:
    if line_count>=phone_transcription.size():
        end_phone_call()
        return
    # ---
    await get_tree().create_timer(next_line_time).timeout
    # ---
    char_count = 0
    text_line  = phone_transcription[line_count]
    # ---
    display_text += "\n"
    TextUpdated.emit("\n")
    # ---
    print()
    next_char_line_timer.start()
    return

func write_next_char_of_text_line()->void:
    if char_count>=text_line.length():
        next_char_line_timer.stop()
        line_count += 1
        start_new_line()
        return
    # ---
    var next_char :String = text_line[char_count]
    if next_char=="[":
        var _balise_step = end_balise_detect()
        if _balise_step==-1:
            push_warning("some error in phone call")
            return
        next_char   = text_line.substr(char_count, _balise_step)
        char_count += _balise_step
    else:
        char_count += 1
    # ---
    display_text += next_char
    TextUpdated.emit(next_char)
    return

func end_balise_detect()->int:
    if text_line[char_count]!="[":
        return -1
    # ---
    var _count_tmp : int = 0
    for i in range(text_line.length()-char_count):
        if text_line[char_count+_count_tmp]=="]":
            break
        # ---
        _count_tmp += 1
    # ---
    var _balise = text_line.substr(char_count+1,_count_tmp-1)
    if _count_tmp==(text_line.length()-char_count):
        push_warning("No end balise found ...")
        return -1
    elif not balise_known.has(_balise):
        push_warning("Balise not recognized : ", _balise)
        return -1
    # ---
    return _count_tmp+1
