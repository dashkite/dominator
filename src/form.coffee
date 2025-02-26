# TODO this does not handle form inputs that have multiple values

form = ( root ) ->
  if ( form = root.querySelector "form" )?
    Object.fromEntries ( new FormData form )
  else {}

reset = ( root ) ->
  root.querySelector( "form" ).reset()

export { form, reset }