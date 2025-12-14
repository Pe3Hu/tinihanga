extends Node


const faction_to_layer = {
	State.Faction.GREEN: 2,
	State.Faction.RED: 3,
	State.Faction.BLUE: 4
}

const faction_to_color = {
	State.Faction.GREEN: Color.GREEN,#Color.DARK_GREEN,
	State.Faction.RED: Color.RED,#Color.DARK_RED,
	State.Faction.BLUE: Color.BLUE,#Color.DARK_BLUE
}

const FACTIONS = [
	State.Faction.GREEN,
	State.Faction.RED,
	State.Faction.BLUE
]


const NET_TOTAL_AXIS = 3
const NET_TOTAL_RING = 3
const NET_AXIS_OFFSET = 175
