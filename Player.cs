// Player.cs
using System;
using System.Diagnostics;
using System.IO;

class Player
{
    static void PlayVideo(string filePath, double speed = 0.5)
    {
        if (!File.Exists(filePath))
        {
            Console.WriteLine($"Error: File '{filePath}' not found.");
            return;
        }
        string args = "";
        if (speed < 0.5)
        {
            args = $"-vf setpts=PTS/{speed}";
        }
        else
        {
            args = $"-vf setpts=PTS/{speed} -af atempo={speed}";
        }
        args += $" \"{filePath}\"";

        var process = new Process
        {
            StartInfo = new ProcessStartInfo
            {
                FileName = "ffplay",
                Arguments = args,
                UseShellExecute = false,
                RedirectStandardOutput = true,
                RedirectStandardError = true,
                CreateNoWindow = true
            }
        };
        try
        {
            process.Start();
            process.WaitForExit();
        }
        catch (Exception ex)
        {
            if (ex is System.ComponentModel.Win32Exception)
            {
                Console.WriteLine("Error: ffplay not found. Please install FFmpeg.");
            }
            else
            {
                Console.WriteLine($"Error: {ex.Message}");
            }
        }
    }

    static void Main(string[] args)
    {
        if (args.Length < 1)
        {
            Console.WriteLine("Usage: Player.exe <video_file> [speed]");
            Console.WriteLine("  speed: float (default 0.5)");
            return;
        }
        string filePath = args[0];
        double speed = 0.5;
        if (args.Length > 1)
        {
            double.TryParse(args[1], out speed);
        }
        PlayVideo(filePath, speed);
    }
}
