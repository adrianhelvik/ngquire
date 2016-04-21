callsites = require 'callsites'
fs = require 'fs'
path = require 'path'

module.exports = (id) ->

    # Determine path

    filePath = null

    if id.charAt(0) in ['.', '/']
        stack = callsites()
        callee = stack[1].getFileName()
        callee = callee.split('/')
        callee.pop()
        callee = callee.join '/'

        filePath = path.resolve callee, id
    else
        filePath = id

    # Mock angular

    oldAngular = global.angular

    info = {}

    create = (type) ->
        (name, value) ->
            info.type = 'controller'
            info.name = name
            info.value = value

    global.angular =
        module: (name) ->
            info.module = name
            return global.angular
        controller: create 'controller'
        service: create 'service'
        value: create 'value'
        constant: create 'constant'
        factory: create 'factory'
        provider: create 'provider'

    # Retrieve values

    require filePath

    # Revert angular

    global.angular = oldAngular

    if global.angular is undefined
        delete global.angular

    return info

