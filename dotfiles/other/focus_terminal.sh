if ps aux | grep "[g]nome-terminal" > /dev/null
then 
  desktop="$(xdotool get_desktop)"
  window="$(xdotool search --onlyvisible --desktop $desktop --class gnome-terminal)"
  xdotool windowactivate $window

else gnome-terminal
fi
