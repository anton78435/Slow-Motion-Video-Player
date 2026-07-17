// player.js
const { exec } = require('child_process');
const fs = require('fs');

function playVideo(filePath, speed = 0.5) {
    if (!fs.existsSync(filePath)) {
        console.error(`Error: File '${filePath}' not found.`);
        return;
    }
    let args = ['ffplay'];
    if (speed < 0.5) {
        args.push('-vf', `setpts=PTS/${speed}`);
    } else {
        args.push('-vf', `setpts=PTS/${speed}`);
        args.push('-af', `atempo=${speed}`);
    }
    args.push(filePath);
    const proc = exec(args.join(' '), (error, stdout, stderr) => {
        if (error) {
            if (error.code === 127) {
                console.error('Error: ffplay not found. Please install FFmpeg.');
            }
        }
    });
    proc.stdout.pipe(process.stdout);
    proc.stderr.pipe(process.stderr);
}

if (process.argv.length < 3) {
    console.log('Usage: node player.js <video_file> [speed]');
    console.log('  speed: float (default 0.5)');
    process.exit(1);
}
const filePath = process.argv[2];
const speed = parseFloat(process.argv[3]) || 0.5;
playVideo(filePath, speed);
