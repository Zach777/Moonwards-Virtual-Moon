extends Node
class_name ANetworkInstance
# Base class for client and server instances

var world: Node
var players_container: Node

# Array of PlayerData
puppetsync var players: Dictionary = {}

func _ready():
	world = Scene.change_scene_to_instance(Scene.world_scene)
	world.name = "World"

	players_container = Node.new()
	players_container.name = "Players"
	world.add_child(players_container)

puppetsync func remove_player(peer_id: int) -> void:
	players.erase(peer_id)
	players_container.get_node(str(peer_id)).queue_free()

# Adds a new player to the game
# `player_data` `PlayerData` (or dictionary in serialized form) type
puppetsync func add_player(player_data) -> void:
	var p = Scene.PLAYER_SCENE.instance()
	p.transform.origin = player_data.initial_pos
	p.name = str(player_data.peer_id)
	p.peer_id = player_data.peer_id
	p.set_network_master(1)
	players_container.add_child(p)

### Networking API
## See if we can move this to it's own script.

# Controlled RPC Wrapper with added control.
func crpc(caller: Node, method: String, val, exclude_list: Array = []):
	for player in players.values():
		if not exclude_list.has(player.peer_id):
			caller.rpc_id(player.peer_id, method, val)

# Controlled RPC Wrapper with added control.
func crpc_unreliable(caller: Node, method: String, val, exclude_list: Array = []):
	for player in players.values():
		if not exclude_list.has(player.peer_id):
			caller.rpc_unreliable_id(player.peer_id, method, val)

# Controlled RSET Wrapper with added control.
func crset(caller: Node, method: String, val, exclude_list: Array = []):
	for player in players.values():
		if not exclude_list.has(player.peer_id):
			caller.rset_id(player.peer_id, method, val)

# Controlled RSET Wrapper with added control.
func crset_unreliable(caller: Node, method: String, val, exclude_list: Array = []):
	for player in players.values():
		if not exclude_list.has(player.peer_id):
			caller.rset_id(player.peer_id, method, val)

### Figure out a better way to handle this, if godot allows
func crpc_signal(instance: Object, sig_name: String, param = null):
	if get_tree().is_network_server():
		crpc(self, "_handle_crpc_signal", [instance.name, sig_name, param])
	else:
		rpc_id(1, "_handle_crpc_signal",  [instance.name, sig_name, param])

### Figure out a better way to handle this, if godot allows
remote func _handle_crpc_signal(params: Array):
	Log.trace(self, "", "Received RPC signal: %s.%s - param: %s" % [params[0], params[1], params[2]])
	Signals.get(params[0]).emit_signal(params[1], params[2])

