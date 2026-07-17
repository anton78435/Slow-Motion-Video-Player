// Player.java
import java.io.File;
import java.io.IOException;

public class Player {
    public static void playVideo(String filePath, double speed) {
        File file = new File(filePath);
        if (!file.exists()) {
            System.err.println("Error: File '" + filePath + "' not found.");
            return;
        }
        String args;
        if (speed < 0.5) {
            args = "-vf setpts=PTS/" + speed;
        } else {
            args = "-vf setpts=PTS/" + speed + " -af atempo=" + speed;
        }
        args += " \"" + filePath + "\"";

        ProcessBuilder pb = new ProcessBuilder("ffplay", args.split(" "));
        pb.inheritIO();
        try {
            Process p = pb.start();
            p.waitFor();
        } catch (IOException e) {
            if (e.getMessage().contains("No such file or directory")) {
                System.err.println("Error: ffplay not found. Please install FFmpeg.");
            } else {
                System.err.println("Error: " + e.getMessage());
            }
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
    }

    public static void main(String[] args) {
        if (args.length < 1) {
            System.out.println("Usage: java Player <video_file> [speed]");
            System.out.println("  speed: float (default 0.5)");
            return;
        }
        String filePath = args[0];
        double speed = 0.5;
        if (args.length > 1) {
            try {
                speed = Double.parseDouble(args[1]);
            } catch (NumberFormatException e) {
                // ignore
            }
        }
        playVideo(filePath, speed);
    }
}
