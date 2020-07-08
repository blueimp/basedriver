# Base Webdriver Dockerfile

This is a base [Dockerfile](https://docs.docker.com/engine/reference/builder/)
to create [Webdriver](https://www.w3.org/TR/webdriver/) Docker images.

- [Usage](#usage)
- [Software](#software)
- [Configuration](#configuration)
- [License](#license)
- [Author](#author)

## Usage

The base image runs a given command in a virtual
[X Window System](https://en.wikipedia.org/wiki/X_Window_System):

```sh
docker run blueimp/basedriver COMMAND
```

As this is not every useful by itself, please refer to the following projects,
which extend this image with Webdriver servers:

- [blueimp/chromedriver](https://github.com/blueimp/chromedriver) (Chrome
  Webdriver)
- [blueimp/geckodriver](https://github.com/blueimp/geckodriver) (Firefox
  Webdriver)

## Software

The following software is included in the `blueimp/basedriver` image:

- [Debian base image](https://hub.docker.com/_/debian) (buster-slim)
- [Xvfb](https://en.wikipedia.org/wiki/Xvfb) as virtual display server
- [Fluxbox](https://en.wikipedia.org/wiki/Fluxbox) as lightweight window manager
- [rxvt-unicode](https://en.wikipedia.org/wiki/Rxvt) as lightweight terminal
  emulator
- [x11vnc](https://en.wikipedia.org/wiki/X11vnc) for remote access via
  [VNC](https://en.wikipedia.org/wiki/Virtual_Network_Computing)
- [curl](https://en.wikipedia.org/wiki/CURL) to download additional software

## Configuration

Docker containers based on this image can be configured with the following
environment variables (listed are the default values):

```sh
# Virtual screen width:
SCREEN_WIDTH=1440
# Virtual screen height:
SCREEN_HEIGHT=900
# Virtual screen color depth:
SCREEN_DEPTH=24
# X11 DISPLAY variable (hostname:display.screen):
DISPLAY=:0

# Set to true to disable the X Window Server:
DISABLE_X11=
# Set to true to expose the X Window Server via TCP:
EXPOSE_X11=

# Set to true to enable the VNC server:
ENABLE_VNC=
# VNC server port:
VNC_PORT=5900
# VNV access password:
VNC_PASSWORD=secret
```

**Please note:**  
The X11 port number is inferred from the display number (defined by the
`DISPLAY` variable) plus `6000`, which defaults to port `6000`.

## License

Released under the [MIT license](https://opensource.org/licenses/MIT).

## Author

[Sebastian Tschan](https://blueimp.net/)
