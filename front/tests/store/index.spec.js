import Vuex from 'vuex';
import * as index from '~/store/index';
import { createLocalVue } from '@vue/test-utils';
import cloneDeep from 'lodash.clonedeep';

const localVue = createLocalVue();
localVue.use(Vuex);

describe('store/index.js', () => {
  let store;

  // mockのVueインスタンス作成
  beforeEach(() => {
    store = new Vuex.Store(cloneDeep(index))
  })

  describe('mutations', () => {
    it('setUserの正常系', () => {
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
    })

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

    it('clearUserの正常系', () => {
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
});