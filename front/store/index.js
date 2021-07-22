import axios from 'axios'
import Cookies from 'universal-cookie'
import isAuthenticated from '../middleware/isAuthenticated'

export const state = () => {
  return {
    access_token: '',
    uid: '',
    client: '',
    id: '',
    isAuthenticated: false
  }
}

export const mutations = {
  setUser (state, res) {
    state.access_token = res.headers['access-token']
    state.uid = res.headers['uid']
    state.client = res.headers['client']
    state.id = res.data.data.id
    state.isAuthenticated = true
  },
  setHeader (state, headers) {
    state.access_token = headers['access-token']
    state.uid = headers['uid']
    state.client = headers['client']
    state.isAuthenticated = true
  },
  logoutUser (state) {
    state.access_token = null;
    state.isAuthenticated = null;
    state.uid = null;
    state.client = null;
    state.id = null;
  }
}

export const actions = {
  async login ({ commit }, { email, password }) {
    try {
      await axios.post('http://localhost:3000/api/v1/auth/sign_in', { email, password }
      ).then(res => {
          // console.log(res)
          // console.log(res.data.data.uid)
          commit('setUser', res)
      })
    } catch (error) {
      if (error.response && error.response.status === 401) {
        throw new Error('Bad credentials')
      }
      throw error
    }
  },
  async logout ({ commit }, { access_token, client, uid }) {
    try {
      await axios.delete('http://localhost:3000/api/v1/auth/sign_out', {
        headers: {
          'access-token': access_token,
          client: client,
          uid: uid
        }
      })
      commit('logoutUser')
    } catch (error) {
      if (error.response && error.response.status === 401) {
        throw new Error('Bad credentials')
      }
      throw error
    } 
  },
  nuxtServerInit ({ commit }, { req }) {
    if (req.headers.cookie) {
      try {
        const { cookies } = new Cookies(req.headers.cookie)
        commit('setHeader', { headers: cookies })
      } catch (err) {
        // No valid cookie found
      }
    }
  }

}