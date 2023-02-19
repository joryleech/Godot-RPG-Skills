extends Node
class_name StatContainer
signal on_change_level(stat_value : StatValue, delta_level : int)
signal on_change_experience(StatValue, delta_xp : int)
signal on_stats_changed
@export var stats : Dictionary = {}

func get_stat_level(stat : Stat):
	return stat.xp_to_level(
		self.get_stat_xp(stat)
	)
	
func get_stat_xp(stat : Stat):
	return get_stat_values(stat).xp
	
func get_stat_values(stat : Stat):
	var current_stat_value : StatValue = stats.get(stat)
	if(!current_stat_value):
		current_stat_value = initialize_stat(stat)
	return current_stat_value

func initialize_stat(stat : Stat):
	var current_stat_value = StatValue.new()
	current_stat_value.stat = stat
	current_stat_value.xp = 0
	stats[stat] = current_stat_value
	emit_signal('on_stats_changed')
	return current_stat_value
	
func add_experience(stat, xp):
	var current_stat_value = get_stat_values(stat)
	var current_level = get_stat_level(stat)
	current_stat_value.xp += xp
	var new_level =  get_stat_level(stat)
	emit_signal('on_change_experience', current_stat_value, xp)
	if(new_level != current_level):
		emit_signal('on_change_level', current_stat_value, new_level - current_level)
	emit_signal('on_stats_changed')
	
	
func deserialize(json : Dictionary):
	pass
	#TODO

func serialize():
	pass
	#TODO
