<template>
  <a-breadcrumb class="app-breadcrumb" separator="/">
      <a-breadcrumb-item v-for="(item,index) in levelList">
        <span v-if="item.redirect==='noRedirect'||index==levelList.length-1" class="no-redirect">
          {{ generateTitle(item.meta.title) }}
        </span>
        <a v-else @click.prevent="handleLink(item)">{{ generateTitle(item.meta.title) }}</a>
      </a-breadcrumb-item>
  </a-breadcrumb>
</template>

<script>
  import pathToRegexp from 'path-to-regexp'

  export default {
  data() {
    return {
      levelList: null
    }
  },
  watch: {
    $route(route) {
      // if you go to the redirect page, do not update the breadcrumbs
      if (route.path.startsWith('/redirect/')) {
        return
      }
      this.getBreadcrumb()
    }
  },
  created() {
    this.getBreadcrumb()
  },
  methods: {
    generateTitle(title) {
      if (this.$te(title)) {
        // $t :this method from vue-i18n, inject in @/lang/index.js
        return this.$t(title)
      }
      return title
    },
    getBreadcrumb() {
      // only show routes with meta.title
      let matched = this.$route.matched.filter(item => item.meta && item.meta.title)
      matched = [{ path: '/dashboard/analysis', meta: { title: 'menu.home' }}].concat(matched)
      this.levelList = matched.filter(item => item.meta && item.meta.title && item.meta.breadcrumb !== false)
    },
    pathCompile(path) {
      const { params } = this.$route
      var toPath = pathToRegexp.compile(path)
      return toPath(params)
    },
    handleLink(item) {
      const { redirect, path } = item
      if (redirect) {
        this.$router.push(redirect)
        return
      }
      console.log(path)
      this.$router.push(this.pathCompile(path))
    }
  }
}
</script>

<style lang="less" scoped>
.app-breadcrumb {
  display: inline-block;
  font-size: 14px;
  line-height: 50px;
  margin-top: 8px;

  .no-redirect {
    color: #97a8be;
    cursor: text;
  }
}
</style>
