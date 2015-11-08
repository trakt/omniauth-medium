tell application "System Events"
	set FrontmostApp to name of first process where frontmost is true
end tell

if FrontmostApp is "Safari" then
	tell window 1 of application "Safari" to close current tab
end if

tell application "Terminal" to activate
