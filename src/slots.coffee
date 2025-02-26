slots = ( element ) ->
  result = {}
  for element from element.querySelectorAll "[slot]"
    result[ element.slot ] = element
  result

export { slots }