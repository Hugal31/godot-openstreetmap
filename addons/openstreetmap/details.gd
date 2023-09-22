extends Particles

@export var mesh: Mesh
@export var spacing: float = 1.0
@export var random = 1.0 # (float,0.0,1.0)
@export var distance: float = 50.0
@export var condition: Color
@export var condition_mask: Color

func _ready():
	draw_pass_1 = mesh
	process_material = process_material.duplicate()
	visibility_aabb.position = Vector3(0, 0, 0)
	visibility_aabb.size     = Vector3(osm.TILE_SIZE, 2.0, osm.TILE_SIZE)
	process_material.set_shader_parameter("tile_size", osm.TILE_SIZE)
	process_material.set_shader_parameter("spacing", spacing)
	process_material.set_shader_parameter("random", random)
	process_material.set_shader_parameter("condition", condition)
	process_material.set_shader_parameter("condition_mask", condition)

func set_ground_texture(t):
	process_material.set_shader_parameter("splatmap", t)

func set_center(p):
	var x1 = p.x-distance
	var x2 = p.x+distance
	var y1 = p.y-distance
	var y2 = p.y+distance
	if x2 < 0.0 or x1 > osm.TILE_SIZE or y2 < 0.0 or y1 > osm.TILE_SIZE:
		amount = 1
	else:
		if x1 < 0: x1 = 0
		if x2 > osm.TILE_SIZE: x2 = osm.TILE_SIZE
		if y1 < 0: y1 = 0
		if y2 > osm.TILE_SIZE: y2 = osm.TILE_SIZE
		process_material.set_shader_parameter("start", Vector2(floor(x1/spacing), floor(y1/spacing)))
		var rows = floor((x2-x1)/spacing)+1
		process_material.set_shader_parameter("rows", rows)
		amount = rows*(floor((y2-y1)/spacing)+1)
