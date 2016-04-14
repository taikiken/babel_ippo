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
# build

gulp.task 'sprite:build', ->
# sprite directory が空の時走るとエラーになるので
# fs でファイルが存在するのかチェックする
  fs.readdir dir.sprite.root, (err, files) ->
    if err
      console.error err
    else
      if files.length > 0
        $$.sprity.src
          src: files.sprite
          style: config.sprite.style
          name: config.sprite.name
          cssPath: config.sprite.css
          processor: config.sprite.processor
          prefix: config.sprite.prefix
          orientation: config.sprite.orientation
          # sprity bug, 先頭の設定がおかしいので 0 にする
          margin: 0
          # ディレクトリ毎に別々のファイルになる
          split: true
        .pipe $.if( '*.png', gulp.dest( dir.sprite.img ), gulp.dest( dir.sprite.css ) )
        .pipe $.size title: '*** sprite:build ***'
      else
        console.warn '*** sprite *** no files and directories'

  return;