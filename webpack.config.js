var path = require('path')
var webpack = require('webpack')
var merge = require('webpack-merge')
var HtmlWebpackPlugin = require('html-webpack-plugin')
var autoprefixer = require('autoprefixer')
var ExtractTextPlugin = require('extract-text-webpack-plugin')
var OfflinePlugin = require('offline-plugin')

console.log('WEBPACK GO!')

// detemine build env
var TARGET_ENV = process.env.npm_lifecycle_event === 'build' ? 'production' : 'development'

// common webpack config
var commonConfig = {
  output: {
    path: path.resolve(__dirname, 'dist/'),
    filename: '[hash].js'
  },

  resolve: {
    modulesDirectories: ['node_modules'],
    extensions: ['', '.js', '.elm']
  },

  module: {
    noParse: /\.elm$/
  },

  plugins: [
    new HtmlWebpackPlugin({
      template: 'src/index.html',
      inject: 'body',
      filename: 'index.html'
    }),

    new webpack.DefinePlugin({
      'process.env': {
        'NODE_ENV': `"${process.env.NODE_ENV}"`
      }
    })
  ],

  postcss: [ autoprefixer({ browsers: ['last 2 versions'] }) ]

}

// additional webpack settings for local env (when invoked by 'npm start')
if (TARGET_ENV === 'development') {
  console.log('Serving locally...')

  module.exports = merge(commonConfig, {
    entry: [
      'webpack-dev-server/client?http://localhost:3006',
      path.join(__dirname, 'src/index.js')
    ],

    devServer: {
      inline: true,
      progress: true,
      port: 3006
    },

    module: {
      loaders: [
        {
          test: /\.elm$/,
          exclude: [/elm-stuff/, /node_modules/],
          loader: 'elm-webpack?verbose=true&warn=true'
        },
        {
          test: /\.(css|less)$/,
          loaders: [
            'style-loader',
            'css-loader',
            'postcss-loader',
            'less-loader'
          ]
        }
      ]
    }

  })
}

// additional webpack settings for prod env (when invoked via 'npm run build')
if (TARGET_ENV === 'production') {
  console.log('Building for prod...')

  module.exports = merge(commonConfig, {
    entry: path.join(__dirname, 'src/index.js'),

    module: {
      loaders: [
        {
          test: /\.elm$/,
          exclude: [/elm-stuff/, /node_modules/],
          loader: 'elm-webpack'
        },
        {
          test: /\.(css|less)$/,
          loader: ExtractTextPlugin.extract('style-loader', [
            'css-loader',
            'postcss-loader',
            'less-loader'
          ])
        }
      ]
    },

    plugins: [
      new webpack.optimize.OccurenceOrderPlugin(),

      // extract CSS into a separate file
      new ExtractTextPlugin('./[hash].css', { allChunks: true }),

      new OfflinePlugin({
        caches: {
          main: [
            'manifest.json',
            'favicon.ico',
            ':rest:'
          ]
        },
        externals: [
          'manifest.json',
          'favicon.ico'
        ]
      }),

      // minify & mangle JS/CSS
      new webpack.optimize.UglifyJsPlugin({
        minimize: true,
        compressor: { warnings: false }
      // mangle:  true
      })
    ]

  })
}
