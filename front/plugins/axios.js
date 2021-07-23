import axios from 'axios'

export default axios.create({
  baseURL: process.env.baseUrl
})

// TODO: page>user>_id.vueでヘッダーをセットしているので、どのリクエストでもセットするように改善

// const Cookie = process.client ? require('js-cookie') : undefined

// axios.interceptors.request.use( config => {
//   console.log(confitg)
//   config.headers.common['access-token'] = Cookie.get('access-token')
//   config.headers.common['client'] = Cookie.get('client')
//   config.headers.common['uid'] = Cookie.get('uid')
//   return config
// })