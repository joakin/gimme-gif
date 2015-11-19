import React from 'react'
import { render } from 'react-dom'

import createApp from './create-app-div.js'
import {get as getState} from './state.js'
import {subscribe} from './dispatch.js'
import App from './ui/app.js'
import {fetchGif} from './actions.js'

let appDom = createApp('app')

function renderApp (state) {
  setTimeout(() => {
    render(<App onInput={fetchGif} {...state} />, appDom)
  }, 0)
}

// Render the app when state changes
subscribe(renderApp)

// Initial render
renderApp(getState())
