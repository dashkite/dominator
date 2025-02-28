# TODO overload to take iterator or element?
dispatch = ( name ) ->
  ( reactor ) ->
    # start the reactor but don't await on it
    do ->
      for await { element } from reactor
        element.dispatchEvent new CustomEvent name,
          detail: element 
          bubbles: true
          cancelable: false
          composed: true
    return

export { dispatch }