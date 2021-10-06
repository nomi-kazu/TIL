export const state = () => ({
  user: {},
  followings: [],
  followers: [],
  level: 1
})

export const getters = {
  user: state => state.user,
  followings: state => state.followings,
  followers: state => state.followers,
  level: state => state.level
}

export const mutations = {
  setUser (state, user) {
    state.user = user
  },

  setFollowings (state, followings) {
    state.followings = followings
  },

  setFollowers (state, followers) {
    state.followers = followers
  },

  setLevel (state, level) {
    state.user.level = level
  }
}
