/* jshint esversion: 6 */

const HtmlWebpackPlugin = require('html-webpack-plugin')
const webpack = require('webpack')
const path = require('path')

module.exports = {
  entry: {
    app: './src/app.js'
  },
  output: {
    path: path.resolve(__dirname, 'build'),
    filename: './[name].bundle.js'
  },
  devServer: {
    contentBase: path.join(__dirname, 'build'),
    hot: true,
    openPage: '',
    // port: 9000,
    open: true,
    stats: 'errors-only'
  },
  module: {
    rules: [
      {
        test: /\html$/,
        use: ['html-loader']
      },
      {
        test: /\jsx?$/,
        exclude: /node_modules/,
        use: [
          'babel-loader'
        ]
      }
    ]
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: './src/index.html',
      hash: true
    }),
    new webpack.HotModuleReplacementPlugin(),
    new webpack.NamedModulesPlugin()
  ]
}
