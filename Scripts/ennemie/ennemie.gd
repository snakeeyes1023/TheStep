extends KinematicBody2D

# vitesse de l'ennemie
export (int) var vitesse = 550
#gravité de l'ennemie
export (int) var gravite = 40

var velocity = Vector2(0,0)

var animationNom = "mouvement"
var direction_gauche = false


func _physics_process(delta):
	gravite()
	choisir_direction()
	animate()

#position de départ de l'ennemie
func start(x, y):
	self.position.x = x
	self.position.y = y
	
# ========================== direction ===================================
func droite():
	velocity.x = vitesse
	direction_gauche = false

func gauche():
	velocity.x = -vitesse
	direction_gauche = true

func choisir_direction():
	# vérification pour pas que l'ennemie ne tombe de la plateforme
	if !$VideDroite.is_colliding():
		direction_gauche = true
		
	if !$VideGauche.is_colliding():
		direction_gauche = false	
		
	deplacer_ennemie()

# deplace l'ennemie vers la direction choisi dans (choisir_direction)
func deplacer_ennemie():
	if direction_gauche:
		gauche()
	else:
		droite()	
	deplacement()

func deplacement():
	velocity = move_and_slide(velocity,Vector2.UP)
	velocity.x = lerp(velocity.x,0,0.6)

# ========================== fin direction ===================================

# graviter à appliquer à l'ennmemie
func gravite():
	velocity.y = velocity.y  + gravite

# animation de mouvement selon la direction
func animate():
	$Animation.flip_h = direction_gauche
	$Animation.playing = true

# signal que quelque chose vien de pénetre dans la zone d'attaque
func _signal_ennemie_detecte(body_id, body, body_shape, local_shape):
	if body.name == "Personnage":
		InfoGlobal.niveau_en_cours = 0
		for i in range(0, get_child_count()):
			get_child(i).queue_free()
		get_tree().reload_current_scene()
