extends Panel
class_name  RpgStatMenuStat

var icon : TextureRect
var level_label : Label
var stat : Stat
var level : int
func _ready():
	icon = get_node("Icon")
	level_label = get_node("Level Number")
	
func set_stat(stat_temp : Stat):
	stat = stat_temp
	if(!icon):
		icon = get_node("Icon")
	if(stat.icon != null):
		icon.texture = stat.icon
	
func set_level(temp_level : int):
	level = temp_level
	if(!level_label):
		level_label = get_node("Level Number")
	level_label.text = str(level)
