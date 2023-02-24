module Polybar where

data Color
  = Aqua
  | Black
  | Blue
  | Gray
  | Green
  | LightGray
  | Orange
  | Purple
  | Yellow
  | Custom String
  deriving (Show, Eq)

class ColorScheme a where
  code :: a -> Color -> String

data Gruvbox = Gruvbox

data EverForest = EverForest

instance ColorScheme Gruvbox where
  code _ Aqua       = "#8ec07c"
  code _ Black      = "#282828"
  code _ Blue       = "#83a598"
  code _ Gray       = "#3c3836"
  code _ Green      = "#b8bb26"
  code _ LightGray  = "#928374"
  code _ Orange     = "#fe8019"
  code _ Purple     = "#d3869b"
  code _ Yellow     = "#fabd2f"
  code _ (Custom s) = s

instance ColorScheme EverForest where
  code _ Aqua       = "#7fbbb3"
  code _ Black      = "#293136"
  code _ Blue       = "#7fbbb3"
  code _ Gray       = "#555f66"
  code _ Green      = "#a7c080"
  code _ LightGray  = "#9da9a0"
  code _ Orange     = "#e69875"
  code _ Purple     = "#d699b6"
  code _ Yellow     = "#dbbc7f"
  code _ (Custom s) = s

defaultColorScheme :: Gruvbox
defaultColorScheme = Gruvbox

fg :: Color -> String -> String
fg color str =
  let c = code defaultColorScheme color
   in "%{F" <> c <> "}" <> str <> "%{F-}"

bg :: Color -> String -> String
bg color str =
  let c = code defaultColorScheme color
   in "%{B" <> c <> "}" <> str <> "%{B-}"

pad :: Int -> String -> String
pad n str = replicate n ' ' <> str <> replicate n ' '

underline :: Color -> String -> String
underline color str =
  let c = code defaultColorScheme color
   in "%{+u}" <> "%{u" <> c <> "}" <> str <> "%{u-}" <> "%{-u}"
