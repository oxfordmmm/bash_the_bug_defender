# Bash the Bug Defender

Game to be played on dancemat where you need to defend the human cell from attacking bacteria.

Current mechanism is firing antibiotics at invading bacteria.
Use the bottom 3 bottoms to select antibiotic.
Bugs will start developing resistance

## Adding / Removing Avatars

To add an avatar make an `svg` image (e.g. with Inkscape) with the same dimensions as the current 
images e.g. `art/avatars/generic_doctor.svg` and copy this to the `art/avatars/` dir. Godot, when
running, will detect this and make a sidecar `.import` file. Then, add the path to the list of
files in `global.gd` e.g.

```{godot}
var avatars = [
	load("res://art/avatars/angry_pasteur.svg"),
	load("res://art/avatars/circle_avatar.svg"),
	load("res://art/avatars/generic_doctor.svg")
	]
```

To remove an avatar, delete the file from the `art/avatars/` dir and remove the path from `global.gd`.