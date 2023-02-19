class_name Stat
extends Resource

enum LevelingType {
	expression = 0,
	curve = 1
}

@export var icon : Texture2D;
@export var level_type : LevelingType = LevelingType.expression
@export var name : String = ""
@export var description : String
@export var xp_expression : String = ""
@export var xp_curve : Curve = Curve.new()
@export var xp_curve_multiplier : float = 1 #Curves max out at 1024.
@export var max_level : int  = 100
@export var hidden : bool = false;
#Prevents Skill from rendering in stat container if xp is less than 1
@export var hidden_at_zero_xp = true

func xp_to_level(xp : int): 
	match level_type:
		LevelingType.expression:
			return xp_to_level_expression(xp)
		LevelingType.curve:
			return xp_to_level_curve(xp)


func xp_to_level_curve(xp: int):
	var total_xp = 0
	for i in range(0, max_level):
		var percentage_curve = float(i)/float(max_level)
		total_xp += xp_curve.sample_baked(percentage_curve)*xp_curve_multiplier
		if(total_xp > xp): 
			return i
	return max_level
	
func xp_to_level_expression(xp: int):
	var expression : Expression = Expression.new()
	expression.parse(xp_expression, ["x"])
	var result = expression.execute([xp])
	if(expression.has_execute_failed()): 
		print("[Stat][xp_to_level]["+self.name+"]: Execution Failed. " + expression.get_error_text())
		return -1
	return result
