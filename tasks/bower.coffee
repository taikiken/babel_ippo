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
components = dir.dev.bower.components
exports = dir.dev.bower.exports

# bxSlider 4
gulp.task 'bower:bxslider4', ->
  return gulp
  .src [
    components + '/bxslider4/dist/*.min.*'
    components + '/bxslider4/dist/**/images/*'
    components + '/bxslider4/dist/**/vendor/*'
  ]
  .pipe gulp.dest exports + '/bxslider4'
  .pipe $.size title: '*** bower:bxslider4 ***'

# bxSlider 3
gulp.task 'bower:bxslider3', ->
  return gulp
  .src [
    components + '/bxslider3/*.js'
    '!' + components + '/bxslider3/source/*'
    components + '/bxslider3/**/bx_styles/*'
  ]
  .pipe gulp.dest exports + '/bxslider3'
  .pipe $.size title: '*** bower:bxslider3 ***'

# fancybox
gulp.task 'bower:fancybox', ->
  return gulp
  .src [
    components + '/fancybox/source/*.pack.js'
    components + '/fancybox/source/*.{gif,png,css}'
    components + '/fancybox/source/**/helpers/*'
  ]
  .pipe gulp.dest exports + '/fancybox'
  .pipe $.size title: '*** bower:fancybox ***'

# sagen
gulp.task 'bower:sagen', ->
  return gulp
  .src [
    components + '/sagen.js/libs/*.min.js'
  ]
  .pipe gulp.dest exports + '/sagen'
  .pipe $.size title: '*** bower:sagen ***'

# html5shiv
gulp.task 'bower:html5shiv', ->
  return gulp
  .src [
    components + '/html5shiv/dist/*.min.js'
  ]
  .pipe gulp.dest exports + '/html5shiv'
  .pipe $.size title: '*** bower:html5shiv ***'

# foundation
gulp.task 'bower:foundation', ->
  return gulp
  .src [
    components + '/foundation/**/js/foundation/foundation*.js'
    components + '/foundation/**/scss/foundation/components/*.scss'
  ]
  .pipe gulp.dest exports + '/foundation'
  .pipe $.size title: '*** bower:foundation ***'

# jquery1
gulp.task 'bower:jquery1', ->
  return gulp
  .src [
    components + '/jquery1/dist/*.min.*'
  ]
  .pipe gulp.dest exports + '/jquery1'
  .pipe $.size title: '*** bower:jquery1 ***'

# jquery2
gulp.task 'bower:jquery2', ->
  return gulp
  .src [
    components + '/jquery2/dist/*.min.*'
  ]
  .pipe gulp.dest exports + '/jquery2'
  .pipe $.size title: '*** bower:jquery2 ***'

# jquery-migrate
gulp.task 'bower:jquery-migrate', ->
  return gulp
  .src [
    components + '/jquery-migrate/**/*.min.js'
  ]
  .pipe gulp.dest exports + '/jquery-migrate'
  .pipe $.size title: '*** bower:jquery-migrate ***'

# jquery-ui
gulp.task 'bower:jquery-ui', ->
  return gulp
  .src [
    components + '/jquery-ui/jquery-ui.min.js'
  ]
  .pipe gulp.dest exports + '/jquery-ui'
  .pipe $.size title: '*** bower:jquery-ui ***'

# jquery.smooth-scroll
gulp.task 'bower:jquery.smooth-scroll', ->
  return gulp
  .src [
    components + '/jquery.smooth-scroll/*.min.js'
  ]
  .pipe gulp.dest exports + '/jquery.smooth-scroll'
  .pipe $.size title: '*** bower:jquery.smooth-scroll ***'

# inazumatv
gulp.task 'bower:inazumatv', ->
  return gulp
  .src [
    components + '/inazumatv.util.js/libs/*.min.js'
  ]
  .pipe gulp.dest exports + '/inazumatv'
  .pipe $.size title: '*** bower:inazumatv ***'

# sass-mediaqueries
gulp.task 'bower:sass-mediaqueries', ->
  return gulp
  .src [
    components + '/sass-mediaqueries/*.scss'
  ]
  .pipe gulp.dest exports + '/sass-mediaqueries'
  .pipe $.size title: '*** bower:sass-mediaqueries ***'

# modularized
gulp.task 'bower:modularized', ->
  return gulp
  .src [
    components + '/modularized-normalize-scss/*.scss'
    components + '/modularized-normalize-scss/**/base/*.scss'
    components + '/modularized-normalize-scss/**/embed/*.scss'
    components + '/modularized-normalize-scss/**/forms/*.scss'
    components + '/modularized-normalize-scss/**/grouping/*.scss'
    components + '/modularized-normalize-scss/**/html5/*.scss'
    components + '/modularized-normalize-scss/**/links/*.scss'
    components + '/modularized-normalize-scss/**/tables/*.scss'
    components + '/modularized-normalize-scss/**/text-level/*.scss'
  ]
  .pipe gulp.dest exports + '/modularized'
  .pipe $.size title: '*** bower:modularized ***'

# heightLine
gulp.task 'bower:heightLine', ->
  return gulp
  .src [
    components + '/heightLine/*.js'
  ]
  .pipe gulp.dest exports + '/heightLine'
  .pipe $.size title: '*** bower:heightLine ***'

# matchHeight
gulp.task 'bower:matchHeight', ->
  return gulp
  .src [
    components + '/matchHeight/**/*-min.js'
  ]
  .pipe gulp.dest exports + '/matchHeight'
  .pipe $.size title: '*** bower:matchHeight ***'

# --------------------------------------------

# bower
gulp.task 'bower:exports', (cb) ->
  runSequence(
    [
      'bower:bxslider4'
      'bower:bxslider3'
      'bower:fancybox'
      'bower:sagen'
      'bower:html5shiv'
      'bower:foundation'
      'bower:jquery1'
      'bower:jquery2'
      'bower:jquery-migrate'
      'bower:jquery-ui'
      'bower:jquery.smooth-scroll'
      'bower:inazumatv'
      'bower:sass-mediaqueries'
      'bower:modularized'
      'bower:heightLine'
      'bower:matchHeight'
    ]
    cb
  )
  return


