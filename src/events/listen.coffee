import * as Fn from "@dashkite/joy/function"

# TODO align argument conventions
#      we're inconsistent about passing the element
#      last. ex: here we pass it first.

listen = Fn.curry ( root, name, handler  ) ->
  root.addEventListener name, handler

capture = Fn.curry ( root, name, handler  ) ->
  root.addEventListener name, handler, capture: true

export {
  listen
  capture
}