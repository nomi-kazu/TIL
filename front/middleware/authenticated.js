export default function ({ store, redirect }) {
  // ユーザー認証されていないとき
  if (!store.state.isAuthenticated) {
    redirect('/user/login');
  }
}