import { innerHTML as diff } from "diffhtml"
import * as Fn from "@dashkite/joy/function"
import Generic from "@dashkite/generic"
import { $ } from "./select"

append = Fn.curry Fn.binary do ->
  
  ( Generic.make "DOM.append" )

    .define [ Element, String ], ( target, html ) ->
      target.insertAdjacentHTML "beforeend", html
      target.lastElementChild

    .define [ Element, Element ], ( target, element ) ->
      target.append element
      target.lastElementChild
    
    .define [ Element, Array ], ( target, elements ) ->
      target.append elements...
      target.lastElementChild

prepend = Fn.curry Fn.binary do ->

  ( Generic.make "DOM.prepend" )
  
    .define [ Element, String ], ( target, html ) ->
      target.insertAdjacentHTML "afterbegin", html
      target.firstElementChild

    .define [ Element, Element ], ( target, element ) ->
      target.prepend element
      target.firstElementChild

    .define [ Element, Array ], ( target, elements ) ->
      target.prepend elements...
      target.firstElementChild

render = Fn.curry Fn.binary do ->

  ( Generic.make "DOM.render" )
  
    .define [ String, String ], ( selector, html ) ->
      if ( target = $ selector )?
        render target, html

    .define [ Element, String ], ( target, html ) ->
      await diff target, html
      target

    .define [ Element, Element ], ( target, element ) ->
      target.replaceChildren element
      target

    .define [ Element, Array ], ( target, [ rest..., last ] ) ->
      target.replaceChildren elements..., last
      target
      
    # TODO need to test if this works
    #      should we add add'l checks?
    .define [ Element, Object ], ( target, vdom ) ->
      await diff target, vdom
      target

export {
  append
  prepend
  render
}
