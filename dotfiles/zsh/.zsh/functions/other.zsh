recaudio() {
  mkdir -p ~/Videos/recordings
  recording_name="$(date +%d_%m_%y-%H_%M_%S)"

  export RECORDING_PID=$!
}

recvideo() {
  mkdir -p ~/Videos/recordings
  recording_name="$(date +%d_%m_%y-%H_%M_%S)"
  ffmpeg -f x11grab -i $DISPLAY -r 25 -f pulse -i bluez_output.4C_87_5D_56_06_55.1.monitor -acodec aac -vcodec libx264 -y ~/Videos/recordings/${recording_name}.mp4 &
  export RECORDING_PID=$!
}

recstop() {
  kill $RECORDING_PID
}
