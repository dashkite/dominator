import * as Fn from "@dashkite/joy/function"
import * as Obj from "@dashkite/joy/object"
import { Queue } from "@dashkite/joy/iterable"
import Generic from "@dashkite/generic"

_modified = ( records ) ->
  records.some ({ target, attributeName, oldValue }) ->
    ( target.getAttribute attributeName ) != oldValue

modified = Fn.curry Fn.binary do ->

  Generic.make "modified"

    .define [ Object, Element ], ( _, element ) ->
      queue = Queue.make()
      observer = new MutationObserver -> queue.enqueue { element }
      observer.observe element, childList: true
      queue

    .define [( Obj.has "attributes" ), Element ], ({ attributes }, element ) ->
      queue = Queue.make()
      handler = ( records ) -> 
        if ( _modified records ) then queue.enqueue { element }
      observer = new MutationObserver handler
      observer.observe element, 
        attributes: true
        attributeFilter: attributes
      queue

modify = Fn.curry ( attributes, element ) ->
  queue = new Queue
  handler = ( records ) ->
    if ( _modified records ) then queue.enqueue { element }
  observer = new MutationObserver handler
  observer.observe element, 
    attributes: true
    attributeFilter: attributes
  queue

export { modify, modified }