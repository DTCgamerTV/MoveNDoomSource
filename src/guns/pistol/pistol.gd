extends Node3D

@onready var gun_anims = $GunAnim
@onready var gun_rays = $GunRays.get_children()
var damage = 20
var can_shoot = true
# Called when the node enters the scene tree for the first time.
func _ready():
	gun_anims.play("PistolIdle")
	
func check_hit():
	for ray in gun_rays	:
		if ray.is_colliding():
			if ray.get_collider().is_in_group("Enemy"):
				#ray.get_collider().take_damage(damage)
				ray.get_collider().rpc("take_damage", damage)
	
func make_flash():
	pass

@rpc("any_peer")
func _process(delta):
	if not is_multiplayer_authority(): return
	
	if Input.is_action_just_pressed("shoot") and can_shoot:
		play_shoot_effects()
		make_flash()
		check_hit()
		can_shoot = false
		
		await gun_anims.animation_finished
		
		can_shoot = true
		gun_anims.play("PistolIdle")

@rpc("call_local")
func play_shoot_effects():
		gun_anims.play("PisolShoot")
