import React from 'react'
import Input from './input.js'
import Gif from './gif.js'
import Error from './error.js'
import Loader from './loader.js'

import './app.less'

export default ({gif, loading, error, onInput}) => (
  <div className='App'>
    <h1>Gimme a gif 👊</h1>
    <Input onSubmit={onInput} loading={loading} />
    {loading ? <Loader /> : null}
    {error ? <Error {...error} /> : null}
    {gif ? <Gif {...gif} /> : null}
    <p className='giphy'>
      Powered by <a href='http://giphy.com'>giphy.com</a>
    </p>
  </div>
)
