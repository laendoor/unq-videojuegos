extends Node

export (PackedScene) var turret_scene

func initialize(container: Node, player):
	var visible_rect: Rect2 = get_viewport().get_visible_rect()
	var turrets = container.get_node("Objects/Turrets").get_children()
	for turret in turrets:
		turret.initialize(self, player)
