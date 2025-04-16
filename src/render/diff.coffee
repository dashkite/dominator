import * as Arr from "@dashkite/joy/array"

Similarity =
  threshold: 5
  best: ( future, candidates ) ->
    do ({ diff, winner, min, candidate, score } = {}) ->
      winner = undefined
      min = Similarity.threshold
      for candidate in candidates
        if ( future.isEqualNode candidate )
          winner = candidate
          break
        else if ( future.tagName == candidate.tagName )
          score = ( Diff.attributes candidate, future ).length
          if score < min
            winner = candidate
            min = score
      winner

Patch =

  text: ( node, text ) ->
    name: "text"
    specificer: { node, text }
    apply: -> node.textContent = text

  attribute: ( node, name, value ) -> 
    name: "attribute"
    specifier: { node, name, value }
    apply: -> node.setAttribute name, value
    
  add: ( node, previous, parent ) -> 
    name: "add"
    specifier: { node, previous, parent }
    apply: ->
      if previous?
        if !( previous.nextSibling == node )
          previous.after node
      else
        if !( parent.firstChild == node )
          parent.prepend node

  remove: ( node ) -> 
    name: "remove"
    specifier: { node }
    apply: -> node.remove()

Diff =

  text: ( current, future ) ->
    changed = ( current.nodeType == 3 ) && 
      ( future.nodeType == 3 ) &&
      ( current.textContent != future.textContent )
    if changed
      [ Patch.text current, future.textContent ]
    else []

  attributes: ( current, future ) ->
    patches = []
    if current.attributes? && future.attributes?
      for { name, value } from future.attributes
        changed = ( current.hasAttribute name ) && 
          (( current.getAttribute name ) != value )
        if changed 
          patches.push Patch.attribute current, name, value
    patches

  nodes: ( current, future ) ->
    [
      ( Diff.text current, future )...
      ( Diff.attributes current, future )...
      ( Diff.trees current, future )...
    ]

  trees: ( current, future ) ->
    patches = []
    cx = Array.from current.childNodes
    fx = if Array.isArray future
      future
    else 
      Array.from future.childNodes
    p = undefined
    for f in fx
      if ( c = Similarity.best f, cx )?
        patches = [ patches..., ( Diff.nodes c, f )... ]
        patches.push Patch.add c, p, current
        p = c
        Arr.remove c, cx
      else
        patches.push Patch.add f, p, current
        p = f
    for c in cx
      patches.push Patch.remove c
    patches

diff = Diff.trees

patch = ( patches ) ->
  do ({ patch } = {}) ->
    for patch in patches
      patch.apply()

export { patch, diff }