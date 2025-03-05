// © 2024 Carl Åstholm
// SPDX-License-Identifier: MIT

const std = @import("std");
pub fn build(_: *std.Build) void {}
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
pub const libdecor_soname = "libdecor-0.so.0";
pub const libdecor_version: std.SemanticVersion = .{ .major = 0, .minor = 2, .patch = 2 };
pub const xkbcommon_soname = "libxkbcommon.so.0";
pub const x11_soname = "libX11.so.6";
pub const xcursor_soname = "libXcursor.so.1";
pub const xext_soname = "libXext.so.6";
pub const xfixes_soname = "libXfixes.so.3";
pub const xi_soname = "libXi.so.6";
pub const xrandr_soname = "libXrandr.so.2";
pub const xss_soname = "libXss.so.1";
pub const drm_soname = "libdrm.so.2";
pub const gbm_soname = "libgbm.so.1";
pub const pipewire_soname = "libpipewire-0.3.so.0";
pub const pulseaudio_soname = "libpulse.so.0";
pub const alsa_soname = "libasound.so.2";
pub const sndio_soname = "libsndio.so.7";
pub const jack_soname = "libjack.so.0";
pub const libusb_soname = "libusb-1.0.so.0";
pub const libudev_soname = "libudev.so.1";
