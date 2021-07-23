const cookieparser = process.server ? require("cookieparser") : undefined;

export const state = () => ({
  access_token: null,
  uid: null,
  client: null,
  id: null,
  isAuthenticated: false,
});

export const getters = {
  access_token: (state) => state.access_token,
  client: (state) => state.client,
  uid: (state) => state.uid,
  id: (state) => state.id,
  isAuthenticated: (state) => state.isAuthenticated,
};

export const mutations = {
  clearUser(state) {
    state.access_token = null;
    state.uid = null;
    state.client = null;
    state.id = null;
    state.isAuthenticated = false;
  },

  setUser(state, res) {
    state.access_token = res.headers["access-token"];
    state.uid = res.headers["uid"];
    state.client = res.headers["client"];
    state.id = res.data.data.id;
    state.isAuthenticated = true;
  },

  setHeader(state, { headers, auth_flag }) {
    state.access_token = headers["access-token"];
    state.uid = headers["uid"];
    state.client = headers["client"];
    state.isAuthenticated = auth_flag;
  }
};

export const actions = {
  async login ({ commit }, { email, password }) {
    try {
      await this.$axios.post(`/api/v1/auth/sign_in`, {
        email,
        password
      })
      .then(res => {
        commit("setUser", res);
      });
    } catch (error) {
      if (error.response && error.response.status === 401) {
        throw new Error("Bad credentials");
      }
      throw error;
    }
  },

  async logout ({ commit }, { access_token, client, uid }) {
    try {
      await this.$axios.delete(
        `/api/v1/auth/sign_out`,
        {
          headers: {
            "access-token": access_token,
            client: client,
            uid: uid
          }
        }
      );
      commit("clearUser");
    } catch (error) {
      if (error.response && error.response.status === 401) {
        throw new Error("Bad credentials");
      }
      throw error;
    } 
  },

  nuxtServerInit ({ commit }, { req }) {
    if (req.headers.cookie) {
      const parsed = cookieparser.parse(req.headers.cookie);
      try {
        const auth_flag = parsed.uid ? true : false;
        commit("setHeader", { header :parsed, auth_flag });
      } catch (err) {
        // No valid cookie found
      }
    }
  }
};