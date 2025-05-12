# TODO does this belong in Bake?
# TODO possibly related to reflect (for complex attributes)
# TODO support for images (most common use case)

DataURL =

  encode: ( value ) ->
    "data:application/json;base64," + btoa JSON.stringify ( value ? null )
    
  decode: ( url ) ->
    if url?
      [ scheme, rest ] = url.split ":"
      if scheme == "data"
        [ type, content ] = rest.split ","
        JSON.parse atob content
      else throw new Error "DataURL: not a data URL"

export { DataURL }
export default DataURL