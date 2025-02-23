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
    CONV.CONV_1_LEVEL:[
        ["Inspector 1", ["Well what have we got here?"]],
        ["Agent" , ["Hello, I'm here for the scene."]],
        ["Inspector 2", ["What a bloody mess. Hope we catch that one."]],
        ["Agent" , ["..."]],
    ],
    CONV.CONV_1_END:[
        ["Mme M", ["Thank you very much ! You saved my life!"]],
        ["Agent" , ["Just doin' my job."]],
        ["Mme M", ["Here's the rest of the money. Hope it's enough."]],
        ["Agent" , ["..."]],
        ["Mme M", ["I am again ery grateful... Although I might need your service again soon...this anoying neighbouring want to be singer..."]],
    ],
}
