@tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("RpgStatContainer","Node",preload("res://addons/rpgstats/StatContainer.gd"), preload("res://addons/rpgstats/icon.png"))
	pass


func _exit_tree():
	remove_custom_type("RpgStatContainer")
	pass
