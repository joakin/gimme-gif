import React from 'react'

import './input.less'

const submit = (onSubmit) => (e) => {
  e.preventDefault()
  onSubmit(e.target.querySelector('input').value)
}

export default ({loading, onSubmit}) => (
  <form className='Input' onSubmit={submit(onSubmit)}>
    <input type='text' placeholder='search for gifs related to...' />
  </form>
)
