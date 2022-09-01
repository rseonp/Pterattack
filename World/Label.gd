extends Label

func _ready():
	Globals.connect("gsf_changed", self, "_on_gsf_changed")

func _on_gsf_changed():
	text = str(Globals.global_speed_factor)
	
