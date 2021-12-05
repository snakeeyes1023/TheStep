extends KinematicBody2D

# vitesse de déplacement de la lave
export  var vitesse_lave = 0.5


func _physics_process(delta):
	monter_lave()

# monter la lave (adapte la vitesse selon le niveau actuel)
func monter_lave():
	$Lave.position.y -= vitesse_lave + (InfoGlobal.niveau_en_cours / 3)

# lorsque la lave touche le joueur la parti recommence
func _Lave_touche_joueur(body_id, body, body_shape, local_shape):
	if body.name == "Personnage":
		InfoGlobal.niveau_en_cours = 0
		for i in range(0, get_child_count()):
			get_child(i).queue_free()
		get_tree().reload_current_scene()
		
