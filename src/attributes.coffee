import * as Fn from "@dashkite/joy/function"
import * as Obj from "@dashkite/joy/object"

get = Fn.curry ( name, element ) -> element.getAttribute name

attribute = get

set = Fn.curry ( name, value, element ) -> 
  element.setAttribute name, value

attributes = ( reference ) ->
  Obj.expand delimiter: "-", 
    Object.fromEntries do ->
      Array
        .from element.attributes
        .map ({ name, value }) -> [ name, value ]

data = ( element ) ->
  # element = ( $ element ).get()
  ( attributes element ).dataset

dataset = ( element ) -> { element.dataset... }

export { 
  get
  set
  attribute
  attributes 
  data
  dataset
}
