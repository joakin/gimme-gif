import React from 'react'
import Input from './input.js'
import Gif from './gif.js'

import './app.less'

const App = React.createClass({
  displayName: 'App',
  render () {
    return (
      <div className='App'>
        <h1>Gimme a gif</h1>
        <Input onSubmit={this.props.onInput} />
        {(this.props.gif ?  <Gif gif={this.props.gif} /> : null)}
        <p className='giphy'>
          Powered by <a href='http://giphy.com'>giphy.com</a>
        </p>
      </div>
    )
  }
})
export default App
