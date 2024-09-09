Attributes =

  reducer: ( result, { name, value }) ->
    result[ name ] = value
    result

DOM =

  attributes: ( el ) ->
    Array
      .from el.attributes
      .reduce Attributes.reducer, {}

  closest: ( selector ) -> ( el ) -> el.closest selector

  target: ( el ) -> el.target

  nextSibling: ( el ) -> el.nextSibling

  click: ( el ) -> do el.click

export default DOM