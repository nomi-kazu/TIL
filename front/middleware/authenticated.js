export default function ({ store, redirect }) {
  // ユーザー認証されていないとき
  if (!store.getters["authentication/isAuthenticated"]) {
    return redirect('/user/login');
  }
}