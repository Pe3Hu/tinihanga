extends Node


enum Faction{
	NONE = 0,
	GREEN = 2,
	RED = 3,
	BLUE = 4,
}


enum Machine{
	IDLE = 0,
	HOVER = 1,
	CLICK = 2,
	DRAG = 3,
	RELEASE = 4
}

enum Token{
	NONE = 0,
	ELEMENT = 1,
	HEALTH = 2,
	POWER = 3,
	TRIBUTE = 4,
}

#region element
enum Genesis{
	NONE = 0,
	BASIC = 1,
	HYBRID = 2,
	ANCESTOR = 3
}

enum Element{
	CHAOS = 0,
	AQUA = 1,
	WIND = 2,
	FIRE = 3,
	EARTH = 4,
	BLOOD = 5,
	ICE = 6,
	SAND = 7,
	CLOUD = 8,
	LIGHTNING = 9,
	LAVA = 10,
	CRYSTAL = 11,
	PLANT = 12,
}
#endregion

enum Pile{
	HAND = 0,
	FIELD = 1,
	RESERVE = 2,
	CHOICE = 3,
	PREFERENCE = 4,
	DECK = 5
}

enum Pack{
	ANY = 0,
	I = 1,
	II = 2,
	III = 3,
	IV = 4,
	V = 5,
	VI = 6,
	VII = 7,
}

enum Slot{
	HAND = 0,
	FIELD = 1,
	RESERVE = 2,
	CHOICE = 3,
	FANG = 10,
	CLAW = 11,
	TAIL = 12,
	HEART = 13,
	LUNG = 14,
	STOMACH = 15,
}

enum Status{
	WAITING = 0,
	PACKED = 1,
	TIED = 2,
	PINNED = 3,
}

enum Order{
	FIRST = 1,
	SECOND = 2,
	THIRD = 3
}

enum Recolor{
	DEFAULT = 0,
	FACTION = 1,
	ACCESS = 2
}
