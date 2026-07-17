// player.swift
import Foundation

func playVideo(filePath: String, speed: Double = 0.5) {
    let fileManager = FileManager.default
    if !fileManager.fileExists(atPath: filePath) {
        print("Error: File '\(filePath)' not found.")
        return
    }
    var args = ["ffplay"]
    if speed < 0.5 {
        args.append(contentsOf: ["-vf", "setpts=PTS/\(speed)"])
    } else {
        args.append(contentsOf: ["-vf", "setpts=PTS/\(speed)", "-af", "atempo=\(speed)"])
    }
    args.append(filePath)
    let task = Process()
    task.executableURL = URL(fileURLWithPath: "/usr/bin/env")
    task.arguments = args
    task.standardOutput = FileHandle.standardOutput
    task.standardError = FileHandle.standardError
    do {
        try task.run()
        task.waitUntilExit()
    } catch {
        if let error = error as? NSError, error.domain == NSCocoaErrorDomain && error.code == 4 {
            print("Error: ffplay not found. Please install FFmpeg.")
        } else {
            print("Error: \(error.localizedDescription)")
        }
    }
}

let arguments = CommandLine.arguments
if arguments.count < 2 {
    print("Usage: swift player.swift <video_file> [speed]")
    print("  speed: float (default 0.5)")
    exit(1)
}
let filePath = arguments[1]
let speed = arguments.count > 2 ? Double(arguments[2]) ?? 0.5 : 0.5
playVideo(filePath: filePath, speed: speed)
