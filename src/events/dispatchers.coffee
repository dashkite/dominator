# TODO figure out right interface for this
#      we can't use ex: `click` because we
#      already use them to define listeners,
#      so we either need to overload them
#      or use a different function, ex:
#      generics by event type for when 
#      they're available directly as below

# click = ( element ) -> element.click()
# focus = ( element ) -> element.focus()

# export {
#   click
#   focus
# }