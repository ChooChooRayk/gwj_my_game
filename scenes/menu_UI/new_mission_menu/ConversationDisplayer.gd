class_name ConversationDisplayer
extends RichTextLabel

@export var writing_speed       := 1. # [char/s]
@export var next_line_time      := 0.5 # [s]

@export var conversation : Array = [
    ["caller", ["first line","second [b]line[/b]"]],
    ["agent", ["first response","second [i]response[/i]"]],
    ["caller", ["first line","second [b]line[/b]"]],
    ["agent", ["first response","second [i]response[/i]"]],
]
var caller_count : int = 0

var auto_writer : PhoneCallAutoWrite = PhoneCallAutoWrite.new()
var finished_text     := ""
var caller_title      := ""
var caller_text       := ""
var wrapped_text      := ""

var caller_display_stye := {
    0 : {"side":"left", "color":"green"},
    1 : {"side":"right", "color":"red"},
}
var side_count : int = 0

# ====== INITIALIZATION ====== #

func _ready() -> void:
    bbcode_enabled   = true
    scroll_following = true
    # ---
    auto_writer.writing_speed  = writing_speed
    auto_writer.next_line_time = next_line_time
    auto_writer.WritingFinished.connect(next_caller_text)
    auto_writer.TextUpdated    .connect(add_char_to_text_to_displayed_text)
    add_child(auto_writer)
    # ---
    set_process(false)
    # ---
    start_conversation()

# ====== PROCESS ====== #

func _process(_delta: float) -> void:
    text = finished_text + wrapped_text

# ====== MANAGEMENT ====== #

func start_conversation()->void:
    print("starting conversation")
    caller_text       = ""
    finished_text     = ""
    # ---
    set_process(true)
    make_caller_text()
    return

func stop_conversation()->void:
    set_process(false)
    print("conversation finished")
    return

func next_caller_text()->void:
    finished_text  += wrapped_text + "[/{side}]".format({"side":caller_display_stye[side_count]["side"]})
    caller_count   += 1
    side_count      = (side_count+1)%2
    make_caller_text()
    return

func make_caller_text()->void:
    set_process(false)
    wrapped_text    = ""
    caller_text     = ""
    # ---
    if caller_count>=conversation.size():
        stop_conversation()
        return
    # ---
    var caller_dialog        := conversation[caller_count] as Array
    var caller_transcription := caller_dialog[1] as PackedStringArray 
    var caller_name          := caller_dialog[0] as String
    # ---
    caller_title = "[color={color}][b]{name}:[/b][/color]\n".format({
        "color":caller_display_stye[side_count]["color"],
        "name":caller_name,
        })
    # ---
    auto_writer.phone_transcription = caller_transcription
    auto_writer.init_phone_call_text()
    auto_writer.start_auto_write()
    set_process(true)
    return

func add_char_to_text_to_displayed_text(_char:String)->void:
    caller_text      = caller_title + auto_writer.display_text
    #wrapped_text     = "[{side}]{text}[/{side}]".format({
    wrapped_text     = "[{side}]{text}".format({
        "text":caller_text,
        "side":caller_display_stye[side_count]["side"],
    })
