import * as Fn from "@dashkite/joy/function"
import * as Obj from "@dashkite/joy/object"
import { Queue } from "@dashkite/joy/iterable"
import Generic from "@dashkite/generic"

DOM =

  get: _get = Fn.curry ( name, element ) -> element.getAttribute name

  set: Fn.curry ( name, value, element ) -> element.setAttribute name, value

  attribute: _get

  attributes: ( element ) ->
    Obj.expand delimiter: "-", 
      Object.fromEntries do ->
        Array
          .from element.attributes
          .map ({ name, value }) -> [ name, value ]

  reflect: ( attributes, element ) ->
    for key, value of ( Obj.collapse delimiter: "-", attributes )
      element.setAttribute key, value

  modify: do ({ modified } = {}) ->
    modified = ( records ) ->
      records.some ({ target, attributeName, oldValue }) ->
        ( target.getAttribute attributeName ) != oldValue
    Fn.curry ( attributes, element ) ->
      do ({ queue, handler, observer } = {}) ->
        queue = new Queue
        handler = ( records ) -> 
          if ( modified records ) then queue.enqueue { element }
        observer = new MutationObserver handler
        observer.observe element, 
          attributes: true
          attributeFilter: attributes
        queue

  slots: ( element ) ->
    result = {}
    for element from element.querySelectorAll "[slot]"
      result[ element.slot ] = element
    result

  nextSibling: _next = ( element ) -> element.nextSibling

  next: _next

  closest: ( selector ) -> ( element ) -> element.closest selector

  click: ( element ) -> do element.click

  focus: ( element ) -> do element.focus

  # TODO overload to take iterator or element?
  dispatch: ( name ) ->
    ( reactor ) ->
      do ->
        for await { element } from reactor
          element.dispatchEvent new CustomEvent name,
            detail: element 
            bubbles: true
            cancelable: false
            composed: true
      return

export default DOM