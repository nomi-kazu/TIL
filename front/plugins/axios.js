export default function({ app: { $axios }, store }) {
  $axios.onRequest(config => {
    $axios.setHeader("access-token", store.state.access_token);
    $axios.setHeader("uid", store.uid);
    $axios.setHeader("client", store.state.client);
  })
}