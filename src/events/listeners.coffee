import { listen, capture } from "./listen"
import { intercept, prevent } from "./intercept"
import { form } from "../form"
import { matches } from "../matches"

Listener =
  intercept: ( name ) ->
    ( root, selector, handler ) ->
      listen root, name, ( event ) ->
        if matches selector, event
          intercept event
          handler event

click = Listener.intercept "click"
change = Listener.intercept "change"
input = Listener.intercept "input"

submit = ( root, handler ) ->
  listen root, "submit", ( event ) ->
    intercept event
    handler form root

invalid = ( root, handler  ) ->
  capture root, "invalid", ( event ) ->
    prevent event
    handler event.target if event.target?

export {
  click
  change
  input
  submit
  invalid 
}

