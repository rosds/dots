import XMonad
import XMonad.Actions.CycleWS
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig
import qualified XMonad.DBus as D
import qualified DBus.Client as DB

myManageHook =
  composeAll
    [ className =? "Google-chrome" --> doShift "2:web"
    , className =? "Slack" --> doShift "3:chat"
    , className =? "Spotify" --> doShift "4:media"
    ]

myLayoutHook =
  spacingRaw True (Border 0 0 0 0) True (Border 10 10 10 10) True $
  layoutHook def

-- some gruvbox colors
green = "#b8bb26"

yellow = "#fabd2f"

blue = "#83a598"

aqua = "#8ec07c"

myLogHook :: DB.Client -> PP
myLogHook dbus =
  let color c = wrap ("%{F" <> c <> "}") "%{F-}"
      big = wrap ("%{T2} ") " %{T-}"
      prefix = ((big $ color blue "λ") ++)
   in def
        { ppOutput = D.send dbus . prefix
        , ppCurrent = color yellow
        , ppTitle = color aqua
        , ppLayout = const ""
        }

main :: IO ()
main = do
  dbus <- D.connect
  D.requestAccess dbus
  xmonad $
    docks
      def
        { workspaces =
            ["1:dev", "2:web", "3:chat", "4:media", "5", "6", "7", "8", "9"]
        , terminal = "kitty"
        , manageHook = myManageHook <+> manageHook def <+> manageDocks
        , layoutHook = avoidStruts $ myLayoutHook
        , logHook = dynamicLogWithPP (myLogHook dbus)
        , modMask = mod4Mask
        } `additionalKeysP`
    [ ("M-p", spawn "rofi -show run")
    , ("M-<Right>", nextWS)
    , ("M-<Left>", prevWS)
    , ("M-<Tab>", toggleWS)
    , ("M-b", sendMessage ToggleStruts)
    , ("M-S-l", spawn "i3lock-fancy --pixelate")
        -- media keys
    , ("<XF86AudioPlay>", spawn "playerctl play-pause")
    , ("<XF86AudioNext>", spawn "playerctl next")
    , ("<XF86AudioPrev>", spawn "playerctl previous")
    ]
