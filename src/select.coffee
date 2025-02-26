import * as Fn from "@dashkite/joy/function"

# TODO convert to arrays?
select = ( selector, element = document ) ->
  element.querySelect selector

selectAll = ( selector, element = document ) ->
  element.querySelectAll selector

$ = select
$$ = selectAll

export { 
  select
  selectAll
  $
  $$
  closest 
}