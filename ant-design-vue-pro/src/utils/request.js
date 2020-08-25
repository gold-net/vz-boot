import Vue from 'vue'
import axios from 'axios'
import store from '@/store'
import {VueAxios} from './axios'
import {Modal, notification} from 'ant-design-vue'
import {ACCESS_TOKEN} from "@/store/mutation-types"

window._CONFIG = {};
window._CONFIG['domianURL'] = process.env.VUE_APP_API_BASE_URL;

// 创建 axios 实例yarn
const service = axios.create({
  baseURL: process.env.VUE_APP_API_BASE_URL,
  timeout: 10000
})

const err = (error) => {
  if (error.response) {
    console.log("------异常响应------", error.response.status);
    switch (error.response.status) {
      case 403:
        notification.error({message: '系统提示', description: '拒绝访问，请联系管理员', duration: 4})
        break
      case 500:
        notification.error({message: '系统提示', description: '服务异常，请联系管理员', duration: 4})
        break
      case 404:
        notification.error({message: '系统提示', description: '很抱歉，资源未找到!', duration: 4})
        break
      case 504:
        notification.error({message: '系统提示', description: '网络超时，请稍后重试'})
        break
      case 401:
        if (window.location.href.indexOf('/user/login') < 0) {
          Modal.confirm({
            title: '系统提示',
            content: '登录已过期，请重新登录',
            okText: '重新登录',
            mask: false,
            onOk: () => {
              store.dispatch('Logout').then(() => {
                if (window.location.href.indexOf('/user/login') < 0) {
                  window.location.reload();
                }
              })
            }
          })
        }
        break
      default:
        notification.error({
          message: '系统提示',
          description: error.response.data.message,
          duration: 4
        })
        break
    }
  } else {
    notification.error({message: '异常提示', description: error.message, duration: 4})
  }
  return Promise.reject(error);
};

// request interceptor
service.interceptors.request.use(config => {
  const token = Vue.ls.get(ACCESS_TOKEN)
  if (token) {
    config.headers[ 'X-Access-Token' ] = token // 让每个请求携带自定义 token 请根据实际情况自行修改
  }
  config.params = {
    _t: Date.parse(new Date())/1000,
    ...config.params
  }
  return config
},(error) => {
  return Promise.reject(error)
})

// response interceptor
service.interceptors.response.use((response) => {
  switch (response.data.code) {
    case 200:
      return response.data
    case 401:
      if (window.location.href.indexOf('/user/login') < 0) {
        Modal.info({
          title: '系统提示',
          content: '登录已过期，请重新登录',
          okText: '重新登录',
          mask: false,
          onOk: () => {
            store.dispatch('Logout').then(() => {
              if (window.location.href.indexOf('/user/login') < 0) {
                window.location.reload();
              }
            })
          }
        })
      }
      break
    case 403:
    case 404:
    case 500:
    case 504:
    default:
      break
  }
  return response.data
  }, err)

const installer = {
  vm: {},
  install (Vue, router = {}) {
    Vue.use(VueAxios, router, service)
  }
}

export {
  installer as VueAxios,
  service as axios
}