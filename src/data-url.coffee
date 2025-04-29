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