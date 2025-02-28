import * as Fn from "@dashkite/joy/function"
import { Queue } from "@dashkite/joy/iterable"

modified = ( records ) ->
  records.some ({ target, attributeName, oldValue }) ->
    ( target.getAttribute attributeName ) != oldValue

modify = Fn.curry ( attributes, element ) ->
  queue = new Queue
  handler = ( records ) -> 
    if ( modified records ) then queue.enqueue { element }
  observer = new MutationObserver handler
  observer.observe element, 
    attributes: true
    attributeFilter: attributes
  queue

export { modify }