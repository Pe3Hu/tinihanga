class_name RefereeResource
extends Node


var battlefield: BattlefieldResource
var players: Array[PlayerResource]
var faction_to_player: Dictionary


func _init(battlefield_: BattlefieldResource) -> void:
	battlefield = battlefield_
	init_players()
	
func init_players() -> void:
	for faction in Catalog.FACTIONS:
		add_player(faction)
	
func add_player(faction_: State.Faction) -> void:
	var player = PlayerResource.new(self, faction_)
	players.append(player)
	player.table.update_faction()
	faction_to_player[faction_] = player
	player.table.deck = battlefield.deck
	pass
