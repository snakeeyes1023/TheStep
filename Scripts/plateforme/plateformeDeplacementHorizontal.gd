extends "plateformeGlobal.gd"

# vitesse de  déplacement de la plateforme
export var deplacement_sec = 1.0
var gauche = false
var index = 0


func _process(delta):
	verifier_direction()
	deplacer_plateforme()	
	
# déplace la plateforme en x
func deplacer_plateforme():
	if gauche:
		position.x -= deplacement_sec	
		index -= 1
	else:
		position.x += deplacement_sec
		index += 1

#vérifier dans quelle direction déplacer la plateforme
func verifier_direction():
	if index == 100:
		gauche = true
	if index == -100:
		gauche = false	

