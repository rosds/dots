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
data Kanagawa = Kanagawa

instance ColorScheme Kanagawa where
  code _ Aqua       = "#689d6a"
  code _ Black      = "#282828"
  code _ Blue       = "#7E9CD8"
  code _ Gray       = "#363646"
  code _ Green      = "#98BB6C"
  code _ LightGray  = "#a89984"
  code _ Orange     = "#fe8019"
  code _ Purple     = "#54546D"
  code _ Yellow     = "#FF9E3B"
  code _ (Custom s) = s

instance ColorScheme Gruvbox where
  code _ Aqua       = "#689d6a"
  code _ Black      = "#282828"
  code _ Blue       = "#458588"
  code _ Gray       = "#3c3836"
  code _ Green      = "${colors.green}"
  code _ LightGray  = "#a89984"
  code _ Orange     = "#fe8019"
  code _ Purple     = "#d3869b"
  code _ Yellow     = "#d79921"
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

defaultColorScheme :: Kanagawa
defaultColorScheme = Kanagawa

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
