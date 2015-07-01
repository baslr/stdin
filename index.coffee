
nomnom   = require 'nomnom-alive'
readline = require 'readline'
rl = readline.createInterface process.stdin, process.stdout

rl.setPrompt '> '
rl.prompt()

cmds = {}

module.exports.on = (cmd) ->
 
  cmds[cmd] = parser:parser = nomnom()
  c   = cmds[cmd]
  c.p = c.parser
  c.p.printer (str, code) -> console.log str

  c.p = c.p.command.apply parser, arguments

  opt:  () ->
    c.p = c.p.option.apply parser,   arguments
    this
  opts:   () ->
    c.p = c.p.options.apply parser,  arguments
    this
  cb: (cb) ->
    c.p = c.p.callback (opts) ->
      opts._.shift()
      cb.apply this, arguments
    this


rl.on 'line', (line) ->
  line = line.trim()
  return rl.prompt() if line is ''


  for cmd,parser of cmds
    continue if 0 isnt line.search cmd
    try
      parser.parser.parse line.split(' ')

    rl.prompt()
    return

  console.log "dont know #{line}"
  rl.prompt()
