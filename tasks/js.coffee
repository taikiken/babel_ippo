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

# app/assets/js ディレクトリが対象


# jshint
# 圧縮済みファイルは除く
# .jshintrc 使用
gulp.task 'js:hint', ->
  return gulp.src files.js
#  .pipe $.debug 'file'
  .pipe $.jshint()
  .pipe $.jshint.reporter 'jshint-stylish'
  .pipe $.if !browserSync.active, $.jshint.reporter 'fail'

# uglify
gulp.task 'js:min', ->
  return gulp.src files.js
  .pipe $.replaceTask patterns: patterns
  .pipe $.stripDebug()
  .pipe $.uglify preserveComments: 'license'
  .pipe gulp.dest htdocs
  .pipe $.size title: '*** js:min ***'

# copy
gulp.task 'js:copy', ->
  return gulp.src files.js
  .pipe gulp.dest htdocs
  .pipe $.size title: '*** js:copy ***'

# --------------------------------------------

# dev
gulp.task 'js:dev', ( cb ) ->
  runSequence(
    'js:hint'
    'js:copy'
    cb
  )
  return

# build
gulp.task 'js:build', ( cb ) ->
  runSequence(
#    'js:hint'
    'js:min'
    cb
  )
  return

