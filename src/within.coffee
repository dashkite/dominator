import * as Fn from "@dashkite/joy/function"
import Generic from "@dashkite/generic"

within = Fn.curry Fn.binary do ->

  Generic.make "within"

    .define [ String, Event ], 
      ( selector, { target }) -> 
        within selector, target if target?

    .define [ String, Element ], 
      ( selector, element ) -> 
        ( element.closest? selector )?

export { within }
