import React from 'react'
import createApp from './create-app-div.js'
import App from './ui/app.js'
import api from './api.js'

let app = createApp('app')

function render (gif) {
  React.render(
    <App
      onInput={(tag) => api(tag).then(render)}
      gif={gif}
    />,
    app
  )
}

render(null)
