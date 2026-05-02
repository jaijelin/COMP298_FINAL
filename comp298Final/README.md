# System 1
The Party System is an entirely data-driven system shown off using debug buttons. Can be used in any game where you have a team of guys (like Wildfrost or Monster Train)
- a team of guys
- each guy has stats like health, attack cooldown, moves
- using moves sends it to the battle manager’s attack cue (threaded?). attacks themselves don’t have a target, the battle manager handles targeting (pretty much all random for demo sake)
- guys die when dead, you get the drill
- has positions (that do not change for demo sake)
- in our game this is only used in the battles, but could be used in tons of other areas like a menu where you change positions or upgrade your guys. It could even be morphed into thing that manages a set of tools which have durability in place of health
- could have xp and level ups but I don’t think we care for this project
# System 2
The Random Encounter System handles:
- entering a random encounter
- rolling the enemies for the encounter (fixed list)
- the enemies attack (a random living party member) off cooldown and die when dead
- all attacks from both sides sent to an attack cue on its own thread with random targetting
The battle manager system. This uses the teams system as a data support to run a battle scene. Useful in any turn-based game.
# System 3
The UI system
- battle UI
- pause menu (accessible from anywhere, not just battle)

make the UI for a pokemon battle. It should have a battle manager. The challengers/teams should be children of the battle manager. Each team should know its current pokemon so that it can point to it for the battle manager's sake. The purpose of the battle manager is to provide information to hold information to be used by the UI root scene (which can update the UI) and do the actual management of the battle.
These challenges/teams are useful bc we can slot them in here, but we can also slot them into other bits of UI, namely the switch pokemon screen. That said, if we take cues from FNAF world we don't have to have a switch pokemon screen.
Overall, I think this should be applicable to the pokemon battler genre but also roguelite games where you have a team of guys (Wildfrost, Monster Train)

I also want to have a world system. Like how in pokemon you can use your pokemon to interact with a world you as the player otherwise cannot affect. Or like pikmin. Or a little bit fnaf world too.

win condition as catch specfic pokemon- we can team pre-set to save time

player sprites: 
Wolfang62-  https://www.deviantart.com/wolfang62/art/Leaf-Sprite-Overworld-887602743

map sprites: 
Segesi-  https://www.deviantart.com/segesi/gallery/46973780/maps-tiles-and-mock-ups

zerudez-https://www.deviantart.com/zerudez/art/Public-Tileset-295115322
