extends MeshInstance3D

@export var zone = 0 # (int, "Grass", "Water")
@export var material: Material
@export var height: float = 0.001

const ZONE_NAMES = [ "grass", "water" ]

func update_data(data):
	var generated_mesh = Mesh.new()
	var generator = meshes.Polygons.new()
	for grass in data[ZONE_NAMES[zone]]:
		generator.add(grass, height)
	generator.add_to_mesh(generated_mesh, material)
	call_deferred("on_updated", generated_mesh)

func on_updated(generated_mesh):
	mesh = generated_mesh
