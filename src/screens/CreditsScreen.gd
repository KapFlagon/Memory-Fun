extends Control



func _ready() -> void:
	get_node("ColorRect").set_frame_color(PlayerData.get_background_colour())
	ready_texts()


func _on_Back_button_up() -> void:
	AudioManager.play_rand_sfx()
	get_tree().change_scene("res://src/screens/StartScreen.tscn")


func ready_texts() -> void:
	$VBox_Credits/ScreenTitle.set_text(tr("CREDITS"))
	$VBox_Credits/OwnCon.set_text(tr("CRED_MAIN_CONT"))
	$VBox_Credits/HBox_Prog/Title.set_text(tr("CRED_PROG")+":")
	$VBox_Credits/HBox_Music/Title.set_text(tr("CRED_MUSIC")+":")
	$VBox_Credits/HBox_Art/Title.set_text(tr("CRED_ART")+":")
	$VBox_Credits/OtherCon.set_text(tr("CRED_ADD_CONT"))
	$VBox_Credits/HBox_trans/Title.set_text(tr("CRED_MAIN_CONT")+":")
	$VBox_Credits/HBox_testing/Title.set_text(tr("CRED_MAIN_CONT")+":")
	$VBox_Credits/HBox_Fonts/Title.set_text("'Cabal Bold' " + tr("CRED_FONT_A") + ":")
	$VBox_Credits/HBox_Fonts/Name.set_text("LJ Design Studios (" + tr("CRED_FONT_B")+")")
