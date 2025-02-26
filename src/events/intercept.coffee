# return event instead of boolean to allow composition
stop = ( event ) -> event.stopPropagation() ; event

# return event instead of boolean to allow composition
prevent = ( event ) -> event.preventDefault() ; event

intercept = ( event ) ->
  event.stopPropagation()
  event.preventDefault()
  event

export {
  stop
  prevent
  intercept
}