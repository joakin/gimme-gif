import React from 'react'
import Error from './error.js'

import './gif.less'

export default (gif) => (
  gif.data.image_url
  ? <div className='Gif'>
      <input type='text' readOnly value={gif.data.image_url}/>
      <img key={gif.data.image_url} src={gif.data.image_url} />
    </div>
  : <Error message='No gif found with that search!'/>
)
