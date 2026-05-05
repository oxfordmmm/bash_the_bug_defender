# Bash the Bug Defender

Game to be played on dancemat where you need to defend the human cell from attacking bacteria.

Current mechanism is firing antibiotics at invading bacteria.
Use the bottom 3 bottoms to select antibiotic.
Bugs will start developing resistance

## Scoring

The game will make a file called `bash_the_bug_scores.csv` on the desktop to track scores and is used for showing high scores. It tracks player name, difficulty, and score.

1. To start afresh simply delete or rename the file
2. Only the top players plus the current player get displayed
3. After the session is finished open the scores csv and delete the names column to avoid GDPR issues

## Adding / Removing Avatars

To add an avatar just add an image file to `art/avatars` folder. Preferablly they will be PNG or SVG files so that they have transparent background (but `jpg`/`jpeg` will also be read).
The image will be scale to fit a 120x130 box (preserving aspect ration)
