local awful = require("awful")
local helpers = require("helpers")
local ruled = require("ruled")

--- Get screen geometry
local screen_width = awful.screen.focused().geometry.width
local screen_height = awful.screen.focused().geometry.height

ruled.client.connect_signal("request::rules", function()
  -- All clients will match this rule.
  ruled.client.append_rule({
    id = "global",
    rule = {},
    properties = {
      focus = awful.client.focus.filter,
      raise = true,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
    },
  })

  -- small floating
  ruled.client.append_rule({
    id = "small-floating",
    rule_any = {
      instance = {
        "pavucontrol",
      },
      class = {
        "calc",
        "fterm",
        "Blueman-manager",
        "nm-connection-editor",
        "pavucontrol",
      },
      role = {
        "pop-up",
      },
    },
    properties = {
      floating = true,
      ontop = true,
      width = screen_width * 0.5,
      height = screen_height * 0.5,
      opacity = 0.8,
      placement = helpers.client.centered_client_placement,
    },
  })

  -- medium floating
  ruled.client.append_rule({
    id = "medium-floating",
    rule_any = {
      class = {
        "Thunar",
      },
    },
    properties = {
      floating = true,
      ontop = true,
      width = screen_width * 0.7,
      height = screen_height * 0.7,
      placement = helpers.client.centered_client_placement,
    },
  })

  -- large floating
  ruled.client.append_rule({
    id = "large-floating",
    rule_any = {
      class = {
        "btop",
        "imv",
      },
    },
    properties = {
      floating = true,
      ontop = true,
      width = screen_width * 0.9,
      height = screen_height * 0.9,
      placement = helpers.client.centered_client_placement,
    },
  })

  -- Godot Engine (game window)
  ruled.client.append_rule({
    id = "godot-engine",
    rule_any = {
      instance = {
        "Godot_Engine",
      },
    },
    properties = {
      floating = true,
      ontop = true,
      placement = helpers.client.centered_client_placement,
    },
  })
end)
