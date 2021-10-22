# Export the game for Windows, Mac and Linux
E:\Documents\Programs\Godot\Godot_v3.2.1.exe project.godot --export "Windows" ".\export\Galactiball (Windows)\Galactiball.exe"
E:\Documents\Programs\Godot\Godot_v3.2.1.exe project.godot --export "Mac" ".\export\Galactiball (Mac)\Galactiball.zip"
E:\Documents\Programs\Godot\Godot_v3.2.1.exe project.godot --export "Linux" ".\export\Galactiball (Linux)\Galactiball.x86_64"

# Zip all executables together
Remove-Item .\export\Galactiball.zip
Compress-Archive .\export\* .\export\Galactiball.zip
