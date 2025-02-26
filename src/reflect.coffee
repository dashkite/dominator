import * as Fn from "@dashkite/joy/function"
import * as Obj from "@dashkite/joy/object"

reflect = Fn.curry ( attributes, element ) ->
  for key, value of ( Obj.collapse delimiter: "-", attributes )
    element.setAttribute key, value

export { reflect }