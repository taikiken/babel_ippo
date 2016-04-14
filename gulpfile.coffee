###
  @author (at)taikiken / http://inazumatv.com
  Copyright (c) 2011-2015 inazumatv.com

  Licensed under the Apache License, Version 2.0 (the "License");
  https://www.apache.org/licenses/LICENSE-2.0
###

setting = require './setting'

# gulp / module
gulp = setting.gulp
# load plugins
$ = setting.$

# module
$$ = setting.plugins

del = $$.del
runSequence = $$.runSequence

# config
config = setting.config

# prefix
AUTO_PREFIX_BROWSERS = setting.AUTO_PREFIX_BROWSERS

# replace patterns
patterns = setting.patterns

# server
server = setting.server
port = server.port
browserSync = $$.browserSync
reload = $$.reload

# directory
dir = setting.dir
app = dir.app
tmp = dir.dev.tmp
scss = dir.dev.scss
scripts = dir.dev.scripts
htdocs = dir.htdocs

# --------------------------------------------
# 外部 task load
# --------------------------------------------

# Load custom tasks from the `tasks` directory
# 不要の時はコメントアウトしてください
# 基本 tasks読み込み
try
  require( 'require-dir' )( 'tasks' )
catch error
  console.warn '========================================================='
  console.warn '                      WARN'
  console.warn '[tasks] directory not found'
  console.warn error
  console.warn '========================================================='

# Load custom tasks from the `tasks-babel` directory
# 不要の時はコメントアウトしてください
# 基本 tasks-babel読み込み
try
  require( 'require-dir' )( 'tasks-babel' )
catch error
  console.warn '========================================================='
  console.warn '                      WARN'
  console.warn '[tasks-babel] directory not found'
  console.warn error
  console.warn '========================================================='
