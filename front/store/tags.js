export const state = () => ({
  tag: {},
  posts: []
})

export const getters = {
  tag: state => state.tag,
  posts: state => state.posts
}

export const mutations = {
  setTag (state, tag) {
    state.tag = tag
  },

  setPosts (state, posts) {
    state.posts = posts
  }
}
