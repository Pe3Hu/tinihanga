class_name Ditch
extends Line2D


var resource: DitchResource:
	set(value_):
		resource = value_
		init_points()
		update_color()


func init_points() -> void:
	for pit in resource.pits:
		add_point(pit.vertex)
	
func update_color() -> void:
	match resource.type:
		State.Ditch.GORGE:
			default_color = Color.DIM_GRAY
		State.Ditch.RIVER:
			default_color = Color.GRAY
