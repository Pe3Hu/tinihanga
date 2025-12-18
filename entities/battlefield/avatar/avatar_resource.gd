class_name AvatarResource
extends Node


var battlefield: BattlefieldResource
var tribute: int = 6
var element: State.Element


func _init(battlefield_: BattlefieldResource) -> void:
	battlefield = battlefield_
	
func roll_element() -> void:
	element = Catalog.genesis_to_element[State.Genesis.BASIC].pick_random()
