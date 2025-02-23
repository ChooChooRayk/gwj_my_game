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
    CONV_3_START,
    CONV_3_LEVEL,
    CONV_3_END,
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
    # ------ #
    CONV.CONV_2_START:[
        ["D0nC0rn3rt!o" , ["Good evening, sir. I require your service as soon as possible."]],
        ["Agent" , ["I'm listening."]],
        ["D0nC0rn3rt!o", ["I sent my dear nephew to resolve a business matter, if you follow me. However my nephew is a messy little fella. See what I mean ?"]],
        ["Agent" , ["I think I do."]],
        ["D0nC0rn3rt!o" , ["Good, good.", "Then I can count on you. I'm very generous with people that satisfies me... and with the poeple that doesn't, well I send my nephew."]],
        ["Agent" , ["Don't worry it wiil be done."]],
        ["D0nC0rn3rt!o" , ["By the, theres' this investigator that seems quite motivated to solve all those ... unsolved accidents. I would suggest you to work quickly."]],
    ],
    CONV.CONV_2_LEVEL:[
        ["Inspector 1", ["Geez, this what a mess this one is. No doubt who did that but where are the traces?"]],
        ["Agent" , ["Hi, just passing by. I brought you coffee."]],
        ["Inspector 2", ["Thanks I needed that !"]],
        ["Agent" , ["..."]],
        ["Inspector 3" , ["First time on the job, and I got this case. No clue what's happened here."]],
        ["Agent" , ["Not really my place, but probably an accident."]],
        ["Inspector 3" , ["I really doubt it..."]],
        ["Agent" , ["..."]],
    ],
    CONV.CONV_2_END:[
        ["D0nC0rn3rt!o", ["Well done, agent, I never doubted you. I'll send you the rest of your reward diligently."]],
        ["Agent" , ["No worry."]],
        ["Mme M", ["I'll make sure to save you place in my contacts."]],
        ["Agent" , ["...thank you sir."]],
    ],
    # ------ #
    CONV.CONV_3_START:[
        ["P*!&0" , ["Hmm hello ? Very sorry to bother you, but it's urgent. I'm a friend of your son, and he's in it too."]],
        ["Agent" , ["What!!"]],
        ["P*!&0", ["Yeeeeaaah, we wanted to proceed in some kind of ritual, but it turned out the material was no right..."]],
        ["Agent" , ["OMG! What have you done again?"]],
        ["P*!&0" , ["Nothing that bad, but I d'like to give it a try one more time.", "And your son is very involved in this. Sooo, let's hope no one can trace this back to me nor him."]],
        ["Agent" , ["I'll go right away. But you'll hear about me."]],
    ],
    CONV.CONV_3_LEVEL:[
        ["Inspector 1", ["There is no word for it."]],
        ["Agent" , ["..."]],
        ["Inspector 2", ["That's stink so much."]],
        ["Agent" , ["..."]],
        ["Inspector 3" , ["Hope investigator Nowrong Firebird will arrive soon."]],
        ["Agent" , ["..."]],
        ["Inspector 1" , ["Maybe he's already here ..."]],
        ["Agent" , ["..."]],
    ],
    CONV.CONV_3_END:[
        ["P*!&0", ["OMS! Thanks a lot! I'm so grateful to you."]],
        ["Agent" , ["You bet you are!"]],
        ["P*!&0", ["Since I gave you all my money, I can only reward you with some spare. Hope next time it will work!"]],
        ["Agent" , ["There won't be a next ti..."]],
        ["P*!&0", ["* phone hang back *"]],
        ["Agent" , ["* sight *"]],
    ],

}
