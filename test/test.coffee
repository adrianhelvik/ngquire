assert = require 'assert'
ngquire = require '../src/index'

ctrl = ngquire './sample.controller'

assert typeof(ctrl.value) is 'function'
assert ctrl.type is 'controller'
assert ctrl.name is 'sampleCtrl'
assert ctrl.module is 'myApp'
