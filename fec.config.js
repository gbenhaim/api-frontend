module.exports = {
  appUrl: '/docs/api',
  debug: true,
  useProxy: true,
  proxyVerbose: true,
  /**
   * Change to false after your app is registered in configuration files
   */
  interceptChromeConfig: false,
  /**
   * Add additional webpack plugins
   */
  plugins: [],
  sassPrefix: '.api-docs, .apiDocs',
  routes: {
    '/beta/config': {
      host: 'http://localhost:8889'
    },
    '/config': {
      host: 'http://localhost:8889'
    }
  }
};
