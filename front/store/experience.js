export const state = () => ({
  experienceRecord: {},
  experience: {},
  requiredExp: {}
})

export const getters = {
  experienceRecord: state => state.experienceRecord,
  experience: state => state.experience,
  requiredExp: state => state.requiredExp
}

export const mutations = {
  setExperienceRecord (state, experienceRecord) {
    state.experienceRecord = experienceRecord
  },

  setExperience (state, experience) {
    state.experience = experience
  },

  setRequiredExp (state, requiredExp) {
    state.requiredExp = requiredExp
  }
}
