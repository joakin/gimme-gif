import _ from 'whatwg-fetch'

function url (tag) {
  return `http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=${tag}&fmt=json`
}
export default function (tag) {
  return fetch(url(tag))
    .then((response) => response.json())
}
