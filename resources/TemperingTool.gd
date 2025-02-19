class_name TemperingTool
extends Resource

enum TYPE {CLEANING, FRAMING}
@export var type : TYPE

@export var clickable_zone : ClickableZone

@export var icon  : Texture2D
@export var description_txt : String
@export var price : int
