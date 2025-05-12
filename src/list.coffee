import * as DOM from "./index"

class List

  @make: do ->

    Generic.make "DOM.List"
      
      .define [ Type.isIterable  ], ( it ) ->
        Object.assign ( new @ ), { it }

      .define [ Type.isGenerator ], ( g ) -> @make g()

  [ Symbol.iterator ]: -> @it

  map: ( f ) ->
    it = @it 
    @constructor.make -> 
      for e from it
        yield f e
      return

  next: -> @map ( el ) -> el.nextSibling

  modify: -> DOM.modify @


$ = do ->

  ( Generic.make "$" )

    .define [ String ], ( selector ) ->
      List.make selectorAll selector

    .define [ String, Node ], ( selector, root ) ->
      List.make selectorAll selector, root

    .define [ List ], Fn.identity

    .define [ Node ], ( node ) -> List.make [ node ]

    .define [ NodeList ], ( list ) -> List.make list

export { $ }
