export const state = () => ({
  experience: {},
  requiredExp: {}
})

export const getters = {
  experience: state => state.experience,
  requiredExp: state => state.requiredExp
}

export const mutations = {
  setExperience (state, experience) {
    state.experience = experience
    state.experience = {}
  },

  setRequiredExp (state, requiredExp) {
    state.requiredExp = requiredExp
    state.requiredExp = {}
  }
}
