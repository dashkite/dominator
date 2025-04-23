import * as Fn from "@dashkite/joy/function"
import Generic from "@dashkite/generic"
import { $ } from "./select"

show = do ({ intersects } = {}) ->

  visible = ( event ) -> event.isIntersecting

  ( element, handler ) ->
    element = $ element
    do ({ observer } = {}) ->
      observer = new IntersectionObserver ( events ) ->
        handler() if ( events.some visible )  
      observer.observe element

hide = do ({ disjoint } = {}) ->

  invisible = ( event ) -> 
    event.intersectionRatio <= 0

  ( element, handler ) ->
    element = $ element
    do ({ observer } = {}) ->
      observer = new IntersectionObserver ( events ) ->
        handler() if ( events.some invisible )     
      observer.observe element

export {
  show
  hide
}