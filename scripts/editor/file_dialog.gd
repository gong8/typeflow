extends FileDialog

func _ready():
	show()
	add_filter("*.mp3", "Music")
	set_file_mode(FileMode.FILE_MODE_OPEN_FILE)
	set_access(Access.ACCESS_FILESYSTEM)
	set_current_dir("songs")

