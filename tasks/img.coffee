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

# copy
# 圧縮せずコピーします, 開発時に watch task と併用し使用します
gulp.task 'image:copy', ->
  return gulp.src files.img
  .pipe gulp.dest htdocs
  .pipe $.size title: '*** image:copy ***'

# dev
# 随時圧縮します, ファイル数が多くなると非効率になることもあります
gulp.task 'image:dev', ->
  return gulp.src files.img
  .pipe $.cache $.imagemin config.img
  .pipe gulp.dest htdocs
  .pipe $.size title: '*** image:dev ***'

# build
gulp.task 'image:build', ->
  return gulp.src files.img
  .pipe $.imagemin config.img
  .pipe gulp.dest htdocs
  .pipe $.size title: '*** image:build ***'

