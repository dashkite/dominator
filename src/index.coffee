# TODO maybe generate from Node / Element properties and methods

Wrap =

  property: ( name ) -> ( el ) -> el[ name ]

  nullary: ( name ) -> ( el ) -> do el[ name ]

  unary: ( name ) -> ( a ) -> ( el ) -> el[ name ] a

  binary: ( name ) -> ( a, b ) -> ( el ) -> el[ name ] a, b

Attributes =

  reducer: ( result, { name, value }) ->
    result[ name ] = value
    result

DOM =

  attributes: ( el ) ->
    Array
      .from el.attributes
      .reduce reducer, {}

  closest: Wrap.unary "closet"

  target: Wrap.property "target"

export default DOM