extends Resource
class_name HexTileData

@export var tile_id: Enums.TileID
@export var atlas_coords: Vector2i
@export var terrain_type: Enums.TerrainType
@export var special_type: Enums.SpecialType
@export var base_wall_pattern : Enums.WallPatterns

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
