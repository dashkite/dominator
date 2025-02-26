import * as Fn from "@dashkite/joy/function"

listen = Fn.curry ( root, name, handler  ) ->
  root.addEventListener name, handler

capture = Fn.curry ( root, name, handler  ) ->
  root.addEventListener name, handler, capture: true

export {
  listen
  capture
}