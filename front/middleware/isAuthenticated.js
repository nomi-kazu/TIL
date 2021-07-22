export default function ({ store, redirect }) {
  // ユーザー認証されていないとき
  if (!store.state.isAuthenticated) {
    return redirect('/user/login')
  }
}