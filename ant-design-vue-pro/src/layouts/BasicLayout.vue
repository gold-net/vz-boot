<template>
  <pro-layout
    :title="title"
    :logoRender="logoRender"
    :menus="menus"
    :collapsed="collapsed"
    :mediaQuery="query"
    :isMobile="isMobile"
    :handleMediaQuery="handleMediaQuery"
    :handleCollapse="handleCollapse"
    :i18nRender="i18nRender"
    v-bind="settings">
    <template slot="headerContentRender">
      <breadcrumb/>
    </template>
<!--    <setting-drawer :settings="settings" @change="handleSettingChange" />-->
    <setting-drawer @change="handleSettingChange" />
    <multi-tab v-if="settings.multipage"/>
    <template slot="rightContentRender">
      <right-content :top-menu="settings.layout === 'topmenu'" :is-mobile="isMobile" :theme="settings.theme" />
    </template>
    <template slot="footerRender">
      <global-footer />
    </template>
    <RouteView />
  </pro-layout>
</template>

<script>
  import {i18nRender} from '@/locales'
  import {mapState} from 'vuex'
  import {CONTENT_WIDTH_TYPE, SIDEBAR_TYPE, TOGGLE_MOBILE_TYPE} from '@/store/mutation-types'

  import defaultSettings from '@/defaultSettings'
  import RightContent from '@/components/GlobalHeader/RightContent'
  import GlobalFooter from '@/components/GlobalFooter'
  import Breadcrumb from '@/components/Breadcrumb'
  import SettingDrawer from '@/components/SettingDrawer'
  import MultiTab from '@/components/MultiTab'
  import RouteView from './RouteView'
  import {mixin} from '@/utils/mixin.js'

  export default {
  name: 'BasicLayout',
  mixins: [mixin],
  components: {
    SettingDrawer,
    RightContent,
    GlobalFooter,
    Breadcrumb,
    RouteView,
    MultiTab
  },
  data () {
    return {
      // base
      menus: [],
      // 侧栏收起状态
      collapsed: true,
      title: defaultSettings.title,

      // 媒体查询
      query: {},
      breads: [],
      // 是否手机模式
      isMobile: false
    }
  },
  computed: {
    ...mapState({
      // 动态主路由
      mainMenu: state => state.permission.addRouters
    }),
    settings() {
      return {
        // 布局类型
        layout: this.layoutMode, // 'sidemenu', 'topmenu'
        // CONTENT_WIDTH_TYPE
        contentWidth: this.layoutMode === 'sidemenu' ? CONTENT_WIDTH_TYPE.Fluid : this.contentWidth,
        // 主题 'dark' | 'light'
        theme: this.navTheme,
        // 主色调
        primaryColor: this.primaryColor,
        fixedHeader: this.fixedHeader,
        fixSiderbar: this.fixSiderbar,
        colorWeak: this.colorWeak,
        multipage: this.multiTab,
        hideHintAlert: false,
        hideCopyButton: false
      }
    }
  },
  created () {
    this.menus = this.mainMenu || []
    // 处理侧栏收起状态
    this.$watch('collapsed', () => {
      this.$store.commit(SIDEBAR_TYPE, this.collapsed)
    })
    this.$watch('isMobile', () => {
      this.$store.commit(TOGGLE_MOBILE_TYPE, this.isMobile)
    })
  },
  mounted () {
    const userAgent = navigator.userAgent
    if (userAgent.indexOf('Edge') > -1) {
      this.$nextTick(() => {
        this.collapsed = !this.collapsed
        setTimeout(() => {
          this.collapsed = !this.collapsed
        }, 16)
      })
    }

    // first update color
    // TIPS: THEME COLOR HANDLER!! PLEASE CHECK THAT!!
    if (process.env.NODE_ENV !== 'production' || process.env.VUE_APP_PREVIEW === 'true') {
      // updateTheme(this.settings.primaryColor)
    }
  },
  methods: {
    i18nRender,
    logoRender() {
      return (<img src="@/assets/logo.svg"/>)
    },
    handleMediaQuery (val) {
      this.query = val
      if (this.isMobile && !val['screen-xs']) {
        this.isMobile = false
        return
      }
      if (!this.isMobile && val['screen-xs']) {
        this.isMobile = true
        this.collapsed = false
        this.settings.contentWidth = CONTENT_WIDTH_TYPE.Fluid
        // this.settings.fixSiderbar = false
      }
    },
    handleCollapse (val) {
      this.collapsed = val
    },
    handleSettingChange ({ type, value }) {
      type && (this.settings[type] = value)
      switch (type) {
        case 'contentWidth':
          this.settings[type] = value
          break
        case 'layout':
          if (value === 'sidemenu') {
            this.settings.contentWidth = CONTENT_WIDTH_TYPE.Fluid
          } else {
            this.settings.fixSiderbar = false
            this.settings.contentWidth = CONTENT_WIDTH_TYPE.Fixed
          }
          break
      }
    }
  }
}
</script>

<style lang="less">
@import "./BasicLayout.less";
</style>
