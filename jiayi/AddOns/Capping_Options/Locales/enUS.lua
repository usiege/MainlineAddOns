
local _, mod = ...
if not mod.L then -- Support repo users by checking if it already exists
	mod.L = {}
end
local L = mod.L

-- Options
L.general = "General"
L.test = "Test"
L.lock = "Lock"
L.barIcon = "Bar Icon"
L.showTime = "Show Time"
L.fillBar = "Fill Bar"
L.font = "Font"
L.fontSize = "Font Size"
L.monochrome = "Monochrome Text"
L.outline = "Outline"
L.none = "None"
L.thin = "Thin"
L.thick = "Thick"
L.texture = "Texture"
L.barSpacing = "Bar Spacing"
L.barWidth = "Bar Width"
L.barHeight = "Bar Height"
L.alignText = "Align Text"
L.alignTime = "Align Time"
L.alignIcon = "Align Bar Icon"
L.left = "Left"
L.center = "Center"
L.right = "Right"
L.growUpwards = "Grow Upwards"
L.textColor = "Text Color"
L.allianceBars = "Alliance Bars"
L.hordeBars = "Horde Bars"
L.queueBars = "Queue Bars"
L.otherBars = "Other Bars"
L.barBackground = "Bar Background"

-- Features
L.features = "Features"
L.queueBarsDesc = "Enable the bars showing which queues you have joined and the estimated time you will be in the queue for."
L.barClickDesc = "Configure the keyboard modifier you wish to use for specific chat output when clicking on a bar. Setting all 3 to 'None' will disable clickable bars, allowing you to click through them."
L.shiftClick = "Shift-Click"
L.controlClick = "Control-Click"
L.altClick = "Alt-Click"
L.sayChat = "Say Chat"
L.raidChat = "Group Chat"
L.clickableBars = "Clickable Bars"
L.loudQueue = "Loud Queue"
L.loudQueueDesc = "When the queue is ready the sound notification will be forced to play over the 'Master' sound channel."
