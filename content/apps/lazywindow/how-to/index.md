---
title: "How to Use LazyWindow"
description: "Every LazyWindow shortcut: snap a window, cycle sizes, fill the screen and back, and reach the next display."
layout: "howto"
---

**LazyWindow - Keyboard Window Snapping**

Hold **⌃⌥ (Control + Option)** and press an arrow key. That is the whole app.

## Before you start

LazyWindow needs Accessibility permission to move other apps' windows. Open the menu bar icon and choose **Grant accessibility permission…**, then enable LazyWindow in System Settings → Privacy & Security → Accessibility. The menu item disappears once permission is granted.

## The shortcuts

| Keys | What happens |
| --- | --- |
| ⌃⌥ ← / → | Left or right half. Press again for two thirds, again for one third. |
| ⌃⌥ ↑ / ↓ | Top or bottom half. Press again for two thirds, again for one third. |
| ⌃⌥ ← ↑ | Hold ⌃⌥ and press two directions for a corner. The order does not matter. |
| ⌃⌥ ↩ | Fill the screen. Press again to put the window back where it was. |
| ⌃⌥ C | Center the window. A maximized window shrinks to two thirds first. |
| ⌃⌥⌘ ← / → | Previous display, next display. |

## Pressing the same key again

Repeating a direction steps through sizes instead of doing the same thing twice.

- **⌃⌥→** repeated: right half → right two thirds → right one third → the same on the display to the right.
- **⌃⌥↑** repeated: top half → top two thirds → top one third → back to the top half. A window in a corner goes straight to the half.

Press the opposite arrow and the window keeps its current size but flips to the other side. If you move or resize a window yourself, the next press starts over at a half.

## Settings

Open the menu bar icon and choose **Settings…**

- **Launch at login** - start LazyWindow when you log in.
- **Hide the menu bar icon** - shortcuts keep working. Open LazyWindow again to bring the settings window back.
- **Continue onto the next display** - turn this off to keep cycling sizes on the current display instead of moving to the next one.

## Skipping an app

Some apps should never be rearranged. Bring that app to the front, open the LazyWindow menu, and choose **Ignore "App Name"**. Choose it again to stop ignoring.

## Notes

- Shortcuts follow the key position, not the letter, so they work while typing in any language.
- Pressing ⌃⌥↩ on a full window puts it back only if it has not moved since LazyWindow filled the screen. Otherwise it goes to the middle at two thirds.
- Full screen windows and windows an app refuses to resize are left alone.
