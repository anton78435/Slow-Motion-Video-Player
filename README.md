🎬 Slow‑Motion Video Player – Multi‑Language Edition
A lightweight video player that plays any video file in slow motion (or fast motion) using ffplay (FFmpeg).
Control playback speed via a simple command‑line argument.
Built in 7 programming languages – each implementation calls the same powerful FFmpeg backend.

✨ Features
Play any video – supports all formats that FFmpeg can handle.

Adjustable speed – specify a speed factor (e.g., 0.5 for half speed, 2.0 for double speed).

No dependencies – just requires ffplay installed on your system (part of FFmpeg).

Simple CLI – pass video path and optional speed.

Cross‑platform – works on Windows, macOS, and Linux (with FFmpeg installed).

🗂 Languages & Files
Language	File
Python	player.py
Go	player.go
JavaScript (Node)	player.js
C#	Player.cs
Java	Player.java
Ruby	player.rb
Swift	player.swift
🚀 How to Run
Each file is standalone – run it with the appropriate interpreter/compiler.

Language	Command
Python	python player.py video.mp4 [speed]
Go	go run player.go video.mp4 [speed]
JavaScript	node player.js video.mp4 [speed]
C#	dotnet run -- video.mp4 [speed]
Java	javac Player.java && java Player video.mp4 [speed]
Ruby	ruby player.rb video.mp4 [speed]
Swift	swift player.swift video.mp4 [speed]
If no speed is given, the default is 0.5 (half speed).
The speed can be any positive float (e.g., 0.25, 1.5, 2.0).

🎮 Controls (ffplay)
During playback, you can use ffplay’s built‑in controls:

Space – pause/play

→ / ← – seek forward/backward 10 seconds

↑ / ↓ – seek forward/backward 1 minute

Esc / q – quit

📦 Requirements
FFmpeg (ffplay) must be installed and available in your PATH.

macOS: brew install ffmpeg

Linux: sudo apt install ffmpeg

Windows: download from ffmpeg.org and add to PATH.

📜 License
MIT – use freely.

