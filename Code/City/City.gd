extends Node

var last_length: float = 0
var total_shop_length: float = 0
var total_background_length: float = 0
onready var backgrounds = get_tree().get_nodes_in_group("backgrounds")
onready var shops = get_tree().get_nodes_in_group("shops")
onready var c = $Character
var selectedNode
var fadingOut = false
var fadingIn = false

# Called when the node enters the scene tree for the first time.
func _ready():
	print(347586%10)
	c.connect("blackout", self, "change_scene")
	set_background_lengths()
	if global.new_game:
		shuffle_shops()
		set_new_background()
	else:
		set_old_background()
		
	c.indoors = false
	c.position = global.pos
	
func set_background_lengths():
	for shop in shops:
		total_shop_length += shop.get_length()
	for background in backgrounds:
		total_background_length += background.get_length()
	
func shuffle_shops():
	randomize()
	rand_seed(randi())
	shops.shuffle()
	
	
func set_new_background():
	
	for shop in shops:
		print(shop)
		shop.position.x = -total_shop_length/2 + last_length
		shop.position.y = 22
		last_length += shop.get_length()
	last_length = 0
	for background in backgrounds:
		background.position.x = -total_background_length/2 + last_length
		background.position.y = 0
		last_length += background.get_length()
	global.new_game = false
	
func set_old_background():
	for shop in shops:
		shop.position = global.building_positions.get(shop.name, "")
	for background in backgrounds:
		background.position.x = -total_background_length/2 + last_length + c.position.x
		background.position.y = 0
		last_length += background.get_length()
	
func _process(delta):
	
	var char_pos = $Character.position
	for shop in shops:
		shop.check_position(char_pos, total_shop_length)
	for background in backgrounds:
		background.check_position(char_pos, total_background_length)
		
	if fadingOut:
		get_tree().call_group("all_backgrounds", "fade_out")
		selectedNode.modulate.a += delta
		if selectedNode.modulate.a >1:
			selectedNode.modulate.a = 1
			$Character.visible = false
	elif fadingIn:
		get_tree().call_group("all_backgrounds", "fade_in")
		selectedNode.modulate.a -= delta
		if selectedNode.modulate.a < 0:
			selectedNode.modulate.a = 0
			selectedNode.visible = false
	
	
func take_action(name):
	match name:
		"ApartmentArea":
			c.fade_out_hard()
		"CoffeeArea":
			c.fade_out_hard()
		"DinerArea":
			c.fade_out_hard()
		"ArcadeArea":
			c.fade_out_hard()
		"OfficeArea":
			c.fade_out_hard()
		"BarArea":
			c.fade_out_hard()
		"ChurchArea":
			c.fade_out_hard()
		"ATMArea":
			var atm = $Shop3/ShopImage/ATM
			fade_out(atm)


func change_scene(name):
	global.pos = c.position
	for shop in shops:
		global.building_positions[shop.name] = shop.position
	match name:
		"ApartmentArea":
			get_tree().change_scene("res://Code/Apartment/Apartment.tscn")
		"CoffeeArea":
			get_tree().change_scene("res://Code/CoffeeShop/CoffeeShop.tscn")
		"DinerArea":
			get_tree().change_scene("res://Code/Diner/Diner.tscn")
		"ArcadeArea":
			get_tree().change_scene("res://Code/Arcade/Arcade.tscn")
		"OfficeArea":
			get_tree().change_scene("res://Code/Office/Office.tscn")
		"BarArea":
			get_tree().change_scene("res://Code/Bar/Bar.tscn")
		"ChurchArea":
			get_tree().change_scene("res://Code/Church/Church.tscn")
	
	
	
func fade_out(node):
	selectedNode = node
	fadingOut = true
	selectedNode.visible = true
	c.zoomed = true
	
func reset_fade():
	fadingOut = false
	fadingIn = true
	c.zoomed = false
	c.visible = true
	
	
	
func _on_ApartmentArea_area_entered(_area):
	$Shop2/ShopImage/ApartmentArea/ColorRect.visible = true

func _on_ApartmentArea_area_exited(_area):
	$Shop2/ShopImage/ApartmentArea/ColorRect.visible = false

func _on_DinerArea_area_entered(_area):
	$Shop5/ShopImage/DinerArea/ColorRect.visible = true

func _on_DinerArea_area_exited(_area):
	$Shop5/ShopImage/DinerArea/ColorRect.visible = false

func _on_CoffeeArea_area_entered(_area):
	$Shop6/ShopImage/CoffeeArea/ColorRect.visible = true

func _on_CoffeeArea_area_exited(_area):
	$Shop6/ShopImage/CoffeeArea/ColorRect.visible = false

func _on_ArcadeArea_area_entered(_area):
	$Shop6/ShopImage/ArcadeArea/ColorRect.visible = true

func _on_ArcadeArea_area_exited(_area):
	$Shop6/ShopImage/ArcadeArea/ColorRect.visible = false

func _on_OfficeArea_area_entered(_area):
	$Shop5/ShopImage/OfficeArea/ColorRect.visible = true

func _on_OfficeArea_area_exited(_area):
	$Shop5/ShopImage/OfficeArea/ColorRect.visible = false

func _on_BarArea_area_entered(_area):
	$Shop4/ShopImage/BarArea/ColorRect.visible = true

func _on_BarArea_area_exited(_area):
	$Shop4/ShopImage/BarArea/ColorRect.visible = false

func _on_ChurchArea_area_entered(_area):
	$Shop1/ShopImage/ChurchArea/ColorRect.visible = true

func _on_ChurchArea_area_exited(_area):
	$Shop1/ShopImage/ChurchArea/ColorRect.visible = false

func _on_ATMArea_area_entered(_area):
	$Shop3/ShopImage/ATMArea/ColorRect.visible = true

func _on_ATMArea_area_exited(_area):
	$Shop3/ShopImage/ATMArea/ColorRect.visible = false

func _on_ATMExit_pressed():
	reset_fade()
