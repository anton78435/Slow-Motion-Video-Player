# player.rb
def play_video(file_path, speed = 0.5)
  unless File.exist?(file_path)
    puts "Error: File '#{file_path}' not found."
    return
  end
  args = []
  if speed < 0.5
    args = ['-vf', "setpts=PTS/#{speed}"]
  else
    args = ['-vf', "setpts=PTS/#{speed}", '-af', "atempo=#{speed}"]
  end
  args << file_path
  begin
    system('ffplay', *args)
  rescue Errno::ENOENT
    puts "Error: ffplay not found. Please install FFmpeg."
  end
end

if ARGV.length < 1
  puts "Usage: ruby player.rb <video_file> [speed]"
  puts "  speed: float (default 0.5)"
  exit 1
end

file_path = ARGV[0]
speed = (ARGV[1] || '0.5').to_f
play_video(file_path, speed)
