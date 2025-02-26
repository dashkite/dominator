import * as Fn from "@dashkite/joy/function"
import Generic from "@dashkite/generic"

matches = Fn.curry Fn.binary do ->

  Generic.make "matches"

    .define [ String, Event ], 
      ( selector, { target }) -> 
        matches target if target?

    .define [ String, Element ], 
      ( selector, element ) -> 
        element.matches? selector

export { matches }