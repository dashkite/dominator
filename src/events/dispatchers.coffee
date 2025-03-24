import * as Fn from "@dashkite/joy/function"

Actions =

  click: ( element ) -> element.click()

  focus: ( element ) -> element.focus()


action = Fn.curry ( name, element ) ->
  Actions[ name ] element

export {
  action
}