import flow from 'lodash.flow'
import {set, get} from './state.js'

let subscribers = []

export function subscribe (cb) {
  subscribers.push(cb)
}

export function dispatch (...fns) {
  let prevState = get()
  let newState = set(flow(...fns)(prevState))
  if (newState !== prevState) {
    console.log(newState)
    subscribers.forEach((f) => f(newState))
  }
}
