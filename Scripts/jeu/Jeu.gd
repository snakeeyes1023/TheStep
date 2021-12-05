extends Node2D

# ------------------------ information de position --------------------
var position_derniere_plateform_y = -150
var position_plateforme_x = 0
var position_derniere_plateform_x = 400
# ------------------------ fin information de position --------------------

#liste des scène (plateforme) pouvant être apparue
var liste_plateforme = [preload("res://Scenes/plateforme/plateformeBase.tscn"), preload("res://Scenes/plateforme/plateformePetit.tscn"),  preload("res://Scenes/plateforme/plateformeDeplacementHorizontal.tscn")]
# Called when the node enters the scene tree for the first time.

func _ready():
	# permet d'éviter d'avoir encore les enciennes plateforme qui non pas été supprimer
	supprimer_plateforme_present()
	position_derniere_plateform_y = $PositionXMin.position.y
	# génere les plateformes supplémentaire selon le niveau du joueur
	generer_plateforme_supplementaire()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	randomize()
	appliquer_position_camera()
	
# Déplace la caméra pour avoir le joueur en visuel
func appliquer_position_camera():
	$Vue.global_position.y = $Personnage.position.y + 100

# générer des plateformes supplémentaire
func generer_plateforme_supplementaire():
	if InfoGlobal.niveau_en_cours > 1:
		for x in range(0, InfoGlobal.niveau_en_cours * 2):
			apparaitre_plateforme_random()	
	deplacer_plateforme_final()
	
# obtien une plateforme random
func obtenir_plateforme():
	return liste_plateforme[randi() % liste_plateforme.size()]
	
	
# apparaitre un nouvelle plateform au dessus de la dernière plateforme
func apparaitre_plateforme_random():
	var plateforme_scene = obtenir_plateforme()
	var plateforme = plateforme_scene.instance()
	obtenir_position_random()
	plateforme.start(position_plateforme_x, position_derniere_plateform_y)
	self.add_child(plateforme)

# obtenir une position random (évite d'avoir des sauts impossible à faire)
func obtenir_position_random():
	position_derniere_plateform_y -= 200
	var positionx = 0
	# Random la positions tant quelle ne respect pas les critère de position
	while(positionx < $PositionXMin.position.x or positionx > $PositionXMax.position.x):
		positionx = rand_range(position_derniere_plateform_x - 400, position_derniere_plateform_x + 400)
		if(positionx < position_derniere_plateform_x - 400 or positionx > position_derniere_plateform_x + 400):
			positionx = 0
				
	position_plateforme_x = positionx
	position_derniere_plateform_x = position_plateforme_x

# déplacer la plateforme de ligne d'arriver en dessus des autres plateformes
func deplacer_plateforme_final():
	if InfoGlobal.niveau_en_cours < 2:
		return
	obtenir_position_random()
	$SautFinal.position.y = position_derniere_plateform_y
	$SautFinal.position.x = position_plateforme_x
	 
# supprimer les plateformes qui auraient pus pas être supprimé
func supprimer_plateforme_present():
	for i in range(0, get_child_count()):
		if("Plateforme" in get_child(i).name):
			get_child(i).queue_free()
