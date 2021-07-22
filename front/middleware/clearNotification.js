export default function ({ store, redirect }) {
  store.dispatch('flash_message/showFlashMessage', { text: null });
}