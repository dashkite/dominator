import { Queue } from "@dashkite/joy/iterable"
import * as Obj from "@dashkite/joy/object"

DOM =

  attributes: ( el ) ->
    Obj.expand delimiter: "-", 
      Object.fromEntries do ->
        Array.from el.attributes
          .map ({ name, value }) -> [ name, value ]

  closest: ( selector ) -> ( el ) -> el.closest selector

  nextSibling: ( el ) -> el.nextSibling

  click: ( el ) -> do el.click

  focus: ( el ) -> do el.focus

  slots: ( el ) ->
    result = {}
    for el from el.querySelectorAll "[slot]"
      result[ el.slot ] = el
    result

  target: ( ev ) -> ev.target

  # TODO support other cases
  # modify: do ({ f } = {}) ->
    
  #   ( Generic "modify" )
    
  #     .define [ Array ], ( attributes ) ->
  #       ( el ) ->
  #         queue = new Queue
  #         handler = ( records, observer ) -> queue.enqueue { records, observer }
  #         observer = new MutationObserver handler
  #         observer.observe handle.dom, attributes: true, attributeFilter: attributes
  #         queue

  #     .define [ Object ], ( options ) ->
  #       ( el ) ->

  #     .define [ Array, Object ], ( attributes, options ) ->
  #       ( el ) ->
  
  modify: ( attributes ) ->
    ( element ) ->
      queue = new Queue
      handler = ( records ) -> 
        modified = records.some ({ target, attributeName, oldValue }) ->
          ( target.getAttribute attributeName ) != oldValue
        if modified then queue.enqueue { element }
      observer = new MutationObserver handler
      observer.observe element, 
        attributes: true
        attributeFilter: attributes
      queue

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

  reflect: ( attributes, element ) ->
    for key, value of ( Obj.collapse delimiter: "-", attributes )
      element.setAttribute key, value

export default DOM