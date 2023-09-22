@tool
extends MeshInstance3D

@export var roof_shape = 0: set = set_roof_shape
@export var polygon: PackedVector2Array: set = set_polygon
@export var height = 2: set = set_height
@export var level_height = 2.5: set = set_level_height
@export var window_width = 2.5: set = set_window_width
@export var wall_material: Material
@export var roof_angle = 20: set = set_roof_angle
@export var roof_material: Material

func set_roof_shape(s):
	roof_shape = s
	editor_update()

func set_polygon(p):
	polygon = p
	editor_update()

func set_height(h):
	height = h
	editor_update()

func set_level_height(h):
	level_height = h
	editor_update()

func set_window_width(w):
	window_width = w
	editor_update()

func set_roof_angle(a):
	roof_angle = a
	editor_update()

func editor_update():
	if Engine.is_editor_hint():
		if has_node("Polygon2D"):
			polygon = get_node("Polygon2D").get_polygon()
		force_update()

func force_update():
	var meshes = load("res://addons/openstreetmap/global/meshes.gd")
	mesh = ArrayMesh.new()
	var walls = meshes.Walls.new(false, true)
	walls.add(polygon, null, level_height*height, 0.5, height, 1/window_width)
	walls.add_to_mesh(mesh, wall_material)
	var roof
	if roof_shape == 1:
		roof = meshes.ConvexRoofs.new()
	else:
		roof = meshes.Roofs.new()
	roof.add(polygon, level_height*height, roof_angle)
	roof.add_to_mesh(mesh, roof_material)
