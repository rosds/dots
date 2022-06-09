import Control.Monad (forM_)

import Data.List (isPrefixOf)

-- utils
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.NamedScratchpad

-- hooks
import XMonad.Util.Run (safeSpawn)

import XMonad
import XMonad.Actions.CycleWS
import XMonad.Hooks.DynamicLog hiding (pad)
import XMonad.Hooks.DynamicProperty
import XMonad.Hooks.ManageDocks
  ( ToggleStruts(ToggleStruts)
  , avoidStruts
  , docks
  , manageDocks
  )
import XMonad.StackSet (RationalRect(..))

-- layouts
import XMonad.Layout
import XMonad.Layout.Spacing

-- Polybar
import Polybar (Color(..), bg, fg, pad, underline)

-- workspaces
myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "NSP"]

-- Log workspace state for polybar
myLogHook :: PP
myLogHook =
  def
    { ppOutput = \s -> appendFile "/tmp/.xmonad-workspace-log" (s ++ "\n")
    , ppCurrent = underline Yellow . pad 1
    , ppVisible = underline Orange . pad 1
    , ppTitle = const ""
    , ppLayout = const ""
    , ppHidden = underline LightGray . pad 1
    , ppHiddenNoWindows = id
    }

myLayoutHook =
  spacingRaw True (Border 0 0 0 0) True (Border 10 10 10 10) True $
  layoutHook def

-- Scratch pads
myScratchpads =
  [ NS "spotify" "spotify" (className =? "Spotify") myFloating
  , NS
      "neovide"
      -- "neovide --x11-wm-class org -- -c ':Org'"
      -- (className =? "org")
      "kitty --name=org vi -c ':Org'"
      (appName =? "org")
      myFloating
  , NS "kitty" "kitty --name=quickty" (appName =? "quickty") myFloating
  ]
  where
    myFloating = customFloating $ RationalRect (1 / 9) (1 / 8) (7 / 9) (6 / 8)

titleStartsWith :: String -> Query Bool
titleStartsWith s = fmap (s `isPrefixOf`) title

myManageHook =
  manageHook def <+>
  manageDocks <+>
  namedScratchpadManageHook myScratchpads <+>
  composeAll
    [ className =? "Spotify" --> doFloat
    , className =? "zoom " --> doFloat
    , title =? "Zoom Cloud Meetings" --> doFloat
    , className =? "Google-chrome" --> doShift (myWorkspaces !! 1)
    , titleStartsWith "join?action" --> doFloat
    ]

-- Issue with the spotify window changing titles
myHandleEventHook =
  dynamicPropertyChange
    "WM_NAME"
    (composeAll
       [ title =? "Spotify" --> doFloat
       , titleStartsWith "Google Chat" --> doShift (myWorkspaces !! 2)
       ])

main :: IO ()
main = do
  safeSpawn "mkfifo" ["/tmp/.xmonad-workspace-log"] -- log workspace string for polybar
  xmonad $
    docks
      def
        { workspaces = myWorkspaces
        , terminal = "kitty"
        , manageHook = myManageHook
        , layoutHook = avoidStruts $ myLayoutHook
        , handleEventHook = myHandleEventHook <> handleEventHook def
        , logHook = dynamicLogWithPP myLogHook
        , modMask = mod4Mask
        } `additionalKeysP`
      -- keybinings
    [ ("M-p", spawn "rofi -show run")
    , ("M-<Right>", nextWS)
    , ("M-<Left>", prevWS)
    , ("M-<Tab>", toggleWS)
    , ("M-b", sendMessage ToggleStruts)
    , ("M-S-l", spawn "i3lock-fancy --pixelate")
    , ( "<Print>"
      , spawn
          "sleep 0.5; scrot -s 'shot_%Y-%m-%d.png' -e 'mv $f ~/shots/; eog ~/shots/$f'")
    -- switch focus between monitors
    , ("M-e", nextScreen)
    , ("M-w", prevScreen)
      -- media keys
    , ("<XF86AudioPlay>", spawn "playerctl play-pause")
    , ("<XF86AudioNext>", spawn "playerctl next")
    , ("<XF86AudioPrev>", spawn "playerctl previous")
      -- scratchpads
    , ("M-S-m", namedScratchpadAction myScratchpads "spotify")
    , ("M-S-n", namedScratchpadAction myScratchpads "neovide")
    , ("M-S-t", namedScratchpadAction myScratchpads "kitty")
    ]
