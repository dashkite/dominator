DataURL =

  encode: ( value ) ->
    # TODO add support for other media types
    # for now assume application/json;base64
    "data:application/json;base64," + btoa JSON.stringify ( value ? null )
    
  decode: ( url ) ->
    if url?
      [ scheme, rest ] = url.split ":"
      if scheme == "data"
        [ type, content ] = rest.split ","
        # TODO parse media type using media type module
        # for now assume application/json;base64
        JSON.parse atob content
      else throw new Error "DataURL: not a data URL"

export default DataURL