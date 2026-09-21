# 🎣 Lucky Catch

[![Engine: Godot 4.x](https://img.shields.io/badge/Engine-Godot%204.x-478cbf?logo=godotengine&logoColor=white)](https://godotengine.org)
[![Jam: BGJAM 2026](https://img.shields.io/badge/Event-BGJAM%202026-brightgreen)](https://itch.io)
[![Resolution: 160x144](https://img.shields.io/badge/Resolution-160x144%20(Game%20Boy)-yellow)](https://en.wikipedia.org/wiki/Game_Boy)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

> A retro-inspired, tension-based fishing minigame developed for **BGJAM 2026**.

Cast your line into tranquil waters and test your reflexes against a quirky cast of aquatic and otherworldly creatures! Built to honor the authentic constraints and charm of classic handheld gaming, **Lucky Catch** features a 160×144 pixel viewport, a 4-tone palette aesthetic, retro sound effects, and an interactive collection catalog.

---

## 🎮 What is Lucky Catch?

In **Lucky Catch**, players grab their bamboo fishing rod and cast into the river in search of elusive water dwellers. Once a creature bites, you enter an intense tug-of-war where patience, timing, and tension control are everything.

Keep your tension within the dynamic safe zone to wear the fish down. But be careful—the creatures fight back! As the struggle intensifies, safe zones shrink, speeds increase, and staying outside the safe zone for too long will snap your line.

Can you fill out your Fish Collection and catch every creature from the common *Salmon* to the legendary *Space Worm* and *Wing Snake*?

---

## ✨ Features

- **Tension Balancing Minigame**: Control the reel by tapping and holding to keep the tension needle inside the safe zone while the fish thrashes.
- **Dynamic Difficulty Scaling**: The longer a fish fights, the faster the tension shifts and the smaller the safe zone becomes.
- **13 Unique Catchables across 4 Rarities**:
  - 🐟 **Common**: *Useless Can*, *Weird Plant*, *Salmon*, *Tiny Fish*
  - 🌿 **Uncommon**: *Happy Jelly*, *Tortle*, *Looking Heart*, *Creepy Starfish*
  - 🐙 **Rare**: *Confused Octo*, *Jacket Fish*, *Venomu*
  - 🐉 **Legendary**: *Space Worm*, *Wing Snake*
- **Fish Collection Book ("Fishdex")**: Review your catches anytime! Uncaught species appear as mystery silhouettes until you reel them in.
- **Authentic Game Boy Aesthetic**:
  - Native 160 × 144 viewport with clean integer scaling.
  - Classic monochrome / 4-shade pixel art styling.
  - Looping chiptune soundtrack and reactive 8-bit sound effects (with pitch variation).
- **Cross-Platform Ready**: Built with Godot's GL Compatibility renderer and configured for instant Web (HTML5/WebGL) play.

---

## 🕹️ Controls

Lucky Catch uses a Game Boy-inspired control scheme:

| Action | Key (Keyboard) | Game Boy Equivalent | Description |
| :--- | :---: | :---: | :--- |
| **Cast / Start** | <kbd>A</kbd> | **(A) Button** | Start game on title screen / Cast bobber into water |
| **Reel** | <kbd>S</kbd> | **(B) Button** | Hook biting fish / Hold to build tension while reeling |
| **Dismiss / Continue** | <kbd>V</kbd> | **Select** | Close catch result / failure pop-up screen |
| **Collection Book** | <kbd>C</kbd> | **Start** | Toggle the Fish Collection book open/closed |
| **Rod Control** | <kbd>←</kbd> / <kbd>→</kbd> | **D-Pad Left / Right** | Pull bamboo rod left or right |
| **Scroll Collection** | <kbd>↑</kbd> / <kbd>↓</kbd> | **D-Pad Up / Down** | Scroll through caught fish in the collection menu |

---

## 🎣 How to Play

1. **Cast**: On the riverbank, press <kbd>A</kbd> to cast your bobber into the water.
2. **Wait for a Bite**: Watch the water closely. When ripples appear and you hear a splash, a fish is biting!
3. **Hook the Catch**: Quickly press <kbd>S</kbd> to hook the fish and initiate the reel battle.
4. **Control the Tension**:
   - Hold <kbd>S</kbd> to increase reel tension.
   - Release <kbd>S</kbd> to let the tension decrease.
   - Keep the tension indicator inside the highlighted **Safe Zone**.
   - If you stay outside the safe zone for more than 3 seconds, the fish escapes!
5. **Land the Fish**: Keep the tension balanced until the catch timer completes.
6. **Check Your Bestiary**: Press <kbd>C</kbd> between casts to check which species you have discovered and which silhouettes remain unsolved!

---

## 🛠️ Technical Details & Architecture

- **Game Engine**: [Godot Engine 4.x](https://godotengine.org/) (GL Compatibility renderer)
- **Target Resolution**: 160 × 144 (Scaled with `integer` viewport scaling mode to 800 × 720)
- **Architecture**:
  - `StateManager`: Centralized event bus coordinating game states (`IDLE`, `CASTING`, `WAITING`, `BITE`, `FIGHT`, `CAUGHT`, `FAILED`).
  - `FishManager`: Handles fish probability tables (weighted rarity generation) and catch persistence.
  - `FishData`: Extensible Godot `Resource` class configuring individual fish silhouettes, sprites, movement radii, danger limits, and difficulty multipliers.
  - `SoundPlayer` & `MusicPlayer`: Autoload audio singletons with dynamic pitch modulation.

---

## 📁 Project Structure

```text
luckyCatch/
├── assets/                  # Raw and imported pixel art, fonts, audio
│   ├── fishes/              # Fish sprites & silhouettes
│   ├── fishingRod/          # Rod & bobber textures
│   ├── fonts/               # 3x5 tiny mono pixel font
│   ├── music/               # Main theme chiptune track
│   ├── river/ & sky/        # Background environment sprites
│   ├── sounds/              # Splash & ripple SFX
│   └── ui/                  # Reel bar, buttons, & frames
├── fish_resources/          # Individual .tres FishData resources
├── managers/                # Global autoload scripts (State, Fish)
├── scenes/                  # Game scenes & UI modules
│   ├── environment/         # River & sky backdrops
│   ├── fishingRod/          # Rod, bobber, & fishing logic
│   ├── main/                # Title screen
│   ├── music/ & sounds/     # Audio management
│   ├── ui/                  # HUD, Reel bar, Pop-up, Collection book
│   ├── vfx/                 # Water ripple visual effects
│   └── world/               # Main gameplay scene
├── exports/                 # Web export build output
├── fish_data.gd             # Custom Resource definition for fish
└── project.godot            # Godot project configuration
```

---

## 🚀 Running the Project

### Prerequisites
- [Godot Engine 4.x](https://godotengine.org/download) (Version 4.3+ / 4.7-dev compatible)

### Launch via Godot Editor
1. Clone the repository:
   ```bash
   git clone https://github.com/AparneetDey/luckyCatch.git
   ```
2. Open Godot Engine and click **Import**.
3. Select `project.godot` inside the `luckyCatch` folder.
4. Press **F5** (or click the Play icon in the top-right corner) to run the game.

### Web Build
An exported Web (HTML5/WebGL) build is located under [`exports/web1/index.html`](exports/web1/index.html). You can host it using any local HTTP server (such as Python's `python -m http.server 8000` or Godot's built-in web preview).

---

## 🏆 Game Jam

This game was created for **BGJAM 2026** (Game Boy Jam 2026).

---

## 📄 License

This project is licensed under the [MIT License](LICENSE) - see the [LICENSE](LICENSE) file for details.
