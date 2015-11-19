import React from 'react'
import { render } from 'react-dom'
import createApp from './create-app-div.js'
import App from './ui/app.js'
import api from './api.js'

let appDom = createApp('app')

let appState = {
  gif: null,
  loading: false,
  error: { message: 'Ho ho ho' }
}

const stopLoading = (state) => ({...state, loading: false})
const newGif = (state, gif) => stopLoading({...state, gif, error: null})
const error = (state, e) => stopLoading({...state, error: e})

const fetchGif = (tag) =>
  api(tag).then((gif) => {
    appState = newGif(appState, gif)
    renderApp()
  }).catch((e) => {
    appState = error(appState, e)
    renderApp()
  })

function renderApp () {
  setTimeout(() => {
    console.log(appState)
    render(<App onInput={fetchGif} {...appState} />, appDom)
  }, 0)
}

renderApp(null)
