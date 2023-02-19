extends Control

@export var statContainer : StatContainer;
@export var statNodePrefab : PackedScene
var guiStatContainer : Node
func _ready():
	guiStatContainer = get_node("GuiStatContiner")
	statContainer.on_stats_changed.connect(render)
	render()
	
func render():
	for child in guiStatContainer.get_children():
		child.queue_free()
	for stat_value in statContainer.stats.values():
		render_node(stat_value)
		

func render_node(stat_value : StatValue):
	if(!stat_value.is_hidden()):
		var list_stat_node = statNodePrefab.instantiate()
		list_stat_node.set_stat(stat_value.stat)
		list_stat_node.set_level(stat_value.get_level())
		guiStatContainer.add_child(list_stat_node)

func _get_configuration_warning():
	if(statContainer == null):
		return "[RpgStatMenu][Initialize] Failed to initialize Stat Container"
	#on success return empty string
	return ""
