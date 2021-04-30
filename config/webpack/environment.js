const { environment } = require('@rails/webpacker')
const erb = require('./loaders/erb')

// Make $ available on the window object
// for SJR views and jQuery plugins
// that may expect `$` to be globally available.
const webpack = require('webpack')
environment.plugins.append('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    'window.jQuery': 'jquery',
    Popper: ['popper.js', 'default']
  })
)

environment.loaders.prepend('erb', erb)
module.exports = environment
