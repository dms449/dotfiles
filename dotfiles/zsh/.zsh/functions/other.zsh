startRecording() {
  export TEMP_PID=$(sleep 60 &)
  export RECORDING_PID=ffmpeg -f x11grab -i $DISPLAY -r 25 -f pulse -i bluez_output.4C_87_5D_56_06_55.1.monitor -acodec aac -vcodec libx264 -y ~/Videos/test.mp4 &
}

stopRecording() {
  kill $RECORDING_PID
}


