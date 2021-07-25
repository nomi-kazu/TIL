export default function({ app: { $axios }, store }) {
  $axios.onRequest(config => {
    $axios.setHeader("access-token", store.getters["authentication/accessToken"]);
    $axios.setHeader("client", store.getters["authentication/client"]);
    $axios.setHeader("uid", store.getters["authentication/uid"]);
  })
}