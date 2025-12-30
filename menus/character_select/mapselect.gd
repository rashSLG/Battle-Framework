extends Control

@onready var ImagePreview = $CenterContainer/TextureRect
@onready var StageNameTag = $Label
@onready var SelectedStageList = $ScrollContainer/VBoxContainer

var stages
var stage_step : int = 0
var max_selected_stages : int = 5
var selected_stages = []

func _ready() -> void:
	stages = GameData.battle_stages

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("right1"):
		stage_step += 1
		if stage_step >= stages.size():
			stage_step = 0
		var stage_image = GameData._stage_info_dict[stages[stage_step]].image_preview
		Update_UI_Visuals(stages[stage_step], stage_image)
		
	if Input.is_action_just_pressed("left1"):
		stage_step -= 1
		if stage_step <= 0:
			stage_step = stages.size() - 1
		var stage_image = GameData._stage_info_dict[stages[stage_step]].image_preview
		Update_UI_Visuals(stages[stage_step], stage_image)
		
	if Input.is_action_just_pressed("attack1"):
		#is there a way to "clean" the names into better looking versions without changing all the references?
		if selected_stages.size() < max_selected_stages:
			selected_stages.append(stages[stage_step])
			var new_nametag = Label.new()
			new_nametag.text = stages[stage_step]
			SelectedStageList.add_child(new_nametag)
		else:
			print("maximum number of stages selected!")

func Update_UI_Visuals(nametag : String, stage_image):
	StageNameTag.text = nametag
	if stage_image != null:
		ImagePreview.texture = stage_image
