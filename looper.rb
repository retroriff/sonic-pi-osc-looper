# Sonic Pi OSC Looper: 1 Track
# Date: 2018/12/09
# Author: https://github.com/retroriff/

# User Settings ###############################################################

slices = 16
samples = "~/Music/Samples/Looper/"

# Knobs #######################################################################

a = 0 # 1. Sample number
b = 0 # 2. Moves starting point
c = 0 # 3. Changes Loop Duration

# Set Up ######################################################################

set :continueplay, nil
s = sample_paths samples
slices_f = "#{slices}.00".to_f
s_d = []
s.each_with_index do |item, index|
  s_d[index] = sample_duration(item)
end
sTotal = s_d.count
minimumLength = 1 / slices_f
i = 0; vStart = 0, vLength = 1; vFinish = 1; vSleep = 1; t = 0; a = 0; b = 0; c = 0; playSample = 0;
puts "Hi! We'll play with #{sTotal} samples at:"
puts "#{samples}"

# Loop Functions ###############################################################

# Calculate loop
define :calculate_loop do
  i = (a*sTotal).round
  if i > (sTotal-1) then i = (sTotal-1) end
  vStart = (b*slices).round / slices_f
  vLength = (c*slices).round / slices_f
  if vLength < minimumLength then vLength = minimumLength end
  t = s_d[i]
  puts "Sample #{i}, Started: #{vStart}, Lenght: #{vLength}, LengthTotal: #{t}"
  if (vStart + vLength > 1) then vLength = 1 - vStart end
  vFinish = vStart + vLength
  if (vFinish > 1) then vFinish = 1 end
  if (vStart >= 1) then vStart = 0 end
  vSleep = (vFinish-vStart)*t
  puts "vSleep #{vSleep}, vFinish: #{vFinish}, vStart: #{vStart}, t: #{t}"
end

# Start
live_loop :startcue do
  use_real_time
  a, b, c = sync "/osc/start"
  puts "started a:#{a} b:#{b} c:#{c}"
  calculate_loop
  set :continueplay,1
end

# Stop
live_loop :stopcue do
  use_real_time
  a = sync "/osc/stop"
  puts "stopping"
  set :continueplay,0
  kill playSample
end

# Modulate
live_loop :knobcue do
  use_real_time
  a, b, c = sync "/osc/modulate"
  calculate_loop
end

# Loop
live_loop :bass_line do
  if get(:continueplay)==1 then
    puts "Start: #{vStart}, Finish: #{vFinish}, Sleep: #{vSleep}, Duration: #{t}"
    playSample = sample s, i, start: vStart, finish: vFinish
  end
  sleep vSleep
end