class_name TemperingTool
extends Resource

enum TYPE {CLEANING, FRAMING, HIDING}
@export var type : TYPE

@export var cleaning_duration : float = 0. # [s]
@export var clickable_zone    : ClickableZone

@export var price           : int
@export_multiline var description_txt : String

@export var icon                  : Texture2D
@export var cleaning_aspect       : Texture2D
@export var cleaning_aspect_dirty : Texture2D
