export const state = () => ({
  message: '',
  color: '',
  status: false
})

export const getters = {
  message: state => state.message,
  color: state => state.color,
  status: state => state.status
}

export const mutations = {
  setMessage (state, message) {
    state.message = message
  },
  setColor (state, color) {
    state.color = color
  },
  setStatus (state, status) {
    state.status = status
  }
}

export const actions = {
  showMessage ({ commit }, { message, color, status }) {
    commit('setMessage', message)
    commit('setColor', color)
    commit('setStatus', status)
    setTimeout(() => {
      commit('setStatus', !status)
    }, 2000)
  }
}
