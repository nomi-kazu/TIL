export default ({ $auth, store, route, redirect }) => {
  if (($auth.loggedIn && route.name === 'login') || ($auth.loggedIn && route.name === 'signup')) {
    return redirect('/')
  }
}
