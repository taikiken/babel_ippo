###
  @author (at)taikiken / http://inazumatv.com
  Copyright (c) 2011-2015 inazumatv.com

  Licensed under the Apache License, Version 2.0 (the "License");
  https://www.apache.org/licenses/LICENSE-2.0
###

setting = require '../setting'

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
app = dir.app.root
tmp = dir.dev.tmp
scss = dir.dev.scss
scripts = dir.dev.scripts
htdocs = dir.htdocs

# files
files = setting.files

# --------------------------------------------
# task
# --------------------------------------------

###
  scripts 配下で project 用 library 開発に使用します
  non Babel です。
###

# 依存ライブラリ
dependencies = files.scripts.dependencies || [];

# Project library files
sources = files.scripts.sources || [];

# script name
scriptsName = config.scripts.name || 'xxx-app.js'

# hint
gulp.task 'scripts:hint', ->
  return gulp.src sources
  .pipe $.jshint()
  .pipe $.jshint.reporter 'jshint-stylish'

# concat
gulp.task 'scripts:concat', ->
  merged = dependencies.concat sources

  return gulp.src merged
  .pipe $.concat scriptsName
  .pipe $.replaceTask patterns
  .pipe gulp.dest app.assets.libs
  .pipe $.size title: '*** scripts:concat ***'

# minify
gulp.task 'scripts:min', ->
  merged = dependencies.concat sources

  return gulp.src merged
  .pipe $.concat scriptsName
  .pipe $.uglify preserveComments: 'license'
  .pipe $.replaceTask patterns
# log は手動で削除が良いかと...
#  .pipe $.stripDebug()
  .pipe gulp.dest app.assets.libs
  .pipe $.size title: '*** scripts:min ***'

# ----------------------------------------------

# dev
gulp.task 'scripts:dev', (cb) ->
  runSequence(
    'scripts:hint'
    'scripts:concat'
    cb
  )
  return

# build
gulp.task 'scripts:build', (cb) ->
  runSequence(
#    'scripts:hint'
    'scripts:min'
    cb
  )
  return