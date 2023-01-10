extends Panel
const RPG_STAT_PATH = "res://RpgStats/Stats/"
var dropdown_menu : OptionButton
var stats : Array

@export var stat_container : StatContainer
func _ready():
	
	_initialize_stats()
	#Initialize Dropdown Menu
	_initialize_dropdown_menu()
	#Initialize Button Subscriptions
	_initialize_button_signals()
	
	pass # Replace with function body.

func _initialize_stats():
	var stats_dir = DirAccess.get_files_at(RPG_STAT_PATH)
	for stat in stats_dir:
		var loaded_stat = ResourceLoader.load(RPG_STAT_PATH+stat, "Stat")
		stats.append(loaded_stat)

func _initialize_dropdown_menu():
	dropdown_menu = get_node("VBoxContainer/OptionButton")
	for i in range(0,len(stats)) :
		var stat : Stat = stats[i]
		dropdown_menu.add_item(stat.name, i)
		
func _initialize_button_signals():
	get_node("VBoxContainer/Add100Xp").button_down.connect(_add_xp_to_selected)
	get_node("VBoxContainer/CheckSelectedSkillXp").button_down.connect(_check_selected_skill)
		
func _add_xp_to_selected():
	stat_container.add_experience(
		_get_selected_stat(), 100
	)
	
func _get_selected_stat():
	return stats[dropdown_menu.get_selected_id()]

func _check_selected_skill():
	print(stat_container.get_stat_xp(_get_selected_stat()))
