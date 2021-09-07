const { resolve } = require('path');
const config = require('@redhat-cloud-services/frontend-components-config');

const insightsProxy = {
  https: false,
  ...(process.env.BETA && { deployment: 'beta/apps' }),
};

const webpackProxy = {
  deployment: process.env.BETA ? 'beta/apps' : 'apps',
  useProxy: true,
  useCloud: true,
  env: 'ci-beta',
  appUrl: process.env.BETA ? ['/beta/docs/api'] : ['/docs/api'],
};

const { config: webpackConfig, plugins } = config({
  rootFolder: resolve(__dirname, '../'),
  debug: true,
  sassPrefix: '.api-docs, .apiDocs',
  ...(process.env.PROXY ? webpackProxy : insightsProxy),
});

const modulesConfig =
  require('@redhat-cloud-services/frontend-components-config/federated-modules')(
    {
      root: resolve(__dirname, '../'),
      moduleName: 'apiDocs',
      useFileHash: false,
    }
  );

plugins.push(modulesConfig);

module.exports = {
  ...webpackConfig,
  plugins,
};
