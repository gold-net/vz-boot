// with polyfills
import 'core-js/stable'
import 'regenerator-runtime/runtime'

import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store/'
import storage from 'vue-ls'
import i18n from './locales'
import {VueAxios} from './utils/request'
import ProLayout, {PageHeaderWrapper} from '@ant-design-vue/pro-layout'
import config from '@/defaultSettings'

import bootstrap from './core/bootstrap'
import './core/lazy_use' //添加babel.config.js中懒加载插件
// import './core/use'
import './permission' // permission control
import './utils/filter' // global filter
import './global.less' // global css

Vue.config.productionTip = false

// mount axios to `Vue.$http` and `this.$http`
Vue.use(storage, config.storageOptions)
Vue.use(VueAxios)
Vue.component('pro-layout', ProLayout)
Vue.component('page-header-wrapper', PageHeaderWrapper)


new Vue({
  router,
  store,
  i18n,
  created: bootstrap,
  render: h => h(App)
}).$mount('#app')
