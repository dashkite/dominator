import * as Fn from "@dashkite/joy/function"
import Generic from "@dashkite/generic"

# TODO convert to arrays?

select = do ->

  ( Generic.make "Dominator.select" )

    .define [ String ], ( selector ) ->
      document.querySelector selector

    .define [ String, Element ], ( selector, root ) ->
      root.querySelector selector

    .define [ Element ], Fn.identity

    .define [ Element, Element ], Fn.identity
  
selectAll = do ->

  ( Generic.make "Dominator.selectAll" )

    .define [ String ], ( selector ) ->
      document.querySelectorAll selector

    .define [ String, Element ], ( selector, root ) ->
      root.querySelectorAll selector

    .define [ Array, Element ], Fn.identity

$ = select
$$ = selectAll

export { 
  select
  selectAll
  $
  $$
}