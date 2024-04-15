extends LineEdit

var allowed_characters = r"[A-Za-z0-9.:,;'\"\(\)!?\/\-]"

func _on_text_changed(new_text):
	var old_caret_position = self.caret_column
	var word = ''
	var regex = RegEx.new()
	regex.compile(allowed_characters)
	for valid_character in regex.search_all(new_text):
		word += valid_character.get_string()
	self.set_text(word)
	self.caret_column = old_caret_position
	 
