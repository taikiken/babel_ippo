module.exports =
  entry: __dirname

  output:
    path: 'dev/app/assets/js/bundle'
    publicPath: 'assets/js/bundle'
    filename: '[name].bundle.js'
    chunkFilename: '[chunkhash].bundle.js'