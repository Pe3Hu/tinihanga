extends Node


#region faction
const faction_to_layer = {
	State.Faction.GREEN: 2,
	State.Faction.RED: 3,
	State.Faction.BLUE: 4
}

var faction_to_color = {
	State.Faction.NONE: Color("525252"),
	State.Faction.GREEN: Color.from_hsv(0.333, 0.33, 0.66, 1.0),
	State.Faction.RED: Color.from_hsv(0.0, 0.33, 0.66, 1.0),
	State.Faction.BLUE: Color.from_hsv(0.666, 0.33, 0.66, 1.0)
}

const FACTIONS = [
	State.Faction.GREEN,
	State.Faction.RED,
	State.Faction.BLUE
]
#endregion

const machine_to_string = {
	State.Machine.IDLE: "idle",
	State.Machine.HOVER: "hover",
	State.Machine.CLICK: "click",
	State.Machine.DRAG: "drag",
	State.Machine.RELEASE: "release",
}

const token_to_string = {
	State.Token.POWER: "power",
	State.Token.HEALTH: "health",
	State.Token.TRIBUTE: "tribute",
}

#region element
const GENESISES = [State.Genesis.BASIC, State.Genesis.HYBRID, State.Genesis.ANCESTOR]

const genesis_to_string = {
	State.Genesis.BASIC: "basic",
	State.Genesis.HYBRID: "hybrid",
	State.Genesis.ANCESTOR: "ancestor",
}

const genesis_to_element = {
	State.Genesis.BASIC: [State.Element.AQUA, State.Element.WIND, State.Element.FIRE, State.Element.EARTH],
	State.Genesis.HYBRID: [State.Element.ICE, State.Element.SAND, State.Element.LAVA, State.Element.PLANT],
	State.Genesis.ANCESTOR: [State.Element.BLOOD, State.Element.CLOUD, State.Element.LIGHTNING, State.Element.CRYSTAL]
	
}

const element_to_hue = {
	State.Element.AQUA: 220,
	State.Element.WIND: 120,
	State.Element.FIRE: 360,
	State.Element.EARTH: 60,
	State.Element.BLOOD: 180,
	State.Element.CLOUD: 180,
	State.Element.LIGHTNING: 270,
	State.Element.CRYSTAL: 30,
}

const element_to_component = {
	State.Element.ICE: [State.Element.AQUA, State.Element.WIND],
	State.Element.SAND: [State.Element.WIND, State.Element.FIRE],
	State.Element.LAVA: [State.Element.FIRE, State.Element.EARTH],
	State.Element.PLANT: [State.Element.AQUA, State.Element.EARTH],
	State.Element.BLOOD: [State.Element.AQUA, State.Element.AQUA],
	State.Element.CLOUD: [State.Element.WIND, State.Element.WIND],
	State.Element.LIGHTNING: [State.Element.FIRE, State.Element.FIRE],
	State.Element.CRYSTAL: [State.Element.EARTH, State.Element.EARTH],
}
#endregion


const NET_TOTAL_AXIS: int = 3
const NET_TOTAL_RING: int = 3
const NET_AXIS_OFFSET: int = 72
const NET_RING_OFFSET: int = 72
const NET_PANEL_SIZE: Vector2 = Vector2(500, 500)
const NET_TABLE_SCALE: float = 1.85

const CARD_MAX_SIZE: Vector2 = Vector2(48, 48)#Vector2(64, 64)
const PILE_MAX_SIZE: Vector2 = Vector2(303, 99)#Vector2(404, 132)

const pile_to_card_limit = {
	State.Pile.HAND: 6,
	State.Pile.FIELD: 3,
	State.Pile.DECK: 55,
}

const pile_to_size = {
	State.Pile.HAND: Vector2(320, 48),
	State.Pile.FIELD: Vector2(150, 100),
}

const slot_to_string = {
	State.Slot.HAND: "hand",
	State.Slot.FIELD: "field",
	State.Slot.RESERVE: "reserve",
	State.Slot.CHOICE: "choise",
	State.Slot.FANG: "fang",
	State.Slot.CLAW: "claw",
	State.Slot.TAIL: "tail",
	State.Slot.HEART: "heart",
	State.Slot.LUNG: "lung",
	State.Slot.STOMACH: "stomach",
}
