import assert from "@dashkite/assert"
import {test, success} from "@dashkite/amen"
import print from "@dashkite/amen-console"

import $ from "../src"

do ->

  print await test "Dominator", [

    test "modify", ->
      assert.equal Function,
        ( $.modify [ /^data-/ ] ).constructor

  ]

  process.exit if success then 0 else 1
