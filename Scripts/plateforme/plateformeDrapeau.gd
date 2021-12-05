extends KinematicBody2D

# lorsque le drapeau est capturer passage au prochain niveau
func _drapeau_capturer(body_id, body, body_shape, local_shape):
	InfoGlobal.niveau_en_cours += 1
	get_tree().reload_current_scene()

func start(x, y):
	self.position.x = x
	self.position.y = y
