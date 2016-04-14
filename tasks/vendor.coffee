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

exports = dir.dev.bower.exports
vendorName = config.vendor.name || 'vendor.js'

# そのまま libs へ copy
# copy libraries

libs = files.vendor.libs || []

gulp.task 'vendor:libs', ->
  return gulp.src libs
  .pipe gulp.dest dir.app.assets.libs
  .pipe $.size title: '*** vendor:libs ***'


# concat + minify
sources = files.vendor.sources || []

###
  必要ファイルを push します
  Ex.
  sources.push exports + '/fancybox/*.js'
###

gulp.task 'vendor:deploy', ->
  return gulp.src sources
  .pipe $.concat vendorName
  .pipe $.uglify preserveComments: 'license'
  .pipe gulp.dest dir.app.assets.libs
  .pipe gulp.dest htdocs + '/assets/js/libs'
  .pipe $.size title: '*** vendor:build ***'

# --------------------------------------------
gulp.task 'vendor:build', ['vendor:libs', 'vendor:deploy'], ->
  return