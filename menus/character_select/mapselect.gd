extends Control

@onready var ImagePreview = $TextureRect
@onready var StageNameTag = $Label
@onready var SelectedStageList = $ScrollContainer/VBoxContainer
@onready var NameTagTemplate = load("res://assets/ui/menus/map_select/stage_name_tag_template.tscn")

var stages
var stage_step : int = 0
var max_selected_stages : int = 5
var current_stage : int = 0
var selected_stages = []

func _ready() -> void:
	stages = GameData.battle_stages
	create_empty_list()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_right1"):
		stage_step += 1
		if stage_step >= stages.size():
			stage_step = 0
		Update_UI_Visuals(GameData.get_stage_info(stages[stage_step]))
		
	if Input.is_action_just_pressed("ui_left1"):
		stage_step -= 1
		if stage_step <= 0:
			stage_step = stages.size() - 1
		Update_UI_Visuals(GameData.get_stage_info(stages[stage_step]))
		
	if Input.is_action_just_pressed("ui_accept1"):
		set_stage_in_list(GameData.get_stage_info(stages[stage_step]))
	
	if Input.is_action_just_pressed("ui_cancel1"):
		remove_stage_from_list()

func Update_UI_Visuals(stage : StageInfo):
	StageNameTag.text = stage.display_name
	$namebkg.modulate = stage.stage_color
	if stage.stage_preview != null:
		ImagePreview.texture = stage.stage_preview

func create_empty_list():
	for i in max_selected_stages:
		var new_nametag = NameTagTemplate.instantiate()
		new_nametag.get_node("stagenumber").text = str(i)
		new_nametag.get_node("stagename").text = "--"
		SelectedStageList.add_child(new_nametag)

func set_stage_in_list(stage):
	if current_stage <= max_selected_stages - 1:
		var stagelabel = SelectedStageList.get_children()[current_stage]
		stagelabel.get_node("stagename").text = stage.display_name
		stagelabel.get_node("bkg").modulate = stage.stage_color
		current_stage += 1
	else: print("max stages reached!")

func remove_stage_from_list():
	var stagelabel = SelectedStageList.get_children()[current_stage]
	stagelabel.get_node("stagenumber").text = str(current_stage)
	stagelabel.get_node("stagename").text = "--"
	stagelabel.get_node("bkg").modulate = Color("ffffffff")
	if current_stage > 0:
		current_stage -= 1
