class_name CleaningTool
extends Resource

#enum TYPE {Tool, Alibi, Cover}
#@export var type : TYPE

@export var cleaning_duration : float = 3. # [s]
@export var clickable_zone    : ClickableZone

@export var icon  : Texture2D
@export var description_txt : String
@export var price : int
