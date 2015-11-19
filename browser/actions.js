import {dispatch} from './dispatch.js'
import {loading, newGif, error} from './state.js'
import api from './api.js'

export function fetchGif (tag) {
  dispatch(error(null), loading(true))
  api(tag)
    .then((gif) => dispatch(loading(false), newGif(gif)))
    .catch((e) => dispatch(loading(false), error(e)))
}
