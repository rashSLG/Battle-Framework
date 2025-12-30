@tool
extends Resource
class_name StageInfo

## The name that will be shown in the stage select screen.
@export var display_name: String = ""
## The file path for the music file. Must be in the same folder as the stage scene.
@export_file var music_file_path: String
## Preview image for the stage, for use in the map select. Put it in! or else...
@export var image_preview : Texture2D
