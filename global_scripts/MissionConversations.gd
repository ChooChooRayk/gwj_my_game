class_name MissionConversations
extends Node

enum CONV {
    CONV_1,
}

static var conversation_dic := {
    CONV.CONV_1:[
        ["caller", ["first line","second [b]line[/b]"]],
        ["agent" , ["first response","second [i]response[/i]"]],
        ["caller", ["first line","second [b]line[/b]"]],
        ["agent" , ["first response","second [i]response[/i]"]],
    ],
}
