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

  describe('actions', () => {
    it('nuxtServerInit(正常系)', () => {
      // TODO: cookieparserのテスト
      store.dispatch('nuxtServerInit', { req: null });
    })
  })
});