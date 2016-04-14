###
  @author (at)taikiken / http://inazumatv.com
  Copyright (c) 2011-2015 inazumatv.com

  Licensed under the Apache License, Version 2.0 (the "License");
  https://www.apache.org/licenses/LICENSE-2.0
###

# ------------------------------------------------------
# package
# ------------------------------------------------------
pkg = require './package.json'

# ------------------------------------------------------
# Node / Gulp module
# ------------------------------------------------------
# Include Gulp & tools we'll use
gulp = require 'gulp'
$ = do require 'gulp-load-plugins'

###
  gulp-load-plugins を使用した
  $.util.log が syntax error になるので...
###
$.util = require 'gulp-util'

###
  for babel module
###
webpack = require 'webpack'
webpackConfig = require './webpack.config'

# plugins
browserSync = require 'browser-sync'
reload = browserSync.reload

plugins =
  del: require 'del'
  sprity: require 'sprity'
  runSequence: require 'run-sequence'
  eventStream: require 'event-stream'
  fs: require 'fs'
  browserSync: browserSync
  reload: reload
  argv: require( 'yargs' ).argv
  webpack: webpack

# ------------------------------------------------------
# directory
# ------------------------------------------------------

# ------------------------
# 開発ディレクトリ

# dev root
root = 'dev'

# tmp
tmp = root + '/.tmp'

# scripts: project js library
scripts =
  root: root + '/scripts'

scripts.src = scripts.root + '/src'
scripts.dependencies = scripts.root + '/dependencies'

# babels: project babel library
babels =
  root: root + '/babels'

babels.src = babels.root + '/src'
babels.compile = babels.root + '/compile'

# scss 基本ライブラリ
scss = root + '/scss'

# bower
bower =
  root: root + '/bower'

bower.components = bower.root + '/bower_components'
bower.exports = root + '/bower_exports'

# dev directories
dev =
  root: root
  tmp: tmp
  scripts: scripts
  babels: babels
  scss: scss
  bower: bower

# ------------------------
# app 配置ディレクトリ

# app root
app =
  root: root + '/app'

# assets
app.assets =
  root: app.root + '/assets'

# assets/css
app.assets.css = app.assets.root + '/css'

# assets/js
app.assets.js = app.assets.root + '/js'
app.assets.libs = app.assets.js + '/libs'
app.assets.bundle = app.assets.js + '/bundle'

# assets/img
app.assets.img = app.assets.root + '/img'

# sprite
sprite =
  # 元画像 ディレクトリ
  root: root + '/sprite'
  # 展開 パス CSS
  css: app.assets.css
  # 展開 パス img
  img: app.assets.img + '/sprite'


# ------------------------
# 出力(deploy)ディレクトリ

htdocs = 'public'


# ------------------------------------------------------
# Sass prefix (Browser vendor prefix)
# ------------------------------------------------------
AUTO_PREFIX_BROWSERS = [
  'ie >= 11'
  'ie_mob >= 10'
  'ff >= 44'
  'chrome >= 48'
  'safari >= 9'
  'opera >= 34'
  'ios >= 8.4'
  'android >= 4.2'
  'bb >= 10'
]

# ------------------------------------------------------
# 設定
# ------------------------------------------------------
config = 
  css:
    # 開発時に CSS を htdocs へ出力するか？ true: 出力する
    dev: false
    # deploy(build) で minify するか？ true: minify
    min: false
    
  html:
    # deploy(build) で minify するか？ true: minify
    min: false
    
  img:
    optimizationLevel: 5
    # 圧縮効率は true の方が大きい
    progressive: false
    # 圧縮効率は true の方が大きい
    interlaced: false

  sprite:
    # output file name
    style: '_sprite.scss'
    # mixin name
    name: 'sprite'
    # image file prefix
    prefix: 'sprite'
    # css から 画像までのパス
    # root相対指定 `/assets/img/sprite`
    css: sprite.img.replace app.root, ''
    # binary-tree | vertical | horizontal
    orientation: 'binary-tree'
    # output style format
    processor: 'sprity-sass'

  # project library name
  scripts:
    name: pkg.name + '.app.js'
    
  # vendor concat name
  vendor:
    name: 'vendor-' + pkg.name + '.js'
  
# ------------------------------------------------------
# patterns for replace
# ------------------------------------------------------
patterns = [
  {
    match: 'buildTime'
    replacement: new Date().toLocaleString()
  }
  {
    match: 'year'
    replacement: new Date().getFullYear()
  }
  {
    match: 'version'
    replacement: pkg.version
  }
  {
    match: 'copyright'
    replacement: 'Parachute.bz'
  }
]

# ------------------------------------------------------
# server (browserSync)
# ------------------------------------------------------
###
  _port.coffee を port.coffee へ rename します
  port.coffee の port 値を環境に合わせ変更します
  port.coffee を .gitignore に加えます
###
try
  port = require './port'
catch error
  console.warn '========================================================='
  console.warn '                      WARN'
  console.warn 'please make port.coffee. instead use default port: 61000.'
  console.warn '========================================================='
  port = { port : 61000 }


###
  indexes

  browserSync, directory indexes を設定します
  * 【注意】directory index が無効になってしまうので default false にしてます
  ToDo: indexes を true にし directory indexes を再現する
  https://github.com/BrowserSync/browser-sync/issues/106
  https://www.browsersync.io/docs/options/
###
indexes = false

# ------------------------------------------------------
# files
# ------------------------------------------------------
# 対象フィアル設定
files = {}

# scss / css
files.css = [
  # library
  scss + '/**/*.scss'
  # project root .scss
  app.root + '/**/*.scss'
  # その他 min 済ファイル除外
  '!' + app.root + '/**/*.min.{css,scss}'
  '!' + app.root + '/**/*min.{css,scss}'
  '!' + app.root + '/**/*pack.{css,scss}'
  '!' + app.root + '/**/js/**/*.{css,scss}'
  '!' + app.root + '/**/*sprite*/**/*.{css,scss}'
]

files.html = [
  app.root + '/**/*.html'
  # test, template, tmp 除外
  '!' + app.root + '/**/*test*.html'
  '!' + app.root + '/**/*test*/*'
  '!' + app.root + '/**/*template*/*'
  '!' + app.root + '/**/*template*.html'
  '!' + app.root + '/**/*tmp*/*'
  '!' + app.root + '/**/*tmp*.html'
]

files.sprite = [
  sprite.root + '/**/*.*'
  # sprite directory
  '!' +  sprite.root + '/css/**/*.*'
]

files.img = [
  app.assets.img + '/**/*.{png,jpg,svg,gif}'
]

# 改行コード
files.lec = [
  htdocs + '/assets/**/*.{html,css,js,svg}'
]

# js, assets/js
files.js = [
  app.root + '/**/*.js'
  '!' + app.root + '/**/*tmp*.js'
  '!' + app.root + '/**/*.{min,app,pack,pkgd}.js'
  '!' + app.root + '/**/*-{min,app,pack}.js'
  '!' + app.root + '/**/*{min,app,pack}*.js'
  '!' + app.root + '/**/libs/**/*'
  '!' + app.root + '/**/*.bundle.js'
  '!' + app.root + '/**/_babel/**/*.js'
  '!' + app.root + '/**/*test*.js'
]

###
  scripts 使用 files
  scripts.coffee で定義可
###

files.scripts =
  # src
  sources: []
  # 依存ライブラリ
  dependencies: []

###
  vendor 使用 files
  vendor.coffee で定義可
###

files.vendor =
  # concat + minify
  sources: []
  # copy to libs
  libs: [
    bower.exports + '/**/jquery2/**/*.js'
    bower.exports + '/**/sagen/**/*.min.js'
    bower.exports + '/**/html5shiv/**/*'
  ]


# ------------------------------------------------------
# exports
# ------------------------------------------------------
module.exports =
  dir:
    dev: dev
    app: app
    htdocs: htdocs
    sprite: sprite

  files: files

  gulp: gulp
  $: $
  plugins: plugins

  webpack:
    config: webpackConfig

  server:
    port: port.port
    indexes: indexes

  AUTO_PREFIX_BROWSERS: AUTO_PREFIX_BROWSERS
  patterns: patterns

  config: config