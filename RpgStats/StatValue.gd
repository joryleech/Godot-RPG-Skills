class_name StatValue
@export var xp : int = 0
@export var stat : Stat

func get_level():
	return stat.xp_to_level(xp)

func is_hidden():
	if(stat.hidden):
		return true
	if(stat.hidden_at_zero_xp && xp <= 0):
		return true
	return false
