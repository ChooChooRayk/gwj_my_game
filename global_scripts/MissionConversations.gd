class_name MissionConversations
extends Node

enum CONV {
    CONV_1_START,
    CONV_1_LEVEL,
    CONV_1_END,
    # ---
    CONV_2_START,
    CONV_2_LEVEL,
    CONV_2_END,
    # ---
}

static var conversation_dic := {
    CONV.CONV_1_START:[
        ["Mme M" , ["Hmm, hi.. Did I got your number right? The dark web is rather...obscure. I would like to request your services."]],
        ["Agent" , ["Hi. Depends on the service"]],
        ["Mme M", ["Well I made a rather small mistake, you see. I got very tired of the snoring sound and ..."]],
        ["Agent" , ["Don't need the detail. Where? When?"]],
        ["Mme M" , ["Thank you a lot, you seen I am not that bad... I'll send you the detail. Here's the start of the money.", "However, I hear there is this renowned investigator comming on the scene, one might want to hurry up."]],
        ["Agent" , ["I'll get to it."]],
    ],
}
