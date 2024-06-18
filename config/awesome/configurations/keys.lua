local awful = require("awful")
local naughty = require("naughty")
local dpi = require("beautiful.xresources").apply_dpi

local apps = require("configurations.apps")
local helpers = require("helpers")

-- better keys
local MOD = "Mod4"
local ALT = "Mod1"
local CTRL = "Control"
local SHIFT = "Shift"

awful.keyboard.append_global_keybindings({
  awful.key({ MOD }, "r", awesome.restart),
  -- APPS -------------------------------------------------------------------------------------------------------------
  -- Term
  awful.key({ MOD }, "Return", function()
    awful.spawn(apps.default.term)
  end, { description = "Open terminal", group = "Apps" }),

  -- Float Term
  awful.key({ MOD, SHIFT }, "Return", function()
    awful.spawn(apps.default.fterm)
  end, { description = "Open float terminal", group = "Apps" }),

  -- Calculator
  awful.key({ MOD }, "c", function()
    awful.spawn(apps.default.calculator)
  end, { description = "Open calculator", group = "Apps" }),

  -- Editor
  awful.key({ MOD }, "n", function()
    awful.spawn(apps.default.editor)
  end, { description = "Open editor", group = "Apps" }),

  -- File browser
  awful.key({ MOD }, "e", function()
    awful.spawn(apps.default.file_browser)
  end, { description = "Open file browser", group = "Apps" }),

  -- Web browser
  awful.key({ MOD }, "w", function()
    awful.spawn(apps.default.web_browser)
  end, { description = "Open web browser", group = "Apps" }),

  -- Aseprite
  awful.key({ MOD }, "a", function()
    awful.spawn(apps.default.aseprite)
  end, { description = "Open Aseprite", group = "Apps" }),

  -- Godot
  awful.key({ MOD }, "g", function()
    awful.spawn(apps.default.godot)
  end, { description = "Open Godot", group = "Apps" }),

  -- Blender
  awful.key({ MOD }, "b", function()
    awful.spawn(apps.default.blender)
  end, { description = "Open Blender", group = "Apps" }),

  -- DMENU -------------------------------------------------------------------------------------------------------------
  -- Launcher
  awful.key({ MOD }, "d", function()
    awful.spawn(apps.dmenu.launcher)
  end, { description = "Open app launcher", group = "Dmenus" }),

  -- Quit
  awful.key({ MOD, SHIFT }, "q", function()
    awful.spawn(apps.dmenu.quit)
  end, { description = "Open quit menu", group = "Dmenus" }),
  -- Screenshot
  awful.key({ MOD }, "p", function()
    awful.spawn(apps.dmenu.screenshot)
  end, { description = "Open screenshot menu", group = "Dmenus" }),
  -- Record
  awful.key({ MOD, SHIFT }, "p", function()
    awful.spawn(apps.dmenu.record)
  end, { description = "Open record menu", group = "Dmenus" }),
  -- Colorpicker
  awful.key({ MOD }, "x", function()
    awful.spawn(apps.dmenu.colorpicker)
  end, { description = "Open colorpicker", group = "Dmenus" }),
  -- Zathura docs
  awful.key({ MOD }, "z", function()
    awful.spawn(apps.dmenu.docs)
  end, { description = "Open documents", group = "Dmenus" }),
  -- clients
  awful.key({ MOD }, "slash", function()
    awful.spawn(apps.dmenu.clients)
  end, { description = "Switch clients", group = "Dmenus" }),

  -- Utils
  awful.key({ MOD }, "q", function()
    awful.spawn("awesome-client 'lock_screen_show()'", false)
  end, { description = "Lock", group = "Utils" }),

  -- CLIENTS ----------------------------------------------------------------------------------------------------------
  -- Cycle focus clients
  awful.key({ MOD }, "h", function()
    awful.client.focus.bydirection("left")
  end, { description = "Focus left client", group = "Clients" }),
  awful.key({ MOD }, "l", function()
    awful.client.focus.bydirection("right")
  end, { description = "Focus right client", group = "Clients" }),
  awful.key({ MOD }, "j", function()
    awful.client.focus.bydirection("down")
  end, { description = "Focus up client", group = "Clients" }),
  awful.key({ MOD }, "k", function()
    awful.client.focus.bydirection("up")
  end, { description = "Focus down client", group = "Clients" }),

  -- Resize client
  awful.key({ MOD, CTRL }, "h", function()
    helpers.client.resize_client(client.focus, "left")
  end, { description = "Resize left", group = "Clients" }),
  awful.key({ MOD, CTRL }, "l", function()
    helpers.client.resize_client(client.focus, "right")
  end, { description = "Resize right", group = "Clients" }),
  awful.key({ MOD, CTRL }, "j", function()
    helpers.client.resize_client(client.focus, "down")
  end, { description = "Resize down", group = "Clients" }),
  awful.key({ MOD, CTRL }, "k", function()
    helpers.client.resize_client(client.focus, "up")
  end, { description = "Resize up", group = "Clients" }),

  -- LAYOUTS ----------------------------------------------------------------------------------------------------------
  awful.key({ MOD }, "v", function()
    awful.layout.inc(1)
  end, { description = "Next layout", group = "Layouts" }),
  awful.key({ MOD, SHIFT }, "v", function()
    awful.layout.inc(-1)
  end, { description = "Prev layout", group = "Layouts" }),
})

client.connect_signal("request::default_keybindings", function()
  awful.keyboard.append_client_keybindings({
    -- Move or swap by direction
    awful.key({ MOD, SHIFT }, "h", function(c)
      helpers.client.move_client(c, "left")
    end, { description = "Move/Swap left", group = "Clients" }),
    awful.key({ MOD, SHIFT }, "l", function(c)
      helpers.client.move_client(c, "right")
    end, { description = "Move/Swap right", group = "Clients" }),
    awful.key({ MOD, SHIFT }, "j", function(c)
      helpers.client.move_client(c, "down")
    end, { description = "Move/Swap down", group = "Clients" }),
    awful.key({ MOD, SHIFT }, "k", function(c)
      helpers.client.move_client(c, "up")
    end, { description = "Move/Swap up", group = "Clients" }),

    -- Move client relatively
    awful.key({ MOD, ALT }, "h", function(c)
      c:relative_move(dpi(-20), 0, 0, 0)
    end, { description = "Move left relatively", group = "Clients" }),
    awful.key({ MOD, ALT }, "l", function(c)
      c:relative_move(dpi(20), 0, 0, 0)
    end, { description = "Move right relatively", group = "Clients" }),
    awful.key({ MOD, ALT }, "j", function(c)
      c:relative_move(0, dpi(20), 0, 0)
    end, { description = "Move up relatively", group = "Clients" }),
    awful.key({ MOD, ALT }, "k", function(c)
      c:relative_move(0, dpi(-20), 0, 0)
    end, { description = "Move down relatively", group = "Clients" }),

    -- Toggle floating
    awful.key({ MOD }, "space", awful.client.floating.toggle, { description = "Toggle floating", group = "Clients" }),

    -- Toggle fullscreen
    awful.key({ MOD }, "f", function()
      client.focus.fullscreen = not client.focus.fullscreen
      client.focus:raise()
    end, { description = "Toggle fullscreen", group = "Client" }),

    -- Toggle maximize client
    awful.key({ MOD }, "m", function(c)
      c.maximized = not c.maximized
    end, { description = "Toggle maximize", group = "Clients" }),
    -- Minimize client
    awful.key({ MOD, SHIFT }, "m", function(c)
      c.minimized = true
    end, { description = "Minimize", group = "Clients" }),
    -- Unmaximize client
    awful.key({ MOD, CTRL }, "m", function()
      local c = awful.client.restore()
      if c then
        c:activate({ raise = true, context = "key.unminimize" })
      end
    end, { description = "Unminimize", group = "Clients" }),

    --- Keep on top
    awful.key({ MOD, SHIFT }, "o", function(c)
      c.ontop = not c.ontop
    end),

    --- Sticky
    awful.key({ MOD, SHIFT }, "s", function(c)
      c.sticky = not c.sticky
    end),

    --- Close window
    awful.key({ MOD, SHIFT }, "c", function()
      client.focus:kill()
    end),

    --- Center window
    awful.key({ MOD }, "c", function(c)
      helpers.client.centered_client_placement(c)
    end),
  })
end)

-- Tags
awful.keyboard.append_global_keybindings({
  awful.key({
    modifiers = { MOD },
    keygroup = "numrow",
    description = "View tag",
    group = "Tags",
    on_press = function(index)
      local s = awful.screen.focused()
      local tag = s.tags[index]
      if tag then
        tag:view_only()
      end
    end,
  }),
  awful.key({
    modifiers = { MOD, CTRL },
    keygroup = "numrow",
    description = "Toggle tag",
    group = "Tags",
    on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end,
  }),
  awful.key({
    modifiers = { MOD, SHIFT },
    keygroup = "numrow",
    description = "Move focused client to tag",
    group = "Tags",
    on_press = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end,
  }),
})

-- Mouse
awful.mouse.append_global_mousebindings({
  -- left click
  awful.button({}, 1, function()
    naughty.destroy_all_notifications()
  end),
})

--- Mouse buttons on the client
client.connect_signal("request::default_mousebindings", function()
  awful.mouse.append_client_mousebindings({
    awful.button({}, 1, function(c)
      c:activate({ context = "mouse_click" })
    end),
    awful.button({ MOD }, 1, function(c)
      c:activate({ context = "mouse_click", action = "mouse_move" })
    end),
    awful.button({ MOD }, 3, function(c)
      c:activate({ context = "mouse_click", action = "mouse_resize" })
    end),
  })
end)
