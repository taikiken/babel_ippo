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
# dev
# sourcemap, dest: tmp
gulp.task 'css:dev', ->
  return gulp.src files.css
  .pipe $.changed app + '/**', extension: '.css'
  .pipe $.sass(
    precision: 10
    sourceMap: true
    sourceComments: true
  ).on 'error', $.sass.logError
  .pipe $.autoprefixer browsers: AUTO_PREFIX_BROWSERS
  .pipe gulp.dest tmp
  .pipe $.if config.css.dev, gulp.dest htdocs
  .pipe $.size title: '*** css:dev ***'

# build
gulp.task 'css:build', ->
  return gulp.src files.css
  .pipe $.plumber()
  .pipe $.sass( precision: 10 ).on 'error', $.sass.logError
  .pipe $.autoprefixer browsers: AUTO_PREFIX_BROWSERS
  .pipe $.replaceTask patterns: patterns
  .pipe $.if '*.css' && config.css.min, $.cssnano()
  .pipe gulp.dest tmp
  .pipe gulp.dest htdocs
  .pipe $.size title: '*** css:build ***'