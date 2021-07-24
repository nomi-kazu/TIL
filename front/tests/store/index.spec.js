import Vuex from 'vuex';
import axios from 'axios';
import * as index from '~/store/index';
import { createLocalVue } from '@vue/test-utils';
import cloneDeep from 'lodash.clonedeep';

const localVue = createLocalVue();
localVue.use(Vuex);

// axiosのmock
let mockAxiosGetResult; // Axiosで発生させる戻り値
let mockAxiosError = false; // Errorを発生させるか
jest.mock('axios', () => ({
  post: jest.fn(() => {
    if (mockAxiosError) {
      return Promise.reject(mockAxiosGetResult);
    }
      return Promise.resolve(mockAxiosGetResult);
  }),
  delete: jest.fn(() => {
    if (mockAxiosError) {
      return Promise.reject(mockAxiosGetResult);
    }
      return Promise.resolve(mockAxiosGetResult);
  })
}));

describe('store/index.js', () => {
  let store;

  // mockのVueインスタンス作成
  beforeEach(() => {
    store = new Vuex.Store(cloneDeep(index))
  })

  describe('mutations', () => {
    it('setHeaderの正常系', () => {
      expect(store.getters.access_token).toBeNull();
      expect(store.getters.client).toBeNull();
      expect(store.getters.uid).toBeNull();
      expect(store.getters.isAuthenticated).toBeFalsy();

      const parsedCookie = {
        "access-token": "8LccRgu2PKQ-E__vtMZ1Wm",
        client: "CIhbiSpae_3G4Q_k5rtJmb",
        uid: "foo@example.com",
      };

      store.commit('setHeader', { headers: parsedCookie, auth_flag: true });

      expect(store.getters.access_token).toBe("8LccRgu2PKQ-E__vtMZ1Wm");
      expect(store.getters.client).toBe("CIhbiSpae_3G4Q_k5rtJmb");
      expect(store.getters.uid).toBe("foo@example.com");
      expect(store.getters.isAuthenticated).toBeTruthy();
    })

    it('setUserとclearUserの正常系', () => {
      expect(store.getters.access_token).toBeNull();
      expect(store.getters.client).toBeNull();
      expect(store.getters.uid).toBeNull();
      expect(store.getters.id).toBeNull();
      expect(store.getters.isAuthenticated).toBeFalsy();

      const res = {
        headers: {
          "access-token": "8LccRgu2PKQ-E__vtMZ1Wm",
          client: "CIhbiSpae_3G4Q_k5rtJmb",
          uid: "foo@example.com",
        },
        data: { data: { id: "1" } }
      };

      store.commit('setUser', res);

      expect(store.getters.access_token).toBe("8LccRgu2PKQ-E__vtMZ1Wm");
      expect(store.getters.client).toBe("CIhbiSpae_3G4Q_k5rtJmb");
      expect(store.getters.uid).toBe("foo@example.com");
      expect(store.getters.id).toBe("1");
      expect(store.getters.isAuthenticated).toBeTruthy();

      store.commit('clearUser');
      expect(store.getters.access_token).toBeNull();
      expect(store.getters.client).toBeNull();
      expect(store.getters.uid).toBeNull();
      expect(store.getters.id).toBeNull();
      expect(store.getters.isAuthenticated).toBeFalsy();
    })
  })

  describe('actions', () => {

    beforeEach(() => {
      store.$axios = axios; // @nuxtjs/axiosの代わりにaxios
      mockAxiosError = false; // テスト前にfalseに戻す
    });

    it('loginできる(正常系)', async () => {
      mockAxiosGetResult = {
        headers: {
          "access-token": "8LccRgu2PKQ-E__vtMZ1Wm",
          client: "CIhbiSpae_3G4Q_k5rtJmb",
          uid: "foo@example.com",
        },
        data: { data: { id: "1" } }
      };

      await store.dispatch('login', { email: 'foo@example.com', password: 'password'});

      expect(store.getters.access_token).toBe("8LccRgu2PKQ-E__vtMZ1Wm");
      expect(store.getters.client).toBe("CIhbiSpae_3G4Q_k5rtJmb");
      expect(store.getters.uid).toBe("foo@example.com");
      expect(store.getters.id).toBe("1");
      expect(store.getters.isAuthenticated).toBeTruthy();
    })

    it('loginできない(異常系:Internal Server Error)', async () => {
      mockAxiosError = true;
      mockAxiosGetResult = {
        response: {
          status: 500
        }
      };

      await expect(
        store.dispatch('login', { email: 'foo@example.com', password: 'password'})
      ).rejects.toThrow("Internal Server Error");
    })

    it('loginできない(異常系:Bad credentials)', async () => {
      mockAxiosError = true;
      mockAxiosGetResult = {
        response: {
          status: 401
        }
      };

      await expect(
        store.dispatch('login', { email: 'foo@example.com', password: 'password'})
      ).rejects.toThrow("Bad credentials");
    })

    it('logoutできる(正常系)', async () => {
      const res = {
        headers: {
          "access-token": "8LccRgu2PKQ-E__vtMZ1Wm",
          client: "CIhbiSpae_3G4Q_k5rtJmb",
          uid: "foo@example.com",
        },
        data: { data: { id: "1" } }
      };
      store.commit('setUser', res);

      mockAxiosGetResult = {
        success: "true"
      };

      await store.dispatch('logout', {
        access_token: "8LccRgu2PKQ-E__vtMZ1Wm",
        client: "CIhbiSpae_3G4Q_k5rtJmb",
        uid: "foo@example.com",
      });

      expect(store.getters.access_token).toBeNull();
      expect(store.getters.client).toBeNull();
      expect(store.getters.uid).toBeNull();
      expect(store.getters.id).toBeNull();
      expect(store.getters.isAuthenticated).toBeFalsy();
    })

    it('logoutできない(異常系:Internal Server Error)', async () => {
      mockAxiosError = true;
      mockAxiosGetResult = {
        response: {
          status: 500
        }
      };

      await expect(
        store.dispatch('logout', {
          access_token: "8LccRgu2PKQ-E__vtMZ1Wm",
          client: "CIhbiSpae_3G4Q_k5rtJmb",
          uid: "foo@example.com",
        })
      ).rejects.toThrow("Internal Server Error");
    })

    it('logoutできない(異常系:Bad credentials)', async () => {
      mockAxiosError = true;
      mockAxiosGetResult = {
        response: {
          status: 401
        }
      };

      await expect(
        store.dispatch('logout', {
          access_token: "8LccRgu2PKQ-E__vtMZ1Wm",
          client: "CIhbiSpae_3G4Q_k5rtJmb",
          uid: "foo@example.com",
        })
      ).rejects.toThrow("Bad credentials");
    })
  })
});