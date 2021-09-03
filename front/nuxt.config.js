import colors from 'vuetify/es5/util/colors'

export default {
  ssr: false,
  
  head: {
    titleTemplate: '%s - ' + process.env.npm_package_name,
    title: process.env.npm_package_name || '',
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: process.env.npm_package_description || '' }
    ],
    link: [
      { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }
    ]
  },

  loading: { color: '#fff' },
  
  css: [
    { src: '~/node_modules/highlight.js/styles/hopscotch.css', lang: 'css' },
    '~/assets/sass/main.scss'
  ],
  
  plugins: [
  ],

  components: true,
 
  buildModules: [
    '@nuxtjs/vuetify',
    '@nuxtjs/eslint-module',
  ],
  
  modules: [
    '@nuxtjs/axios',
    '@nuxtjs/markdownit',
    '@nuxt-i18n',
  ],
  
  markdownit: {
    injected: true,
    breaks: true,
    html: true,
    linkify: true,
    typography: true,
    langPrefix: '',
    use: [
      'markdown-it-mark',
      'markdown-it-ins'
    ],
    highlight: (str, lang) => {
      const hljs = require('highlight.js');
      if (lang && hljs.getLanguage(lang)) {
        try {
          return '<pre class="hljs"><code>' +
                  hljs.highlight(str, { language: lang, ignoreIllegals: true }).value +
                  '</code></pre>';
        } catch (__) {}
      }
      // 言語設定がない場合、プレーンテキストとして表示する
      return '<pre class="hljs"><code>' +  hljs.highlight('plaintext', str, true).value + '</code></pre>';
    }
  },

  axios: {
    baseURL: process.env.BACK_URL || "http://localhost:3000",
    credentials: true
  },

  router: {},

  vuetify: {
    customVariables: ['~/assets/variables.scss'],
    theme: {
      dark: true,
      themes: {
        dark: {
          primary: colors.blue.darken2,
          accent: colors.grey.darken3,
          secondary: colors.amber.darken3,
          info: colors.teal.lighten1,
          warning: colors.amber.base,
          error: colors.deepOrange.accent4,
          success: colors.green.accent3,
          limeColor: colors.lime.accent2,
          cyanLight5: colors.cyan.lighten5,
          greyLight4: colors.grey.lighten4
        }
      }
    }
  },

  publicRuntimeConfig: {
    appName: process.env.APP_NAME,
    cryptoKey: process.env.CRYPTO_KEY
  },
  
  build: {
    transpile: [
      'vee-validate/dist/rules'
    ]
  }
}
