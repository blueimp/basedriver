#!/bin/sh

# Start Xvfb in a background process:
Xvfb "$DISPLAY" -screen 0 "$SCREEN_WIDTH""x""$SCREEN_HEIGHT""x""$SCREEN_DEPTH" \
  -ac +extension RANDR -nolisten tcp &

printf 'Waiting for Xvfb to start ... '
TIMEOUT=10
while ! xdpyinfo -display "$DISPLAY" >/dev/null 2>&1; do
  TIMEOUT=$((TIMEOUT-1))
  if [ $TIMEOUT -lt 0 ]; then
    echo timeout
    exit 1
  fi
  sleep 0.5
done
echo 'done'

if [ "$VNC_ENABLED" = true ]; then
  # Disable fbsetbg and start fluxbox in a background process:
  mkdir -p ~/.fluxbox && echo 'background: unset' >> ~/.fluxbox/overlay
  fluxbox -display "$DISPLAY" &

  # Start VNC in a background process:
  x11vnc -display "$DISPLAY" -forever -shared -rfbport "${VNC_PORT:-5900}" \
    -passwd "${VNC_PASSWORD:-secret}" &
fi

# Start the webdriver implementation:
exec "$@"
