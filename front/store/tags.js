export const state = () => ({
  tag: {},
  posts: [],
  events: []
})

export const getters = {
  tag: state => state.tag,
  posts: state => state.posts,
  events: state => state.events
}

export const mutations = {
  setTag (state, tag) {
    state.tag = tag
  },

  setPosts (state, posts) {
    state.posts = posts
  },

  setEvents (state, events) {
    state.events = events
  }
}
