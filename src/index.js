require('./main.less')

if (process.env.NODE_ENV === 'production') {
  // Enable offline support with appcache / sw
  require('offline-plugin/runtime').install()
}

var Elm = require( './Main' )
Elm.Main.embed(document.getElementById( 'main' ))
