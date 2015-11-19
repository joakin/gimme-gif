import React from 'react'
import Error from './error.js'
import ImageLoader from 'react-imageloader'
import Loader from './loader.js'

import './gif.less'

export default (gif) => (
  gif.data.image_url
  ? <div className='Gif'>
      <input type='text' readOnly value={gif.data.image_url}/>
      <ImageLoader
        src={gif.data.image_url}
        wrapper={React.DOM.div}
        preloader={() => <Loader /> }>
        Image load failed!
      </ImageLoader>
    </div>
  : <Error message='No gif found with that search!'/>
)
