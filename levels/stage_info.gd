@tool
extends Resource
class_name StageInfo

## The name that will be shown in the stage select screen.
@export var display_name: String = ""
## The file path for the music file. Must be in the same folder as the stage scene.
@export_file var music_file_path: String
## Sprite for the image preview
@export var stage_preview : Texture2D
@export var stage_color : Color
