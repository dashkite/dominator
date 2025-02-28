# TODO this does not handle form inputs that have multiple values

form = ( root ) ->
  if ( element = root.querySelector "form" )?
    Object.fromEntries ( new FormData element )
  else {}

reset = ( root ) ->
  root.querySelector( "form" ).reset()

export { form, reset }