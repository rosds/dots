import Data.List (isPrefixOf)
import Data.Maybe (catMaybes, listToMaybe)
import Polybar
  ( Color (..),
    bg,
    pad,
  )
import System.Directory (findExecutable)
import XMonad
import XMonad.Actions.CycleWS
import qualified XMonad.Actions.Search as S
import XMonad.Hooks.DynamicLog hiding (pad)
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
  ( ToggleStruts (ToggleStruts),
    avoidStruts,
    docks,
    manageDocks,
  )
import XMonad.Hooks.OnPropertyChange
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed (Rename (Replace), renamed)
import XMonad.Layout.ResizableTile (ResizableTall (ResizableTall))
import XMonad.Layout.Spacing
import qualified XMonad.Prompt as P
import XMonad.StackSet (RationalRect (..))
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run (safeSpawn)
import XMonad.Util.SpawnOnce

-- Workspaces
myWorkspaces :: [String]
myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "NSP"]

-- XPConfig
myPromptConfig :: P.XPConfig
myPromptConfig =
  def
    { P.font = "FiraCode Nerd Font:size=10",
      P.bgColor = "#1F1F28",
      P.fgColor = "#DCD7BA",
      P.borderColor = "#938AA9",
      P.position = P.Top
    }

-- Search engines
gitlabSearch :: String -> String
gitlabSearch s
  | "#" `isPrefixOf` s = "https://gitlab.apex.ai/ApexAI/grand_central/-/issues/" ++ drop 1 s
  | "!" `isPrefixOf` s = "https://gitlab.apex.ai/ApexAI/grand_central/-/merge_requests/" ++ drop 1 s
  | "&" `isPrefixOf` s = "https://gitlab.apex.ai/ApexAI/grand_central/-/epics/" ++ drop 1 s
  | otherwise = "https://gitlab.apex.ai/search?nav_source=navbar&scope=merge_requests&search=" ++ S.escape s

searchEngineMap :: [(String, S.SearchEngine)]
searchEngineMap =
  [ ("g", S.google),
    ("d", S.searchEngine "grace" "https://apexai.pages.apex.ai/grand_central/master/grace/doc/?q="),
    ("s", S.searchEngineF "gitlab" gitlabSearch)
  ]

-- Log workspace state for Polybar
myLogHook :: X ()
myLogHook =
  dynamicLogWithPP
    def
      { ppOutput = \s -> appendFile "/tmp/.xmonad-workspace-log" (s ++ "\n"),
        ppCurrent = bg Yellow . pad 1,
        ppVisible = bg Purple . pad 1,
        ppTitle = const "",
        ppLayout = const "",
        ppWsSep = "",
        ppHidden = bg Gray . pad 1,
        ppHiddenNoWindows = pad 1
      }

tiled =
  renamed [Replace "Tiled"] $
    avoidStruts $
      smartBorders $
        spacingRaw True (Border 0 10 10 10) True (Border 10 10 10 10) True $
          ResizableTall 1 (3 / 100) (1 / 2) []

tiledSpacing =
  renamed [Replace "TiledSpacing"] $
    avoidStruts $
      smartBorders $
        spacing 20 $
          ResizableTall 1 (3 / 100) (1 / 2) []

myLayoutHook = tiled ||| tiledSpacing ||| Full

-- myTerm = "alacritty"
myTerm :: String
myTerm = "kitty"

-- Scratch pads
myScratchpads :: [NamedScratchpad]
myScratchpads =
  [ NS "spotify" "spotify" (className =? "Spotify") myFloating,
    NS
      "neovide"
      "neovide --x11-wm-class org -- -c ':Neorg workspace notes'"
      -- "neovide --x11-wm-class org -- -c ':Org'"
      (className =? "org")
      -- "kitty --name=org vi -c ':Org'"
      -- (appName =? "org")
      myFloating,
    NS
      "scratchterm"
      (myTerm <> " --class=scratchterm")
      (className =? "scratchterm")
      myFloating,
    NS
      "calendar"
      "google-chrome --app=https://calendar.google.com"
      (resource =? "calendar.google.com")
      myFloating,
    NS
      "chat"
      "google-chrome --app=https://chat.google.com"
      (resource =? "chat.google.com")
      myFloating
  ]
  where
    myFloating = customFloating $ RationalRect (1 / 9) (1 / 8) (7 / 9) (6 / 8)

myExclusive :: X ()
myExclusive =
  addExclusives
    [ ["spotify", "neovide", "scratchterm", "calendar", "chat"],
      ["neovide", "scratchterm", "calendar", "chat"],
      ["scratchterm", "calendar", "chat"],
      ["calendar", "chat"]
    ]

(^=) :: Query String -> String -> Query Bool
(^=) q s = fmap (s `isPrefixOf`) q

myManageHook :: ManageHook
myManageHook =
  manageHook def
    <+> manageDocks
    <+> namedScratchpadManageHook myScratchpads
    <+> composeAll
      [ className =? "Spotify" --> doFloat,
        className =? "zoom" --> doFloat,
        className =? "copyq" --> doFloat,
        className =? "1password" --> doFloat,
        title =? "Zoom Cloud Meetings" --> doFloat,
        className =? "Google-chrome" --> doShift (myWorkspaces !! 1),
        title ^= "join?action" --> doFloat
      ]

-- Issue with the spotify window changing titles
myHandleEventHook =
  onXPropertyChange
    "WM_NAME"
    ( composeAll
        [ title =? "Spotify" --> doFloat,
          className =? "zoom" --> doFloat,
          className =? "1password" --> doFloat
        ]
    )

myStartupHook :: X ()
myStartupHook = do
  spawnOnce "picom --backend glx &"
  spawnOnce "dunst &"
  spawnOnce "nm-applet &"
  spawnOnce "copyq &"
  spawnOnce "polybar --reload -c $HOME/.config/polybar/config.ini main &"
  spawnOnce "feh --image-bg black --bg-fill ~/Pictures/bg"

rofi :: String
rofi = "~/.config/rofi/launchers/type-4/launcher.sh"

main :: IO ()
main = do
  safeSpawn "mkfifo" ["/tmp/.xmonad-workspace-log"] -- log workspace string for polybar
  xmonad $
    ewmh . docks $
      def
        { workspaces = myWorkspaces,
          terminal = myTerm,
          manageHook = myManageHook,
          layoutHook = myLayoutHook,
          handleEventHook = myHandleEventHook <> handleEventHook def,
          logHook = myLogHook,
          modMask = mod4Mask,
          -- focusedBorderColor = "#a7c080"
          -- focusedBorderColor = "#98971a"
          focusedBorderColor = "#957FB8",
          normalBorderColor = "#16161D",
          startupHook = myStartupHook >> myExclusive
        }
        `additionalKeysP`
        -- keybindings
        [ ("M-v", spawn "copyq toggle"),
          ("M-p", spawn (rofi <> " -show run")),
          ("M-S-p", spawn (rofi <> " -show window")),
          ("M-<Right>", nextWS),
          ("M-<Left>", prevWS),
          ("M-<Tab>", toggleWS),
          ("M-b", sendMessage ToggleStruts),
          -- ("M-S-l", spawn "i3lockfancy --pixelate"),
          ("M-S-l", spawn "i3lock -t -i ~/Pictures/bg"),
          -- ( "<Print>",
          --   spawn
          --     "sleep 0.5; scrot -s 'shot_%Y-%m-%d.png' -e 'mv $f ~/shots/; eog ~/shots/$f'"
          -- ),
          ("<Print>", spawn "flameshot gui"),
          -- switch focus between monitors
          ("M-e", nextScreen),
          ("M-w", prevScreen),
          -- media keys
          ("<XF86AudioPlay>", spawn "playerctl play-pause"),
          ("<XF86AudioNext>", spawn "playerctl next"),
          ("<XF86AudioPrev>", spawn "playerctl previous"),
          -- scratchpads
          ("M-S-m", namedScratchpadAction myScratchpads "spotify"),
          ("M-S-n", namedScratchpadAction myScratchpads "neovide"),
          ("M-S-t", namedScratchpadAction myScratchpads "scratchterm"),
          ("M-S-o", namedScratchpadAction myScratchpads "calendar"),
          ("M-S-i", namedScratchpadAction myScratchpads "chat")
        ]
        -- search engines
        ++ [("M-s " <> key, S.promptSearchBrowser myPromptConfig "google-chrome" engine) | (key, engine) <- searchEngineMap]
        ++ [("M-S-s " <> key, S.selectSearchBrowser "google-chrome" engine) | (key, engine) <- searchEngineMap]
