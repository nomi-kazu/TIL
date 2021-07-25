const cookie = process.client ? requestAnimationFrame("js-cookie") : undefined;

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
  async login ({ commit, getters }, { email, password }) {
    try {
      const res = await this.$axios.post(`/api/v1/auth/sign_in`, {
        email,
        password
      })

      commit("setUser", res);

      // Cookieにセット
      Cookie.set("access-token", getters.access_token);
      Cookie.set("client", getters.client);
      Cookie.set("uid", getters.uid);

    } catch (error) {
      if (error.response && error.response.status === 401) {
        throw new Error("Bad credentials");
      }
      throw new Error("Internal Server Error");
    }
  },

  // ログアウト
  async logout ({ commit }) {
    try {
      const access_token = Cookie.get("access-token");
      const client = Cookie.get("client");
      const uid = Cookie.get("uid");

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
      Cookie.remove("access-token");
      Cookie.remove("client");
      Cookie.remoce("uid");
    } catch (error) {
      if (error.response && error.response.status === 401) {
        throw new Error("Bad credentials");
      }
      throw new Error("Internal Server Error");
    } 
  },
};