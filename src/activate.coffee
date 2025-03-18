# TODO handle out of order events?
#
# We could use a reactor of sorts here to
# implement a state machine that ensures
# we never redundantly call activate.
#
# See also: experimental activate reactor
# in Sansa.


activate = do ({ intersects } = {}) ->

  intersects = ( event ) -> event.isIntersecting

  ( element, handler ) ->
    do ({ observer } = {}) ->
      observer = new IntersectionObserver ( events ) ->
        handler() if ( events.some intersects )  
      observer.observe element

deactivate = do ({ disjoint } = {}) ->

  disjoint = ( event ) -> 
    event.intersectionRatio <= 0

  ( element, handler ) ->
    do ({ observer } = {}) ->
      observer = new IntersectionObserver ( events ) ->
        handler() if ( events.some disjoint )     
      observer.observe element

export {
  activate
  deactivate
}