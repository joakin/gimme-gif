export function createState (props) {
  return {
    gif: null,
    loading: false,
    error: null,
    ...props
  }
}

let state = createState()

const get = () => state
const set = (ns) => state = ns

const loading = (isLoading) => (s) => ({...s, loading: isLoading})
const newGif = (gif) => (s) => ({...s, gif, error: null})
const error = (e) => (s) => ({...s, error: e})

export {get, set, loading, newGif, error}
