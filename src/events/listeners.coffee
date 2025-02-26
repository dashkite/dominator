import { listen, capture } from "./listen"
import { intercept, prevent } from "./intercept"
import { form } from "../form"

submit = ( root, handler ) ->
  listen "submit", ( event ) ->
    intercept event
    handler form root

invalid = ( root, handler  ) ->
  capture root, "invalid", ( event ) ->
    prevent event
    handler event.target if event.target?

export {
  submit
  invalid 
}

