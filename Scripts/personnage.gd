extends KinematicBody2D

export (int) var vitesse = 550
export (int) var gravite = 40
export (int) var hauteur_saut = -1300
var velocity = Vector2(0,0)

var animationNom = "Courrir"
var action = false
var direction_gauche = false
var centre_ecran = OS.get_screen_size()/2


func _physics_process(delta):
	get_input()


# obtenir les entrées du clavier de l'utilisateur
# appele les methodes relié à l'entrer
func get_input():
	action = false
	# pour eviter un glitch de changement d'animation (Lorsque que deux animations en même temp)
	if Input.is_action_pressed("right"):
		droite()
	if Input.is_action_pressed("left"):
		gauche()	
	gravite()
	if Input.is_action_just_pressed("top") and is_on_floor():
		jump()
	deplacement()
	animate()

# ========================== direction ===================================
func droite():
	velocity.x = vitesse
	animationNom = "Courrir"
	action = true
	direction_gauche = false

func gauche():
	velocity.x = -vitesse
	animationNom = "Courrir"
	action = true
	direction_gauche = true
	
	
func jump():
	action = true
	direction_gauche = true
	velocity.y = hauteur_saut


func deplacement():
	velocity = move_and_slide(velocity,Vector2.UP)
	velocity.x = lerp(velocity.x,0,0.6)


func gravite():
	velocity.y = velocity.y  + gravite
	
# ========================== fin direction ===================================
	
# animer le personnage selon le type de déplacement effectuer
func animate():
	if (action):
		if is_on_floor():
			$Animation.animation = animationNom
		else:
			$Animation.animation = "Saut"
			
		$Animation.flip_h = direction_gauche
		$Animation.playing = true
		return	
	$Animation.animation = "Idle"	
