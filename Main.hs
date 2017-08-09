{-# LANGUAGE DataKinds                  #-}
{-# LANGUAGE ExtendedDefaultRules       #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE RecordWildCards            #-}
{-# LANGUAGE ScopedTypeVariables        #-}
{-# LANGUAGE TypeFamilies               #-}
{-# LANGUAGE TypeOperators              #-}
module Main where

import           Control.Concurrent
import           Control.Monad
import qualified Data.Char          as C
import qualified Data.Map           as M
import           Data.Monoid
import qualified Data.Set           as S
import           Miso
import           Miso.Svg           hiding (height_, id_, style_, width_)

default (MisoString)

main :: IO ()
main =
  startApp emptyModel updateModel viewModel subs defaultEvents
    where
      subs = [ mouseSub HandleMouse
             , windowSub HandleWindow
             , keyboardSub HandleKeys
             ]

emptyModel :: Model
emptyModel = Model (0,0) (0,0) mempty 0

-- | Updates model, can perform side-effects
updateModel :: Action -> Model -> Effect Model Action
updateModel (HandleMouse newCoords) model = noEff model { mouseCoords = newCoords }
updateModel (HandleWindow newCoords) model = noEff model { windowCoords = newCoords }
updateModel (HandleKeys newKeys) model = noEff model { keys = newKeys }
updateModel AddOne model = noEff model { val = val model + 1 }
updateModel SubOne model = noEff model { val = val model - 1 }
updateModel Id model = noEff model
updateModel (SomeInt int) model = noEff model { val = int }
updateModel (Focus id') model =
  model <# do focus id' >> pure Id
updateModel (Blur id') model =
  model <# do blur id' >> pure Id

data Action
  = HandleMouse (Int, Int)
  | HandleWindow (Int, Int)
  | HandleKeys (S.Set Int)
  | AddOne
  | SomeInt Int
  | SubOne
  | Focus MisoString
  | Blur MisoString
  | Id

data Model = Model {
   mouseCoords  :: (Int, Int)
 , windowCoords :: (Int, Int)
 , keys         :: S.Set Int
 , val          :: Int
} deriving (Show, Eq)

viewModel :: Model -> View Action
viewModel Model{..} = div_ [] [
 --   div_ [] [ text ("Mouse Coords:" <> show mouseCoords) ]
 -- , div_ [] [ text ("Window Coords:" <> show windowCoords) ]
 -- , div_ [] [ text ("Keys pressed:" <> show ( (C.toLower . C.chr) `S.map` keys )) ]
 -- , div_ [ ] [
 --       button_ [ onClick AddOne ] [ text (pack "+") ]
 --     , text (show val)
 --     , button_ [ onClick SubOne ] [ text (pack "-") ]
 --   ]
 -- , div_ [ ] [
 --       button_ [ onClick (Focus "input") ] [ text $ pack "focus on input" ]
 --     , input_ [ type_ "text"
 --              , id_ "input"
 --              , autofocus_ True
 --              ] []
 --     , button_ [ onClick (Blur "input") ] [ text $ pack "blur input"]
 --     ]
 svg_ [ height_ "auto"
        , width_ "auto"
        , style_ $ M.fromList [("border-style", "solid")]
        ] [
     ellipse_ [ cx_ $ pack $ show (fst mouseCoords)
              , cy_ $ pack $ show (snd mouseCoords)
              , style_ svgStyle
              , rx_ "100"
              , ry_ "100"
              ] []
   ]
 ]

svgStyle :: M.Map MisoString MisoString
svgStyle =
  M.fromList [
      ("fill", "yellow")
    , ("stroke", "purple")
    , ("stroke-width", "2")
    ]
