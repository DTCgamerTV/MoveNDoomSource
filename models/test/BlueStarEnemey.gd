extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D

var path = [] #Hold the path coordinates from the enemy to the player
var path_index = 0 #Keep track of which coordinate to go to

var speed = 5
var health = 100
var move = true


func _ready():
	pass

@rpc("any_peer", "reliable", "call_local")
func take_damage(dmg_amount):
	health -= dmg_amount
	if health <= 0:
		death()
		return
	move = false
	$AnimationPlayer.play("BlueStar_Hurt")
	await $AnimationPlayer.animation_finished
#	$AnimatedSprite3D.play("walking")
	move = true
	
func _physics_process(delta):
	
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * speed
	
	velocity = velocity.move_toward(new_velocity, .25)
	if move:
		$AnimationPlayer.play("BlueStar_Idle")
		move_and_slide()
	
func update_target_location(target_position):
	nav_agent.set_target_position(target_position)


func death():
	set_process(false)
	set_physics_process(false)
	if health < -20:
		$AnimationPlayer.play("BlueStar_Die")
	else:
		$AnimationPlayer.play("BlueStar_Die")
	#$AnimationPlayer.disabled = true
	
func shoot(target):
	pass
