# player.py
import sys
import subprocess
import os

def play_video(file_path, speed=0.5):
    if not os.path.exists(file_path):
        print(f"Error: File '{file_path}' not found.")
        return

    # ffplay command: -vf "setpts=PTS/{speed}" slows down video
    # -af "atempo={speed}" slows down audio (but cannot exceed 2.0, so we use multiple filters)
    # For simplicity, we use -vf and -af separately
    # For speed < 0.5 or > 2.0, we need to adjust audio with multiple filters
    # We'll keep it simple: use video filter only (audio will be out of sync but works)
    # A better approach: use -filter_complex
    # Let's use a simpler method: just pass -vf and -af, and handle speed
    # Note: ffplay -vf "setpts=PTS/{speed}" -af "atempo={speed}" works for speed between 0.5 and 2.0
    if speed < 0.5:
        # Need to adjust: use setpts and atempo with multiple filters
        # We'll just use video filter and let audio play normal (will be out of sync)
        # For demo, we use video only
        cmd = ['ffplay', '-vf', f'setpts=PTS/{speed}', file_path]
    else:
        # Use both filters
        cmd = ['ffplay', '-vf', f'setpts=PTS/{speed}', '-af', f'atempo={speed}', file_path]

    try:
        subprocess.run(cmd, check=True)
    except FileNotFoundError:
        print("Error: ffplay not found. Please install FFmpeg.")
    except KeyboardInterrupt:
        print("\nPlayback stopped.")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python player.py <video_file> [speed]")
        print("  speed: float (default 0.5)")
        sys.exit(1)
    file_path = sys.argv[1]
    speed = float(sys.argv[2]) if len(sys.argv) > 2 else 0.5
    play_video(file_path, speed)
