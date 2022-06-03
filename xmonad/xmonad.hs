import Control.Monad (forM_)
import XMonad
import XMonad.Actions.CycleWS
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig
import XMonad.Util.Run (safeSpawn)

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
purple = "#d3869b"
aqua = "#8ec07c"
black = "#282828"
gray = "#928374"

myLogHook :: PP
myLogHook =
  let fg c = wrap ("%{F" <> c <> "}") "%{F-}"
      bg c =  wrap ("%{B" <> c <> "}") "%{B-}"
      pad n =  wrap (replicate n ' ') (replicate n ' ')
   in def
        { ppOutput = \s -> appendFile "/tmp/.xmonad-workspace-log" (s ++ "\n")
        , ppCurrent = fg black . bg yellow . pad 1
        , ppVisible = bg gray . pad 1
        , ppTitle = fg aqua
        , ppLayout = const ""
        , ppHiddenNoWindows = id
        }

main :: IO ()
main = do
  -- log workspace string for polybar
  safeSpawn "mkfifo" ["/tmp/.xmonad-workspace-log"]

  xmonad $
    docks
      def
        { workspaces =
            ["1:dev", "2:web", "3:chat", "4:media", "5", "6", "7", "8", "9"]
        , terminal = "kitty"
        , manageHook = myManageHook <+> manageHook def <+> manageDocks
        , layoutHook = avoidStruts $ myLayoutHook
        , logHook = dynamicLogWithPP myLogHook
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
