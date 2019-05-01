import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig

myManageHook = composeAll
    [ className =? "Google Chrome" --> doShift "2:web"
    , className =? "Slack"         --> doShift "3:chat"
    ]

main = xmonad $ def
    { workspaces = ["1:dev", "2:web", "3:chat", "4:media", "5", "6", "7", "8", "9"]
    , terminal = "kitty"
    , manageHook = myManageHook <+> manageHook def
    , modMask = mod4Mask
    } `additionalKeysP`
    [ ("M-p", spawn "rofi -show run")
    ]
