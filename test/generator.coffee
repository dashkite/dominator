generator = -> yield i for i in [1..1e5]

run = -> console.log i for i from generator()

# queueMicrotask ->
#   console.log "HAHAHAHA!"

# setTimeout (-> console.log "HAHAHAHA!"), 0

do ->
  await true
  console.log "HAHAHAHA!"

run()

