extends KinematicBody2D

var ennemie = preload("res://Scenes/ennemie/ennemie.tscn")
export (int) var chance_contenir_ennemie = 80

# position de départ de la plateforme
func start(x, y):
	self.position.x = x
	self.position.y = y
	verifier_apparition_ennemie()
	

# vérifier si une plateforme doit être apparu selon les probabilités
func verifier_apparition_ennemie():
	if	calculer_probabilite():
		apparaitre_ennemie_plateforme()

# Calcule de la probiliter 
func calculer_probabilite():
	randomize()
	var i = rand_range(0.0, 1.0)
	if i < chance_contenir_ennemie/100.0:
		return true
	return false

# apparaitre un nouvel ennemie sur la plateforme
func apparaitre_ennemie_plateforme():
	var ennemie_instance = ennemie.instance()
	ennemie_instance.start($EnnemieSpawner.global_position.x, $EnnemieSpawner.global_position.y)
	self.add_child(ennemie_instance)
