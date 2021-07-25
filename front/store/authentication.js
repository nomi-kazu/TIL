const Cookie = process.client ? require("js-cookie") : undefined;

export const state = () => ({
  accessToken: null,
  uid: null,
  client: null,
  id: null,
  isAuthenticated: false,
});

export const getters = {
  accessToken: (state) => state.accessToken,
  client: (state) => state.client,
  uid: (state) => state.uid,
  id: (state) => state.id,
  isAuthenticated: (state) => state.isAuthenticated,
};

export const mutations = {
  clearUser(state) {
    state.accessToken = null;
    state.uid = null;
    state.client = null;
    state.id = null;
    state.isAuthenticated = false;
  },

  setUser(state, res) {
    state.accessToken = res.headers["access-token"];
    state.uid = res.headers["uid"];
    state.client = res.headers["client"];
    state.id = res.data.data.id;
    state.isAuthenticated = true;
  },

  setHeader(state, { headers, auth_flag }) {
    state.accessToken = headers["access-token"];
    state.uid = headers["uid"];
    state.client = headers["client"];
    state.isAuthenticated = auth_flag;
  }
};

export const actions = {

  // ログイン
  async login ({ commit, getters }, { email, password }) {
    try {
      const res = await this.$axios.post(`/api/v1/auth/sign_in`, {
        email,
        password
      })

      commit("setUser", res);

      // Cookieにセット
      if (Cookie !== undefined) {
        Cookie.set("access-token", getters.accessToken);
        Cookie.set("client", getters.client);
        Cookie.set("uid", getters.uid);
      }
    } catch (error) {
      if (error.response && error.response.status === 401) {
        throw new Error("Bad credentials");
      }
      throw new Error("Internal Server Error");
    }
  },

  // ログアウト
  async logout ({ commit, getters }) {
    try {
      const accessToken = getters.accessToken;
      const client = getters.client;
      const uid = getters.uid;

      await this.$axios.delete(
        `/api/v1/auth/sign_out`,
        {
          headers: {
            "access-token": accessToken,
            client: client,
            uid: uid
          }
        }
      );

      commit("clearUser");

      if (Cookie !== undefined) {
        Cookie.remove("access-token");
        Cookie.remove("client");
        Cookie.remove("uid");
      } 
    } catch (error) {
      if (error.response && error.response.status === 401) {
        throw new Error("Bad credentials");
      }
      throw new Error("Internal Server Error");
    } 
  },
};