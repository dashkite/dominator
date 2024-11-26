import assert from "@dashkite/assert"
import {test, success} from "@dashkite/amen"
import print from "@dashkite/amen-console"

# import DataURL from "../src/data-url"

do ->

  print await test "Dominator", [

    # test "DataURL", ->
    #   console.log DataURL.encode "Hello, world!"


  ]

  process.exit if success then 0 else 1
