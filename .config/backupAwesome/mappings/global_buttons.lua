-- Awesome Libs
local gears = require("gears")
local awful = require("awful")

root.buttons = gears.table.join(
   awful.button({ }, 3, 
   function() 
       awful.menu.client_list { theme = { width = 250 } } 
       s.mywibox = awful.wibar({ position = "top", screen = s, visible = false })
   end), 
   awful.button({}, 4, awful.tag.viewnext),
  awful.button({}, 5, awful.tag.viewprev)
)
