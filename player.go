// player.go
package main

import (
	"fmt"
	"os"
	"os/exec"
	"strconv"
)

func playVideo(filePath string, speed float64) {
	if _, err := os.Stat(filePath); os.IsNotExist(err) {
		fmt.Printf("Error: File '%s' not found.\n", filePath)
		return
	}
	var cmd *exec.Cmd
	if speed < 0.5 {
		cmd = exec.Command("ffplay", "-vf", fmt.Sprintf("setpts=PTS/%v", speed), filePath)
	} else {
		cmd = exec.Command("ffplay", "-vf", fmt.Sprintf("setpts=PTS/%v", speed), "-af", fmt.Sprintf("atempo=%v", speed), filePath)
	}
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	err := cmd.Run()
	if err != nil {
		if _, ok := err.(*exec.ExitError); ok {
			// ffplay exited with non-zero status (user quit)
			return
		}
		fmt.Printf("Error playing: %v\n", err)
	}
}

func main() {
	if len(os.Args) < 2 {
		fmt.Println("Usage: go run player.go <video_file> [speed]")
		fmt.Println("  speed: float (default 0.5)")
		os.Exit(1)
	}
	filePath := os.Args[1]
	speed := 0.5
	if len(os.Args) > 2 {
		if s, err := strconv.ParseFloat(os.Args[2], 64); err == nil {
			speed = s
		}
	}
	playVideo(filePath, speed)
}
