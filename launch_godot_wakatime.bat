@echo off

REM Send WakaTime heartbeat for Godot project
wakatime --write --entity "Godot Editor" --entity-type app --project "berry-bounce" --plugin "godot-wakatime/1.0.0"

REM Open Godot editor using full path
start "" "C:\Users\dasha\Downloads\Godot_v4.4.1-stable_win64.exe"

pause
