class_name BattlefieldResource
extends Node


var deck: DeckResource = DeckResource.new(self)
var referee: RefereeResource = RefereeResource.new(self)
var net: NetResource = NetResource.new(self)
var avatar: AvatarResource = AvatarResource.new(self)


func _init() -> void:
	net.referee = referee
	net.init_knots()
