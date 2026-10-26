#!/usr/bin/osascript -l JavaScript

// @raycast.schemaVersion 1
// @raycast.title Focused Window 16:9 Left
// @raycast.mode silent
// @raycast.packageName Window Layouts
// @raycast.icon 🖥️

ObjC.import('AppKit')

const SIXTEEN_BY_NINE = 16 / 9

function primaryScreenVisibleArea() {
  const primaryScreen = $.NSScreen.screens.objectAtIndex(0)
  const screenHeight = primaryScreen.frame.size.height
  const visible = primaryScreen.visibleFrame
  return {
    x: visible.origin.x,
    y: screenHeight - (visible.origin.y + visible.size.height),
    width: visible.size.width,
    height: visible.size.height,
  }
}

function sixteenByNineThatFits(area) {
  const width = Math.min(area.width, Math.round(area.height * SIXTEEN_BY_NINE))
  return { width, height: Math.round(width / SIXTEEN_BY_NINE) }
}

function focusedWindow() {
  const frontmostProcess = Application('System Events').processes.whose({ frontmost: true })[0]
  return frontmostProcess.windows[0]
}

function run() {
  const area = primaryScreenVisibleArea()
  const size = sixteenByNineThatFits(area)
  const window = focusedWindow()

  window.position = [area.x, area.y]
  window.size = [size.width, size.height]
}
