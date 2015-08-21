import React from 'react'

import './gif.less'

const Gif = React.createClass({
  displayName: 'Gif',
  render () {
    let gif = this.props.gif
    return (
      <div className='Gif'>
        <input type='text' readOnly value={gif.data.image_url}/>
        <img key={gif.data.image_url} src={gif.data.image_url} />
      </div>
    )
  }
})
export default Gif
