import * as Fn from "@dashkite/joy/function"
import * as Time from "@dashkite/joy/time"
import Generic from "@dashkite/generic"
import { $ } from "../select"
import { diff, patch } from "./diff"

Log =
  duration: ({ duration }) ->
    console.log "%cdominator: 
      DOM updated in
      #{ duration.toFixed 3 }ms",
      "color: cyan;"

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
      target.innerHTML = html
      target

    .define [ Element, Element ], ( target, element ) ->
      target.replaceChildren element
      target

    .define [ Element, Array ], ( target, elements ) ->
      target.replaceChildren elements...
      target
      
morph = Fn.curry Fn.binary do ->

  ( Generic.make "DOM.morph" )
  
    .define [ Node, Node ], ( target, node ) ->
      Log.duration Time.measure "DOM.morph", ->
        patch diff target, [ node ]
      
    .define [ Node, Array ], ( target, nodes ) ->
      Log.duration Time.measure "DOM.morph", ->
        patch diff target, nodes

    .define [( -> true ), String ], ( target, source ) ->
      morph target,
        Document
          .parseHTMLUnsafe source
          .body

    .define [ String, ( -> true ) ], ( target, html ) ->
        if ( target = $ target )?
          morph target, html

export {
  append
  prepend
  render
  morph
}
