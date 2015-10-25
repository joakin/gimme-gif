var getConfig = require('hjs-webpack')

module.exports = getConfig({
  // entry point for the app
  in: 'browser/index.js',

  // Name or full path of output directory
  // commonly named `www` or `public`. This
  // is where your fully static site should
  // end up for simple deployment.
  out: 'public',

  // This will destroy and re-create your
  // `out` folder before building so you always
  // get a fresh folder. Usually you want this
  // but since it's destructive we make it
  // false by default
  clearBeforeBuild: true,

  // Autogenerate an index file
  html: function (context) {
    return {
      'index.html': addManifest(context.isDev, context.defaultTemplate({
        title: 'Gimme gif 👊',
        relative: true
      })),
      'cache.manifest': `
CACHE MANIFEST
# v1
${context.main}
${context.css}

# Use from network if available
NETWORK:
*
`
    }
  }
})

function addManifest (dev, html) {
  if (!dev) {
    var parts = html.match(/(\<\!doctype html\>)(.*)/)
    if (parts) {
      html = parts[1] + '<html manifest="cache.manifest">' + parts[2] + '</html>'
    } else {
      console.log(parts)
      throw new Error('Default template does not contain doctype')
    }
  }
  return html
}
