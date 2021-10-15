export const state = () => ({
  tag: {},
  users: [],
  posts: []
})

export const getters = {
  tag: state => state.tag,
  users: state => state.users,
  posts: state => state.posts
}

export const mutations = {
  setTag (state, tag) {
    state.tag = tag
  },
  setUsers (state, users) {
    state.users = users
  },
  setPosts (state, posts) {
    state.posts = posts
  }
}
