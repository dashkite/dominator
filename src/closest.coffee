import * as Fn from "@dashkite/joy/function"
import Generic from "@dashkite/generic"

closest = Fn.curry Fn.binary do ->

  Generic.make "closest"

    .define [ String, Event ], 
      ( selector, { target }) -> 
        closest selector, target if target?

    .define [ String, Element ], 
      ( selector, element ) -> 
        element.closest? selector

export { closest }