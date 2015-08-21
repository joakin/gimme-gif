import React from 'react'

import './input.less'

const Input = React.createClass({
  displayName: 'Input',
  render () {
    return (
      <form className='Input' onSubmit={this.submit}>
        <input type='text' placeholder='search for gifs related to...' />
      </form>
    )
  },
  submit (e) {
    e.preventDefault()
    let text = e.target.querySelector('input').value
    this.props.onSubmit(text)
  }
})
export default Input
