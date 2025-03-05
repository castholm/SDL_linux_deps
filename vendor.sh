#!/usr/bin/env bash

# © 2024 Carl Åstholm
# SPDX-License-Identifier: MIT

set -euxo pipefail

ALSA_LIB_URL=https://github.com/alsa-project/alsa-lib.git
ALSA_LIB_REV=785fd327ada6fc1778a2bb21176cb66705eb6b33 # v1.2.13

DBUS_URL=https://gitlab.freedesktop.org/dbus/dbus.git
DBUS_REV=958bf9db2100553bcd2fe2a854e1ebb42e886054 # dbus-1.16.2

DRM_URL=https://gitlab.freedesktop.org/mesa/drm.git
DRM_REV=38ec7dbd4df3141441afafe5ac62dfc9df36a77e # libdrm-2.4.124

GLIB_URL=https://gitlab.gnome.org/GNOME/glib.git
GLIB_REV=4fc67fd461bfbf13c32579690f6280b0d0d0350d # 2.82.5

IBUS_URL=https://github.com/ibus/ibus.git
IBUS_REV=baeddb89a78d7ebb9eea384a07ea1af8bfa76e41 # 1.5.31

JACK1_URL=https://github.com/jackaudio/jack1.git
JACK1_REV=48b2d8a525b0082dded4a9d1d6137a2767962b2a # 0.126.0

LIBDECOR_URL=https://gitlab.freedesktop.org/libdecor/libdecor.git
LIBDECOR_REV=7807ae3480f5c6a37c5e8505d94af1e764aaf704 # 0.2.2

LIBURING_URL=https://github.com/axboe/liburing.git
LIBURING_REV=08468cc3830185c75f9e7edefd88aa01e5c2f8ab # liburing-2.9

LIBUSB_URL=https://github.com/libusb/libusb.git
LIBUSB_REV=d52e355daa09f17ce64819122cb067b8a2ee0d4b # v1.0.27

LIBX11_URL=https://gitlab.freedesktop.org/xorg/lib/libx11.git
LIBX11_REV=23f0352eca362515d598bfdbd8ecec070dcd1b28 # libX11-1.8.11

LIBXCB_URL=https://gitlab.freedesktop.org/xorg/lib/libxcb.git
LIBXCB_REV=622152ee42a310876f10602601206954b8d0613e # libxcb-1.17.0

LIBXCURSOR_URL=https://gitlab.freedesktop.org/xorg/lib/libxcursor.git
LIBXCURSOR_REV=8ae6cf61b18ecddf26f72a07bbfbd1ea9f022c36 # libXcursor-1.2.3

LIBXEXT_URL=https://gitlab.freedesktop.org/xorg/lib/libxext.git
LIBXEXT_REV=3826a58d190c2d8093d3586cb33867668cbb4553 # libXext-1.3.6

LIBXFIXES_URL=https://gitlab.freedesktop.org/xorg/lib/libxfixes.git
LIBXFIXES_REV=c1cab28e27dd1c5a81394965248b57e490ccf2ca # libXfixes-6.0.1

LIBXI_URL=https://gitlab.freedesktop.org/xorg/lib/libxi.git
LIBXI_REV=3c2d5aedd7708c75710b39268631762de904c304 # libXi-1.8.2

LIBXKBCOMMON_URL=https://github.com/xkbcommon/libxkbcommon.git
LIBXKBCOMMON_REV=76740e0c4583ae49675e7ba8213d31ee09aa00d2 # xkbcommon-1.8.0

LIBXRANDR_URL=https://gitlab.freedesktop.org/xorg/lib/libxrandr.git
LIBXRANDR_REV=512bf0b15b5597c721ff8c61083616ca9040fa72 # libXrandr-1.5.4

LIBXRENDER_URL=https://gitlab.freedesktop.org/xorg/lib/libxrender.git
LIBXRENDER_REV=46e12ff9e8e4d3f0313a2f097df93dbfdc14f92f # libXrender-0.9.12

LIBXSCRNSAVER_URL=https://gitlab.freedesktop.org/xorg/lib/libxscrnsaver.git
LIBXSCRNSAVER_REV=34f3f72b88c0a0a10d618e9dfbc88474ae5ce880 # libXScrnSaver-1.2.4

MESA_URL=https://gitlab.freedesktop.org/mesa/mesa.git
MESA_REV=4fa244fddfebb21378042556862e197284ef65ac # mesa-25.0.0

PIPEWIRE_URL=https://gitlab.freedesktop.org/pipewire/pipewire.git
PIPEWIRE_REV=cc7439187f61dd73b81ca69f5dbccbb52ce970b2 # 1.2.7

PULSEAUDIO_URL=https://gitlab.freedesktop.org/pulseaudio/pulseaudio.git
PULSEAUDIO_REV=1f020889c9aa44ea0f63d7222e8c2b62c3f45f68 # v17.0

SDL_URL=https://github.com/libsdl-org/SDL.git
SDL_REV=f6864924f76e1a0b4abaefc76ae2ed22b1a8916e # release-3.2.8

SNDIO_URL=https://github.com/ratchov/sndio.git
SNDIO_REV=366b5c84d57c9ce73387c51ca48755d36e3fe3a7 # v1.10.0

SYSTEMD_URL=https://github.com/systemd/systemd.git
SYSTEMD_REV=876ee10e0eb4bbb0920bdab7817a9f06cc34910f # v257.3

WAYLAND_URL=https://gitlab.freedesktop.org/wayland/wayland.git
WAYLAND_REV=a9fec8dd65977c57f4039ced34327204d9b9d779 # 1.23.1

XCBPROTO_URL=https://gitlab.freedesktop.org/xorg/proto/xcbproto.git
XCBPROTO_REV=77d7fc04da729ddc5ed4aacf30253726fac24dca # xcb-proto-1.17.0

XORGPROTO_URL=https://gitlab.freedesktop.org/xorg/proto/xorgproto.git
XORGPROTO_REV=67469711055522b8adb2d795b01e7ba98cb8816c # xorgproto-2024.1

TMP_PREFIX=_tmp

repo_ensure_cloned() {
	repo=$1

	repo_url_var="${repo}_URL"
	repo_url="${!repo_url_var}"
	declare -g "${repo}_DIR=$TMP_PREFIX/$(basename -s.git "$repo_url")"
	repo_dir_var="${repo}_DIR"
	repo_dir="${!repo_dir_var}"
	if [ ! -d "$repo_dir" ]; then
		mkdir -p "$repo_dir"
		pushd "$repo_dir"
		git init -q
		repo_rev_var="${repo}_REV"
		repo_rev="${!repo_rev_var}"
		git fetch "$repo_url" "$repo_rev" --depth 1
		git checkout -q FETCH_HEAD
		popd
	fi
}

repo_copy() {
	repo=$1; src=("${@:2:$#-2}"); dst="${*:$#}"

	repo_dir_var="${repo}_DIR"
	repo_dir="${!repo_dir_var}"
	mkdir -p "$dst"
	cp "${src[@]/#/$repo_dir/}" "$dst/"
}

opengl() {
	repo_ensure_cloned MESA

	headers=(
		include/GL/gl.h
		include/GL/glext.h
		include/GL/glx.h
		include/GL/glxext.h
	)
	repo_copy MESA "${headers[@]}" include/GL
}

wayland() {
	repo_ensure_cloned WAYLAND

	headers=(
		src/wayland-client.h
		src/wayland-client-core.h
		src/wayland-util.h

		cursor/wayland-cursor.h

		egl/wayland-egl.h
		egl/wayland-egl-core.h
	)
	repo_copy WAYLAND "${headers[@]}" include

	version=1.23.1
	version_parts=(${version//./ })
	mkdir -p include
	sed "$WAYLAND_DIR/src/wayland-version.h.in" \
		-e "s/@WAYLAND_VERSION_MAJOR@/${version_parts[0]}/g" \
		-e "s/@WAYLAND_VERSION_MINOR@/${version_parts[1]}/g" \
		-e "s/@WAYLAND_VERSION_MICRO@/${version_parts[2]}/g" \
		-e "s/@WAYLAND_VERSION@/$version/g" \
	> include/wayland-version.h

	mkdir -p include
	wayland-scanner client-header "$WAYLAND_DIR/protocol/wayland.xml" include/wayland-client-protocol.h

	generate() {
		xml=$1
		protocol_name=$(basename "$xml" .xml)
		mkdir -p src
		wayland-scanner client-header "$xml" "src/$protocol_name-client-protocol.h"
		wayland-scanner private-code "$xml" "src/$protocol_name-protocol.c"
	}

	repo_ensure_cloned SDL

	# Prefer SDL's vendored protocols over their canonical counterparts
	generate "$SDL_DIR/wayland-protocols/alpha-modifier-v1.xml"
	generate "$SDL_DIR/wayland-protocols/color-management-v1.xml"
	generate "$SDL_DIR/wayland-protocols/cursor-shape-v1.xml"
	generate "$SDL_DIR/wayland-protocols/fractional-scale-v1.xml"
	generate "$SDL_DIR/wayland-protocols/frog-color-management-v1.xml"
	generate "$SDL_DIR/wayland-protocols/idle-inhibit-unstable-v1.xml"
	generate "$SDL_DIR/wayland-protocols/input-timestamps-unstable-v1.xml"
	generate "$SDL_DIR/wayland-protocols/keyboard-shortcuts-inhibit-unstable-v1.xml"
	generate "$SDL_DIR/wayland-protocols/pointer-constraints-unstable-v1.xml"
	generate "$SDL_DIR/wayland-protocols/primary-selection-unstable-v1.xml"
	generate "$SDL_DIR/wayland-protocols/relative-pointer-unstable-v1.xml"
	generate "$SDL_DIR/wayland-protocols/tablet-v2.xml"
	generate "$SDL_DIR/wayland-protocols/text-input-unstable-v3.xml"
	generate "$SDL_DIR/wayland-protocols/viewporter.xml"
	generate "$SDL_DIR/wayland-protocols/wayland.xml"
	generate "$SDL_DIR/wayland-protocols/xdg-activation-v1.xml"
	generate "$SDL_DIR/wayland-protocols/xdg-decoration-unstable-v1.xml"
	generate "$SDL_DIR/wayland-protocols/xdg-dialog-v1.xml"
	generate "$SDL_DIR/wayland-protocols/xdg-foreign-unstable-v2.xml"
	generate "$SDL_DIR/wayland-protocols/xdg-output-unstable-v1.xml"
	generate "$SDL_DIR/wayland-protocols/xdg-shell.xml"
	generate "$SDL_DIR/wayland-protocols/xdg-toplevel-icon-v1.xml"

	cat >> build.zig <<- 'EOF'
		pub const wayland_client_soname = "libwayland-client.so.0";
		pub const wayland_cursor_soname = "libwayland-cursor.so.0";
		pub const wayland_egl_soname = "libwayland-egl.so.1";
		pub const wayland_c_files = .{
		    "src/alpha-modifier-v1-protocol.c",
		    "src/color-management-v1-protocol.c",
		    "src/cursor-shape-v1-protocol.c",
		    "src/fractional-scale-v1-protocol.c",
		    "src/frog-color-management-v1-protocol.c",
		    "src/idle-inhibit-unstable-v1-protocol.c",
		    "src/input-timestamps-unstable-v1-protocol.c",
		    "src/keyboard-shortcuts-inhibit-unstable-v1-protocol.c",
		    "src/pointer-constraints-unstable-v1-protocol.c",
		    "src/primary-selection-unstable-v1-protocol.c",
		    "src/relative-pointer-unstable-v1-protocol.c",
		    "src/tablet-v2-protocol.c",
		    "src/text-input-unstable-v3-protocol.c",
		    "src/viewporter-protocol.c",
		    "src/wayland-protocol.c",
		    "src/xdg-activation-v1-protocol.c",
		    "src/xdg-decoration-unstable-v1-protocol.c",
		    "src/xdg-dialog-v1-protocol.c",
		    "src/xdg-foreign-unstable-v2-protocol.c",
		    "src/xdg-output-unstable-v1-protocol.c",
		    "src/xdg-shell-protocol.c",
		    "src/xdg-toplevel-icon-v1-protocol.c",
		};
	EOF

	curl --create-dirs --output-dir include -LZ \
		-O "https://gitlab.freedesktop.org/libdecor/libdecor/-/raw/$LIBDECOR_REV/src/libdecor.h"

	version=0.2.2
	version_parts=(${version//./ })
	cat >> build.zig <<- EOF
		pub const libdecor_soname = "libdecor-0.so.0";
		pub const libdecor_version: std.SemanticVersion = .{ .major = ${version_parts[0]}, .minor = ${version_parts[1]}, .patch = ${version_parts[2]} };
	EOF

	repo_ensure_cloned LIBXKBCOMMON

	headers=(
		include/xkbcommon/xkbcommon.h
		include/xkbcommon/xkbcommon-compat.h
		include/xkbcommon/xkbcommon-compose.h
		include/xkbcommon/xkbcommon-keysyms.h
		include/xkbcommon/xkbcommon-names.h
	)
	repo_copy LIBXKBCOMMON "${headers[@]}" include/xkbcommon

	cat >> build.zig <<- 'EOF'
		pub const xkbcommon_soname = "libxkbcommon.so.0";
	EOF
}

x11() {
	repo_ensure_cloned LIBX11

	headers=(
		include/X11/XKBlib.h
		include/X11/Xlib.h
		include/X11/Xlibint.h
		include/X11/Xresource.h
		include/X11/Xutil.h
		include/X11/cursorfont.h
	)
	repo_copy LIBX11 "${headers[@]}" include/X11

	mkdir -p include/X11
	sed "$LIBX11_DIR/include/X11/XlibConf.h.in" \
		-e 's/#undef XTHREADS/#define XTHREADS 1/' \
		-e 's/#undef XUSE_MTSAFE_API/#define XUSE_MTSAFE_API 1/' \
	> include/X11/XlibConf.h

	cat >> build.zig <<- 'EOF'
		pub const x11_soname = "libX11.so.6";
	EOF

	repo_ensure_cloned XORGPROTO

	headers=(
		include/X11/X.h
		include/X11/Xatom.h
		include/X11/Xdefs.h
		include/X11/Xfuncproto.h
		include/X11/Xfuncs.h
		include/X11/Xmd.h
		include/X11/Xosdefs.h
		include/X11/Xproto.h
		include/X11/Xprotostr.h
		include/X11/Xthreads.h
		include/X11/keysym.h
		include/X11/keysymdef.h
	)
	repo_copy XORGPROTO "${headers[@]}" include/X11

	headers=(
		include/X11/extensions/XI2.h
		include/X11/extensions/XKB.h
		include/X11/extensions/XKBstr.h
		include/X11/extensions/dbe.h
		include/X11/extensions/randr.h
		include/X11/extensions/render.h
		include/X11/extensions/saver.h
		include/X11/extensions/shapeconst.h
		include/X11/extensions/shm.h
		include/X11/extensions/syncconst.h
		include/X11/extensions/syncproto.h
		include/X11/extensions/xfixeswire.h
	)
	repo_copy XORGPROTO "${headers[@]}" include/X11/extensions

	version=1.2.3
	version_parts=(${version//./ })
	mkdir -p include/X11/Xcursor
	curl -L "https://gitlab.freedesktop.org/xorg/lib/libxcursor/-/raw/$LIBXCURSOR_REV/include/X11/Xcursor/Xcursor.h.in" \
	| sed \
		-e "s/#undef XCURSOR_LIB_MAJOR/#define XCURSOR_LIB_MAJOR ${version_parts[0]}/" \
		-e "s/#undef XCURSOR_LIB_MINOR/#define XCURSOR_LIB_MINOR ${version_parts[1]}/" \
		-e "s/#undef XCURSOR_LIB_REVISION/#define XCURSOR_LIB_REVISION ${version_parts[2]}/" \
	> include/X11/Xcursor/Xcursor.h

	cat >> build.zig <<- 'EOF'
		pub const xcursor_soname = "libXcursor.so.1";
	EOF

	repo_ensure_cloned LIBXEXT

	headers=(
		include/X11/extensions/XShm.h
		include/X11/extensions/Xdbe.h
		include/X11/extensions/Xext.h
		include/X11/extensions/Xge.h
		include/X11/extensions/shape.h
		include/X11/extensions/sync.h
	)
	repo_copy LIBXEXT "${headers[@]}" include/X11/extensions

	cat >> build.zig <<- 'EOF'
		pub const xext_soname = "libXext.so.6";
	EOF

	curl --create-dirs --output-dir include/X11/extensions -LZ \
		-O "https://gitlab.freedesktop.org/xorg/lib/libxfixes/-/raw/$LIBXFIXES_REV/include/X11/extensions/Xfixes.h" \
		-O "https://gitlab.freedesktop.org/xorg/lib/libxi/-/raw/$LIBXI_REV/include/X11/extensions/XInput2.h" \
		-O "https://gitlab.freedesktop.org/xorg/lib/libxrandr/-/raw/$LIBXRANDR_REV/include/X11/extensions/Xrandr.h" \
		-O "https://gitlab.freedesktop.org/xorg/lib/libxrender/-/raw/$LIBXRENDER_REV/include/X11/extensions/Xrender.h" \
		-O "https://gitlab.freedesktop.org/xorg/lib/libxscrnsaver/-/raw/$LIBXSCRNSAVER_REV/include/X11/extensions/scrnsaver.h"

	cat >> build.zig <<- 'EOF'
		pub const xfixes_soname = "libXfixes.so.3";
		pub const xi_soname = "libXi.so.6";
		pub const xrandr_soname = "libXrandr.so.2";
		pub const xss_soname = "libXss.so.1";
	EOF

	repo_ensure_cloned LIBXCB
	repo_ensure_cloned XCBPROTO

	repo_copy LIBXCB src/xcb.h include/xcb

	c_client_py="$PWD/$LIBXCB_DIR/src/c_client.py"
	pushd "$XCBPROTO_DIR"
	./autogen.sh
	make
	make "DESTDIR=$PWD/_out" install
	pushd _out
	python3 "$c_client_py" -c _ -l _ -s _ -p usr/local/lib/python3.*/site-packages ../src/xproto.xml
	popd
	popd
	mkdir -p include/xcb
	cp "$XCBPROTO_DIR/_out/xproto.h" include/xcb/
}

kmsdrm() {
	repo_ensure_cloned DRM

	# The canonical include path for these headers is <drm.h>,
	# not <libdrm/drm.h> (despite what the meson.build suggests).
	headers=(
		include/drm/drm.h
		include/drm/drm_mode.h
	)
	repo_copy DRM "${headers[@]}" include

	headers=(
		xf86drm.h
		xf86drmMode.h
	)
	repo_copy DRM "${headers[@]}" include

	cat >> build.zig <<- 'EOF'
		pub const drm_soname = "libdrm.so.2";
	EOF

	repo_ensure_cloned MESA

	repo_copy MESA src/gbm/main/gbm.h include

	cat >> build.zig <<- 'EOF'
		pub const gbm_soname = "libgbm.so.1";
	EOF
}

pipewire() {
	repo_ensure_cloned PIPEWIRE

	headers=(
		src/pipewire/array.h
		src/pipewire/buffers.h
		src/pipewire/client.h
		src/pipewire/conf.h
		src/pipewire/context.h
		src/pipewire/core.h
		src/pipewire/data-loop.h
		src/pipewire/device.h
		src/pipewire/factory.h
		src/pipewire/filter.h
		src/pipewire/keys.h
		src/pipewire/link.h
		src/pipewire/log.h
		src/pipewire/loop.h
		src/pipewire/main-loop.h
		src/pipewire/map.h
		src/pipewire/mem.h
		src/pipewire/module.h
		src/pipewire/node.h
		src/pipewire/permission.h
		src/pipewire/pipewire.h
		src/pipewire/port.h
		src/pipewire/properties.h
		src/pipewire/protocol.h
		src/pipewire/proxy.h
		src/pipewire/stream.h
		src/pipewire/thread-loop.h
		src/pipewire/type.h
		src/pipewire/utils.h
	)
	repo_copy PIPEWIRE "${headers[@]}" include/pipewire

	repo_copy PIPEWIRE src/pipewire/extensions/metadata.h include/pipewire/extensions

	version=1.2.7
	version_parts=(${version//./ })
	api_version=0.3
	mkdir -p include/pipewire
	sed "$PIPEWIRE_DIR/src/pipewire/version.h.in" \
		-e "s/@PIPEWIRE_VERSION_MAJOR@/${version_parts[0]}/g" \
		-e "s/@PIPEWIRE_VERSION_MINOR@/${version_parts[1]}/g" \
		-e "s/@PIPEWIRE_VERSION_MICRO@/${version_parts[2]}/g" \
		-e "s/@PIPEWIRE_API_VERSION@/\"$api_version\"/g" \
	> include/pipewire/version.h

	headers=(
		spa/include/spa/buffer/buffer.h
		spa/include/spa/buffer/meta.h
	)
	repo_copy PIPEWIRE "${headers[@]}" include/spa/buffer

	headers=(
		spa/include/spa/node/command.h
		spa/include/spa/node/event.h
		spa/include/spa/node/io.h
		spa/include/spa/node/node.h
	)
	repo_copy PIPEWIRE "${headers[@]}" include/spa/node

	headers=(
		spa/include/spa/param/buffers.h
		spa/include/spa/param/format.h
		spa/include/spa/param/format-utils.h
		spa/include/spa/param/param.h
		spa/include/spa/param/port-config.h
		spa/include/spa/param/profile.h
		spa/include/spa/param/route.h
	)
	repo_copy PIPEWIRE "${headers[@]}" include/spa/param

	headers=(
		spa/include/spa/param/audio/aac.h
		spa/include/spa/param/audio/aac-utils.h
		spa/include/spa/param/audio/alac.h
		spa/include/spa/param/audio/alac-utils.h
		spa/include/spa/param/audio/amr.h
		spa/include/spa/param/audio/amr-utils.h
		spa/include/spa/param/audio/ape.h
		spa/include/spa/param/audio/ape-utils.h
		spa/include/spa/param/audio/dsd.h
		spa/include/spa/param/audio/dsd-utils.h
		spa/include/spa/param/audio/dsp.h
		spa/include/spa/param/audio/dsp-utils.h
		spa/include/spa/param/audio/flac.h
		spa/include/spa/param/audio/flac-utils.h
		spa/include/spa/param/audio/format.h
		spa/include/spa/param/audio/format-utils.h
		spa/include/spa/param/audio/iec958.h
		spa/include/spa/param/audio/iec958-utils.h
		spa/include/spa/param/audio/mp3.h
		spa/include/spa/param/audio/mp3-utils.h
		spa/include/spa/param/audio/opus.h
		spa/include/spa/param/audio/ra.h
		spa/include/spa/param/audio/ra-utils.h
		spa/include/spa/param/audio/raw.h
		spa/include/spa/param/audio/raw-utils.h
		spa/include/spa/param/audio/vorbis.h
		spa/include/spa/param/audio/vorbis-utils.h
		spa/include/spa/param/audio/wma.h
		spa/include/spa/param/audio/wma-utils.h
	)
	repo_copy PIPEWIRE "${headers[@]}" include/spa/param/audio

	headers=(
		spa/include/spa/param/video/chroma.h
		spa/include/spa/param/video/color.h
		spa/include/spa/param/video/dsp.h
		spa/include/spa/param/video/encoded.h
		spa/include/spa/param/video/format.h
		spa/include/spa/param/video/h264.h
		spa/include/spa/param/video/mjpg.h
		spa/include/spa/param/video/multiview.h
		spa/include/spa/param/video/raw.h
	)
	repo_copy PIPEWIRE "${headers[@]}" include/spa/param/video

	headers=(
		spa/include/spa/pod/builder.h
		spa/include/spa/pod/command.h
		spa/include/spa/pod/event.h
		spa/include/spa/pod/iter.h
		spa/include/spa/pod/parser.h
		spa/include/spa/pod/pod.h
		spa/include/spa/pod/vararg.h
	)
	repo_copy PIPEWIRE "${headers[@]}" include/spa/pod

	headers=(
		spa/include/spa/support/log.h
		spa/include/spa/support/loop.h
		spa/include/spa/support/plugin.h
		spa/include/spa/support/system.h
		spa/include/spa/support/thread.h
	)
	repo_copy PIPEWIRE "${headers[@]}" include/spa/support

	headers=(
		spa/include/spa/utils/cleanup.h
		spa/include/spa/utils/defs.h
		spa/include/spa/utils/dict.h
		spa/include/spa/utils/hook.h
		spa/include/spa/utils/json.h
		spa/include/spa/utils/list.h
		spa/include/spa/utils/result.h
		spa/include/spa/utils/string.h
		spa/include/spa/utils/type.h
	)
	repo_copy PIPEWIRE "${headers[@]}" include/spa/utils

	cat >> build.zig <<- 'EOF'
		pub const pipewire_soname = "libpipewire-0.3.so.0";
	EOF
}

pulseaudio() {
	repo_ensure_cloned PULSEAUDIO

	headers=(
		src/pulse/cdecl.h
		src/pulse/channelmap.h
		src/pulse/context.h
		src/pulse/def.h
		src/pulse/direction.h
		src/pulse/error.h
		src/pulse/format.h
		src/pulse/gccmacro.h
		src/pulse/introspect.h
		src/pulse/mainloop.h
		src/pulse/mainloop-api.h
		src/pulse/mainloop-signal.h
		src/pulse/operation.h
		src/pulse/proplist.h
		src/pulse/pulseaudio.h
		src/pulse/rtclock.h
		src/pulse/sample.h
		src/pulse/scache.h
		src/pulse/stream.h
		src/pulse/subscribe.h
		src/pulse/thread-mainloop.h
		src/pulse/timeval.h
		src/pulse/utf8.h
		src/pulse/util.h
		src/pulse/volume.h
		src/pulse/xmalloc.h
	)
	repo_copy PULSEAUDIO "${headers[@]}" include/pulse

	version=17.0
	version_parts=(${version//./ })
	api_version=12
	protocol_version=35
	mkdir -p include/pulse
	sed "$PULSEAUDIO_DIR/src/pulse/version.h.in" \
		-e "s/@PA_MAJOR@/${version_parts[0]}/g" \
		-e "s/@PA_MINOR@/${version_parts[1]}/g" \
		-e "s/@PA_API_VERSION@/$api_version/g" \
		-e "s/@PA_PROTOCOL_VERSION@/$protocol_version/g" \
	> include/pulse/version.h

	cat >> build.zig <<- 'EOF'
		pub const pulseaudio_soname = "libpulse.so.0";
	EOF
}

alsa() {
	repo_ensure_cloned ALSA_LIB

	headers=(
		include/asoundef.h
		include/conf.h
		include/control.h
		include/error.h
		include/global.h
		include/hwdep.h
		include/input.h
		include/mixer.h
		include/output.h
		include/pcm.h
		include/pcm_old.h
		include/rawmidi.h
		include/seq.h
		include/seq_event.h
		include/seq_midi_event.h
		include/seqmid.h
		include/timer.h
		include/ump.h
	)
	repo_copy ALSA_LIB "${headers[@]}" include/alsa

	mkdir -p include/alsa
	{
		cat "$ALSA_LIB_DIR/include/asoundlib-head.h"
		cat <<- 'EOF'
			#include <endian.h>

			#ifndef DOC_HIDDEN
			#ifndef __GNUC__
			#define __inline__ inline
			#endif
			#endif /* DOC_HIDDEN */

			#include <alsa/asoundef.h>
			#include <alsa/version.h>
			#include <alsa/global.h>
			#include <alsa/input.h>
			#include <alsa/output.h>
			#include <alsa/error.h>
			#include <alsa/conf.h>
			#include <alsa/pcm.h>
			#include <alsa/rawmidi.h>
			#include <alsa/ump.h>
			#include <alsa/timer.h>
			#include <alsa/hwdep.h>
			#include <alsa/control.h>
			#include <alsa/mixer.h>
			#include <alsa/seq_event.h>
			#include <alsa/seq.h>
			#include <alsa/seqmid.h>
			#include <alsa/seq_midi_event.h>
		EOF
		cat "$ALSA_LIB_DIR/include/asoundlib-tail.h"
	} > include/alsa/asoundlib.h

	version=1.2.13
	version_parts=(${version//./ })
	mkdir -p include/alsa
	cat > include/alsa/version.h <<- EOF
		/*
		 *  version.h
		 */

		#define SND_LIB_MAJOR		${version_parts[0]} /**< major number of library version */
		#define SND_LIB_MINOR		${version_parts[1]} /**< minor number of library version */
		#define SND_LIB_SUBMINOR	${version_parts[2]} /**< subminor number of library version */
		#define SND_LIB_EXTRAVER	1000000 /**< extra version number, used mainly for betas */
		/** library version */
		#define SND_LIB_VER(maj, min, sub) (((maj)<<16)|((min)<<8)|(sub))
		#define SND_LIB_VERSION SND_LIB_VER(SND_LIB_MAJOR, SND_LIB_MINOR, SND_LIB_SUBMINOR)
		/** library version (string) */
		#define SND_LIB_VERSION_STR	"$version"

	EOF

	cat >> build.zig <<- 'EOF'
		pub const alsa_soname = "libasound.so.2";
	EOF
}

sndio() {
	curl --create-dirs --output-dir include -LZ \
		-O "https://raw.githubusercontent.com/ratchov/sndio/$SNDIO_REV/libsndio/sndio.h"

	cat >> build.zig <<- 'EOF'
		pub const sndio_soname = "libsndio.so.7";
	EOF
}

jack() {
	repo_ensure_cloned JACK1

	pushd "$JACK1_DIR"
	git submodule update --init --recursive
	popd

	headers=(
		jack/jack.h
		jack/systemdeps.h
		jack/transport.h
		jack/types.h
		jack/weakmacros.h
	)
	repo_copy JACK1 "${headers[@]}" include/jack

	cat >> build.zig <<- 'EOF'
		pub const jack_soname = "libjack.so.0";
	EOF
}

libusb() {
	curl --create-dirs --output-dir include -LZ \
		-O "https://raw.githubusercontent.com/libusb/libusb/$LIBUSB_REV/libusb/libusb.h"

	cat >> build.zig <<- 'EOF'
		pub const libusb_soname = "libusb-1.0.so.0";
	EOF
}

liburing() {
	repo_ensure_cloned LIBURING

	repo_copy LIBURING src/include/liburing.h include

	headers=(
		src/include/liburing/barrier.h
		src/include/liburing/io_uring.h
	)
	repo_copy LIBURING "${headers[@]}" include/liburing

	mkdir -p include/liburing
	# REUSE-IgnoreStart
	cat > include/liburing/compat.h <<- 'EOF'
		/* SPDX-License-Identifier: MIT */
		#ifndef LIBURING_COMPAT_H
		#define LIBURING_COMPAT_H

		#include <linux/time_types.h>
		/* <linux/time_types.h> is included above and not needed again */
		#define UAPI_LINUX_IO_URING_H_SKIP_LINUX_TIME_TYPES_H 1

		#include <linux/openat2.h>


		#include <linux/ioctl.h>

		#ifndef BLOCK_URING_CMD_DISCARD
		#define BLOCK_URING_CMD_DISCARD                        _IO(0x12, 0)
		#endif

		#endif
	EOF
	# REUSE-IgnoreEnd

	version=2.9
	version_parts=(${version//./ })
	mkdir -p include/liburing
	# REUSE-IgnoreStart
	cat > include/liburing/io_uring_version.h <<- EOF
		/* SPDX-License-Identifier: MIT */
		#ifndef LIBURING_VERSION_H
		#define LIBURING_VERSION_H

		#define IO_URING_VERSION_MAJOR ${version_parts[0]}
		#define IO_URING_VERSION_MINOR ${version_parts[1]}

		#endif
	EOF
	# REUSE-IgnoreEnd
}

core() {
	repo_ensure_cloned DBUS

	headers=(
		dbus/dbus.h
		dbus/dbus-address.h
		dbus/dbus-bus.h
		dbus/dbus-connection.h
		dbus/dbus-errors.h
		dbus/dbus-macros.h
		dbus/dbus-memory.h
		dbus/dbus-message.h
		dbus/dbus-misc.h
		dbus/dbus-pending-call.h
		dbus/dbus-protocol.h
		dbus/dbus-server.h
		dbus/dbus-shared.h
		dbus/dbus-signature.h
		dbus/dbus-syntax.h
		dbus/dbus-threads.h
		dbus/dbus-types.h
	)
	repo_copy DBUS "${headers[@]}" include/dbus

	version=1.16.2
	version_parts=(${version//./ })
	mkdir -p include/x86_64-linux-gnu/dbus
	sed "$DBUS_DIR/dbus/dbus-arch-deps.h.in" \
		-e 's/@DBUS_INT64_TYPE@/long/g' \
		-e 's/@DBUS_INT64_MODIFIER@/l/g' \
		-e 's/@DBUS_INT64_CONSTANT@/(val##L)/g' \
		-e 's/@DBUS_UINT64_CONSTANT@/(val##UL)/g' \
		-e 's/@DBUS_INT32_TYPE@/int/g' \
		-e 's/@DBUS_INT16_TYPE@/short/g' \
		-e 's/@DBUS_SIZEOF_VOID_P@/8/g' \
		-e "s/@DBUS_MAJOR_VERSION@/${version_parts[0]}/g" \
		-e "s/@DBUS_MINOR_VERSION@/${version_parts[1]}/g" \
		-e "s/@DBUS_MICRO_VERSION@/${version_parts[2]}/g" \
		-e "s/@DBUS_VERSION@/$version/g" \
	> include/x86_64-linux-gnu/dbus/dbus-arch-deps.h

	# aarch64 config is identical to x86_64
	mkdir -p include/aarch64-linux-gnu/dbus
	cp include/x86_64-linux-gnu/dbus/dbus-arch-deps.h include/aarch64-linux-gnu/dbus/

	repo_ensure_cloned IBUS

	headers=(
		src/ibus.h
		src/ibusaccelgroup.h
		src/ibusattribute.h
		src/ibusattrlist.h
		src/ibusbus.h
		src/ibuscomponent.h
		src/ibusconfig.h
		src/ibusconfigservice.h
		src/ibusdebug.h
		src/ibusemoji.h
		src/ibusengine.h
		src/ibusenginedesc.h
		src/ibusenginesimple.h
		src/ibuserror.h
		src/ibusfactory.h
		src/ibushotkey.h
		src/ibusinputcontext.h
		src/ibuskeymap.h
		src/ibuskeys.h
		src/ibuskeysyms.h
		src/ibuskeysyms-compat.h
		src/ibuslookuptable.h
		src/ibusobject.h
		src/ibusobservedpath.h
		src/ibuspanelservice.h
		src/ibusproperty.h
		src/ibusproplist.h
		src/ibusproxy.h
		src/ibusregistry.h
		src/ibusserializable.h
		src/ibusservice.h
		src/ibusshare.h
		src/ibustext.h
		src/ibustypes.h
		src/ibusunicode.h
		src/ibusutil.h
		src/ibusxevent.h
		src/ibusxml.h
	)
	repo_copy IBUS "${headers[@]}" include

	version=1.5.31
	version_parts=(${version//./ })
	sed "$IBUS_DIR/src/ibusversion.h.in" \
		-e "s/@IBUS_MAJOR_VERSION@/${version_parts[0]}/g" \
		-e "s/@IBUS_MINOR_VERSION@/${version_parts[1]}/g" \
		-e "s/@IBUS_MICRO_VERSION@/${version_parts[2]}/g" \
	> include/ibusversion.h

	mkdir -p include
	glib-mkenums --template "$IBUS_DIR/src/ibusenumtypes.h.template" "${headers[@]/#src\//include/}" \
	| sed \
		-e 's/i_bus_/ibus_/g' \
		-e 's/I_TYPE_BUS_/IBUS_TYPE_/g' \
	> include/ibusenumtypes.h

	repo_ensure_cloned GLIB

	headers=(
		glib/glib.h
		glib/glib-object.h
	)
	repo_copy GLIB "${headers[@]}" include

	headers=(
		glib/galloca.h
		glib/garray.h
		glib/gasyncqueue.h
		glib/gatomic.h
		glib/gbacktrace.h
		glib/gbase64.h
		glib/gbitlock.h
		glib/gbookmarkfile.h
		glib/gbytes.h
		glib/gcharset.h
		glib/gchecksum.h
		glib/gconvert.h
		glib/gdataset.h
		glib/gdate.h
		glib/gdatetime.h
		glib/gdir.h
		glib/genviron.h
		glib/gerror.h
		glib/gfileutils.h
		glib/ggettext.h
		glib/ghash.h
		glib/ghmac.h
		glib/ghook.h
		glib/ghostutils.h
		glib/giochannel.h
		glib/gkeyfile.h
		glib/glib-autocleanups.h
		glib/glib-typeof.h
		glib/glist.h
		glib/gmacros.h
		glib/gmain.h
		glib/gmappedfile.h
		glib/gmarkup.h
		glib/gmem.h
		glib/gmessages.h
		glib/gnode.h
		glib/goption.h
		glib/gpathbuf.h
		glib/gpattern.h
		glib/gpoll.h
		glib/gprimes.h
		glib/gqsort.h
		glib/gquark.h
		glib/gqueue.h
		glib/grand.h
		glib/grcbox.h
		glib/grefcount.h
		glib/grefstring.h
		glib/gregex.h
		glib/gscanner.h
		glib/gsequence.h
		glib/gshell.h
		glib/gslice.h
		glib/gslist.h
		glib/gspawn.h
		glib/gstrfuncs.h
		glib/gstring.h
		glib/gstringchunk.h
		glib/gstrvbuilder.h
		glib/gtestutils.h
		glib/gthread.h
		glib/gthreadpool.h
		glib/gtimer.h
		glib/gtimezone.h
		glib/gtrashstack.h
		glib/gtree.h
		glib/gtypes.h
		glib/gunicode.h
		glib/guri.h
		glib/gutils.h
		glib/guuid.h
		glib/gvariant.h
		glib/gvarianttype.h
		glib/gversion.h
	)
	repo_copy GLIB "${headers[@]}" include/glib

	headers=(
		glib/deprecated/gallocator.h
		glib/deprecated/gcache.h
		glib/deprecated/gcompletion.h
		glib/deprecated/gmain.h
		glib/deprecated/grel.h
		glib/deprecated/gthread.h
	)
	repo_copy GLIB "${headers[@]}" include/glib/deprecated

	version=2.82.5
	version_parts=(${version//./ })
	mkdir -p include/x86_64-linux-gnu
	sed "$GLIB_DIR/glib/glibconfig.h.in" \
		-e 's/#mesondefine GLIB_HAVE_ALLOCA_H/#define GLIB_HAVE_ALLOCA_H/' \
		-e 's/#mesondefine GLIB_STATIC_COMPILATION/\/\* #undef GLIB_STATIC_COMPILATION \*\//' \
		-e 's/#mesondefine GOBJECT_STATIC_COMPILATION/\/\* #undef GOBJECT_STATIC_COMPILATION \*\//' \
		-e 's/#mesondefine GIO_STATIC_COMPILATION/\/\* #undef GIO_STATIC_COMPILATION \*\//' \
		-e 's/#mesondefine GMODULE_STATIC_COMPILATION/\/\* #undef GMODULE_STATIC_COMPILATION \*\//' \
		-e 's/#mesondefine GI_STATIC_COMPILATION/\/\* #undef GI_STATIC_COMPILATION \*\//' \
		-e 's/#mesondefine G_INTL_STATIC_COMPILATION/\/\* #undef G_INTL_STATIC_COMPILATION \*\//' \
		-e 's/#mesondefine FFI_STATIC_BUILD/\/\* #undef FFI_STATIC_BUILD \*\//' \
		-e 's/#mesondefine GLIB_USING_SYSTEM_PRINTF/#define GLIB_USING_SYSTEM_PRINTF/' \
		-e 's/@gint16@/short/g' \
		-e 's/@gint16_modifier@/"h"/g' \
		-e 's/@gint16_format@/"hi"/g' \
		-e 's/@guint16_format@/"hu"/g' \
		-e 's/@gint32@/int/g' \
		-e 's/@gint32_modifier@/""/g' \
		-e 's/@gint32_format@/"i"/g' \
		-e 's/@guint32_format@/"u"/g' \
		-e 's/@glib_extension@//g' \
		-e 's/@gint64@/long/g' \
		-e 's/@gint64_constant@/(val##L)/g' \
		-e 's/@guint64_constant@/(val##UL)/g' \
		-e 's/@gint64_modifier@/"l"/g' \
		-e 's/@gint64_format@/"li"/g' \
		-e 's/@guint64_format@/"lu"/g' \
		-e 's/@glib_void_p@/8/g' \
		-e 's/@glib_long@/8/g' \
		-e 's/@glib_size_t@/8/g' \
		-e 's/@glib_ssize_t@/8/g' \
		-e 's/@glib_size_type_define@/long/g' \
		-e 's/@gsize_modifier@/"l"/g' \
		-e 's/@gssize_modifier@/"l"/g' \
		-e 's/@gsize_format@/"lu"/g' \
		-e 's/@gssize_format@/"li"/g' \
		-e 's/@glib_msize_type@/LONG/g' \
		-e 's/@g_pollfd_format@/"%d"/g' \
		-e 's/@glib_gpi_cast@/(glong)/g' \
		-e 's/@glib_gpui_cast@/(gulong)/g' \
		-e 's/@glib_intptr_type_define@/long/g' \
		-e 's/@gintptr_modifier@/"l"/g' \
		-e 's/@gintptr_format@/"li"/g' \
		-e 's/@guintptr_format@/"lu"/g' \
		-e "s/@GLIB_MAJOR_VERSION@/${version_parts[0]}/g" \
		-e "s/@GLIB_MINOR_VERSION@/${version_parts[1]}/g" \
		-e "s/@GLIB_MICRO_VERSION@/${version_parts[2]}/g" \
		-e 's/@glib_os@/#define G_OS_UNIX/g' \
		-e 's/@glib_vacopy@/\n#define G_VA_COPY_AS_ARRAY 1/g' \
		-e 's/#mesondefine G_HAVE_GROWING_STACK/#define G_HAVE_GROWING_STACK 0/' \
		-e 's/@g_threads_impl_def@/POSIX/g' \
		-e 's/#mesondefine G_ATOMIC_LOCK_FREE/#define G_ATOMIC_LOCK_FREE/' \
		-e 's/@g_bs_native@/LE/g' \
		-e 's/@g_bs_alien@/BE/g' \
		-e 's/@glongbits@/64/g' \
		-e 's/@gintbits@/32/g' \
		-e 's/@gsizebits@/64/g' \
		-e 's/@g_byte_order@/G_LITTLE_ENDIAN/g' \
		-e 's/@g_pollin@/1/g' \
		-e 's/@g_pollout@/4/g' \
		-e 's/@g_pollpri@/2/g' \
		-e 's/@g_pollhup@/16/g' \
		-e 's/@g_pollerr@/8/g' \
		-e 's/@g_pollnval@/32/g' \
		-e 's/@g_module_suffix@/so/g' \
		-e 's/@g_pid_type@/int/g' \
		-e 's/@g_pid_format@/"i"/g' \
		-e 's/@g_af_unix@/1/g' \
		-e 's/@g_af_inet@/2/g' \
		-e 's/@g_af_inet6@/10/g' \
		-e 's/@g_msg_oob@/1/g' \
		-e 's/@g_msg_peek@/2/g' \
		-e 's/@g_msg_dontroute@/4/g' \
		-e 's/@g_dir_separator@/\//g' \
		-e 's/@g_searchpath_separator@/:/g' \
		-e 's/#mesondefine G_HAVE_FREE_SIZED/#undef G_HAVE_FREE_SIZED/' \
	> include/x86_64-linux-gnu/glibconfig.h

	# aarch64 config is identical to x86_64 sans G_VA_COPY_AS_ARRAY
	mkdir -p include/aarch64-linux-gnu
	grep -v '^#define G_VA_COPY_AS_ARRAY 1$' include/x86_64-linux-gnu/glibconfig.h > include/aarch64-linux-gnu/glibconfig.h

	mkdir -p include/glib
	"$GLIB_DIR/tools/gen-visibility-macros.py" "$version" visibility-macros \
		GLIB include/glib/glib-visibility.h

	mkdir -p include/glib
	"$GLIB_DIR/tools/gen-visibility-macros.py" "$version" versions-macros \
		"$GLIB_DIR/glib/gversionmacros.h.in" include/glib/gversionmacros.h

	headers=(
		gio/gaction.h
		gio/gactiongroup.h
		gio/gactiongroupexporter.h
		gio/gactionmap.h
		gio/gappinfo.h
		gio/gapplication.h
		gio/gapplicationcommandline.h
		gio/gasyncinitable.h
		gio/gasyncresult.h
		gio/gbufferedinputstream.h
		gio/gbufferedoutputstream.h
		gio/gbytesicon.h
		gio/gcancellable.h
		gio/gcharsetconverter.h
		gio/gcontenttype.h
		gio/gconverter.h
		gio/gconverterinputstream.h
		gio/gconverteroutputstream.h
		gio/gcredentials.h
		gio/gdatagrambased.h
		gio/gdatainputstream.h
		gio/gdataoutputstream.h
		gio/gdbusactiongroup.h
		gio/gdbusaddress.h
		gio/gdbusauthobserver.h
		gio/gdbusconnection.h
		gio/gdbuserror.h
		gio/gdbusinterface.h
		gio/gdbusinterfaceskeleton.h
		gio/gdbusintrospection.h
		gio/gdbusmenumodel.h
		gio/gdbusmessage.h
		gio/gdbusmethodinvocation.h
		gio/gdbusnameowning.h
		gio/gdbusnamewatching.h
		gio/gdbusobject.h
		gio/gdbusobjectmanager.h
		gio/gdbusobjectmanagerclient.h
		gio/gdbusobjectmanagerserver.h
		gio/gdbusobjectproxy.h
		gio/gdbusobjectskeleton.h
		gio/gdbusproxy.h
		gio/gdbusserver.h
		gio/gdbusutils.h
		gio/gdebugcontroller.h
		gio/gdebugcontrollerdbus.h
		gio/gdrive.h
		gio/gdtlsclientconnection.h
		gio/gdtlsconnection.h
		gio/gdtlsserverconnection.h
		gio/gemblem.h
		gio/gemblemedicon.h
		gio/gfile.h
		gio/gfileattribute.h
		gio/gfileenumerator.h
		gio/gfileicon.h
		gio/gfileinfo.h
		gio/gfileinputstream.h
		gio/gfileiostream.h
		gio/gfilemonitor.h
		gio/gfilenamecompleter.h
		gio/gfileoutputstream.h
		gio/gfilterinputstream.h
		gio/gfilteroutputstream.h
		gio/gicon.h
		gio/ginetaddress.h
		gio/ginetaddressmask.h
		gio/ginetsocketaddress.h
		gio/ginitable.h
		gio/ginputstream.h
		gio/gio.h
		gio/gio-autocleanups.h
		gio/gioenums.h
		gio/gioerror.h
		gio/giomodule.h
		gio/gioscheduler.h
		gio/giostream.h
		gio/giotypes.h
		gio/glistmodel.h
		gio/gliststore.h
		gio/gloadableicon.h
		gio/gmemoryinputstream.h
		gio/gmemorymonitor.h
		gio/gmemoryoutputstream.h
		gio/gmenu.h
		gio/gmenuexporter.h
		gio/gmenumodel.h
		gio/gmount.h
		gio/gmountoperation.h
		gio/gnativesocketaddress.h
		gio/gnativevolumemonitor.h
		gio/gnetworkaddress.h
		gio/gnetworkmonitor.h
		gio/gnetworkservice.h
		gio/gnotification.h
		gio/goutputstream.h
		gio/gpermission.h
		gio/gpollableinputstream.h
		gio/gpollableoutputstream.h
		gio/gpollableutils.h
		gio/gpowerprofilemonitor.h
		gio/gpropertyaction.h
		gio/gproxy.h
		gio/gproxyaddress.h
		gio/gproxyaddressenumerator.h
		gio/gproxyresolver.h
		gio/gremoteactiongroup.h
		gio/gresolver.h
		gio/gresource.h
		gio/gseekable.h
		gio/gsettings.h
		gio/gsettingsschema.h
		gio/gsimpleaction.h
		gio/gsimpleactiongroup.h
		gio/gsimpleasyncresult.h
		gio/gsimpleiostream.h
		gio/gsimplepermission.h
		gio/gsimpleproxyresolver.h
		gio/gsocket.h
		gio/gsocketaddress.h
		gio/gsocketaddressenumerator.h
		gio/gsocketclient.h
		gio/gsocketconnectable.h
		gio/gsocketconnection.h
		gio/gsocketcontrolmessage.h
		gio/gsocketlistener.h
		gio/gsocketservice.h
		gio/gsrvtarget.h
		gio/gsubprocess.h
		gio/gsubprocesslauncher.h
		gio/gtask.h
		gio/gtcpconnection.h
		gio/gtcpwrapperconnection.h
		gio/gtestdbus.h
		gio/gthemedicon.h
		gio/gthreadedsocketservice.h
		gio/gtlsbackend.h
		gio/gtlscertificate.h
		gio/gtlsclientconnection.h
		gio/gtlsconnection.h
		gio/gtlsdatabase.h
		gio/gtlsfiledatabase.h
		gio/gtlsinteraction.h
		gio/gtlspassword.h
		gio/gtlsserverconnection.h
		gio/gunixconnection.h
		gio/gunixcredentialsmessage.h
		gio/gunixfdlist.h
		gio/gunixsocketaddress.h
		gio/gvfs.h
		gio/gvolume.h
		gio/gvolumemonitor.h
		gio/gzlibcompressor.h
		gio/gzlibdecompressor.h
	)
	repo_copy GLIB "${headers[@]}" include/gio

	mkdir -p include/gio
	glib-mkenums --template "$GLIB_DIR/gio/gioenumtypes.h.template" "${headers[@]/#gio\//include/gio/}" \
	> include/gio/gioenumtypes.h

	mkdir -p include/gio
	"$GLIB_DIR/tools/gen-visibility-macros.py" "$version" visibility-macros \
		GIO include/gio/gio-visibility.h

	repo_copy GLIB gmodule/gmodule.h include

	mkdir -p include/gmodule
	"$GLIB_DIR/tools/gen-visibility-macros.py" "$version" visibility-macros \
		GMODULE include/gmodule/gmodule-visibility.h

	headers=(
		gobject/gbinding.h
		gobject/gbindinggroup.h
		gobject/gboxed.h
		gobject/gclosure.h
		gobject/genums.h
		gobject/glib-types.h
		gobject/gmarshal.h
		gobject/gobject.h
		gobject/gobject-autocleanups.h
		gobject/gparam.h
		gobject/gparamspecs.h
		gobject/gsignal.h
		gobject/gsignalgroup.h
		gobject/gsourceclosure.h
		gobject/gtype.h
		gobject/gtypemodule.h
		gobject/gtypeplugin.h
		gobject/gvalue.h
		gobject/gvaluearray.h
		gobject/gvaluetypes.h
	)
	repo_copy GLIB "${headers[@]}" include/gobject

	mkdir -p include/gobject
	glib-mkenums --template "$GLIB_DIR/gobject/glib-enumtypes.h.template" include/glib/gunicode.h \
	> include/gobject/glib-enumtypes.h

	mkdir -p include/gobject
	"$GLIB_DIR/tools/gen-visibility-macros.py" "$version" visibility-macros \
		GOBJECT include/gobject/gobject-visibility.h

	curl --create-dirs --output-dir include -LZ \
		-O "https://raw.githubusercontent.com/systemd/systemd/$SYSTEMD_REV/src/libudev/libudev.h"

	cat >> build.zig <<- 'EOF'
		pub const libudev_soname = "libudev.so.1";
	EOF
}

main() {
	rm -rf {include,src}

	# REUSE-IgnoreStart
	cat > build.zig <<- 'EOF'
		// © 2024 Carl Åstholm
		// SPDX-License-Identifier: MIT

		const std = @import("std");
		pub fn build(_: *std.Build) void {}
	EOF
	# REUSE-IgnoreEnd

	opengl
	wayland
	x11
	kmsdrm
	pipewire
	pulseaudio
	alsa
	sndio
	jack
	libusb
	liburing
	core

	rm -rf "$TMP_PREFIX"
}

main
