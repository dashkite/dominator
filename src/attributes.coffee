import * as Fn from "@dashkite/joy/function"
import * as Obj from "@dashkite/joy/object"

get = Fn.curry ( name, element ) -> element.getAttribute name

attribute = get

set = Fn.curry ( name, value, element ) -> 
  element.setAttribute name, value

attributes = ( element ) ->
  Obj.expand delimiter: "-", 
    Object.fromEntries do ->
      Array
        .from element.attributes
        .map ({ name, value }) -> [ name, value ]

data = ( element ) ->
  ( attributes element ).data

dataset = ( element ) -> { element.dataset... }

export { 
  get
  set
  attribute
  attributes 
  data
  dataset
}