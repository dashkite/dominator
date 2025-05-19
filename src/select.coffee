import * as Fn from "@dashkite/joy/function"
import Generic from "@dashkite/generic"

select = do ->

  ( Generic.make "Dominator.select" )

    .define [ String ], ( selector ) ->
      document.querySelector selector

    .define [ String, Node ], ( selector, root ) ->
      root.querySelector selector

selectAll = do ->

  ( Generic.make "Dominator.selectAll" )

    .define [ String ], ( selector ) ->
      document.querySelectorAll selector

    .define [ String, Node ], ( selector, root ) ->
      root.querySelectorAll selector

export { 
  select
  select as $
  selectAll
}