<template>
  <span :class="{'show': show || isMobile}" class="header-search">
    <a-icon type="search" class-name="search-icon" @click.stop="click"/>
    <a-select
      ref="headerSearchSelect"
      mode="multiple"
      :value="search"
      :default-active-first-option="false"
      :show-arrow="false"
      :filter-option="false"
      :placeholder="placeholder"
      :not-found-content="fetching ? undefined : null"
      :style="isMobile?{width: '100%',marginBottom:'50px'}:{}"
      class="header-search-select"
      @search="querySearch"
      @change="change"
      @blur="hiddenClick"
    >
      <a-spin v-if="fetching" slot="notFoundContent" size="small" />
      <a-select-option v-for="(item, index ) in options" :key="item.path" :value="item.path">{{ item.title.join(' > ') }}</a-select-option>
    </a-select>
  </span>
</template>

<script>
  // fuse is a lightweight fuzzy-search module
  // make search results more in line with expectations
  import Fuse from 'fuse.js'
  import path from 'path'
  import i18n from '@/locales'

  export default {
  name: 'HeaderSearch',
    props: {
      isMobile: {
        type: Boolean,
        default: () => false
      },
    },
  data() {
    return {
      search: undefined,
      options: [],
      searchPool: [],
      show: false,
      fuse: undefined,
      fetching: false
    }
  },
  computed: {
    routes() {
      return this.$store.getters.permissionList
    },
    lang() {
      return this.$store.getters.lang
    },
    supportPinyinSearch() {
      return true
    },
    placeholder() {
      return this.supportPinyinSearch && this.lang === 'zh-CN' ? "支持拼音搜索" : "Search"
    }
  },
  watch: {
    lang() {
      this.searchPool = this.generateRoutes(this.routes)
    },
    routes() {
      this.searchPool = this.generateRoutes(this.routes)
    },
    searchPool(list) {
      // Support pinyin search
      if (this.lang === 'zh-CN' && this.supportPinyinSearch) {
        this.addPinyinField(list)
      }
      this.initFuse(list)
    }
  },
  mounted() {
    this.searchPool = this.generateRoutes(this.routes)
  },
  methods: {
    filterOption(input, option) {
      return option.componentOptions.children[0].text.toLowerCase().indexOf(input.toLowerCase()) >= 0
    },
    async addPinyinField(list) {
      const { default: pinyin } = await import('pinyin')
      if (Array.isArray(list)) {
        list.forEach(element => {
          const title = element.title
          if (Array.isArray(title)) {
            title.forEach(v => {
              v = pinyin(v, {
                style: pinyin.STYLE_NORMAL
              }).join('')
              element.pinyinTitle = v
            })
          }
        })
        return list
      }
    },
    click() {
      this.show = !this.show
      if (this.show) {
        this.$refs.headerSearchSelect && this.$refs.headerSearchSelect.focus()
      }
    },
    close() {
      this.$refs.headerSearchSelect && this.$refs.headerSearchSelect.blur()
      this.options = []
      this.show = false
    },
    change(val) {
      this.$router.push(val[0])
      this.search = []
      this.options = []
      this.$nextTick(() => {
        this.show = false
      })
    },
    hiddenClick() {
      this.show = false
    },
    initFuse(list) {
      this.fuse = new Fuse(list, {
        shouldSort: true,
        threshold: 0.4,
        location: 0,
        distance: 100,
        maxPatternLength: 32,
        minMatchCharLength: 1,
        keys: [{
          name: 'title',
          weight: 0.7
        }, {
          name: 'pinyinTitle',
          weight: 0.3
        }, {
          name: 'path',
          weight: 0.3
        }]
      })
    },
    // Filter out the routes that can be displayed in the sidebar
    // And generate the internationalized title
    generateRoutes(routes, basePath = '/', prefixTitle = []) {
      let res = []
      for (const router of routes) {
        // skip hidden router
        if (router.hidden) { continue }
        const data = {
          path: path.resolve(basePath, router.path),
          title: [...prefixTitle]
        }
        if (router.meta && router.meta.title) {
          // generate internationalized title
          const i18ntitle = i18n.t(router.meta.title)
          data.title = [...data.title, i18ntitle]
          if (router.redirect !== 'noRedirect') {
            // only push the routes with title
            // special case: need to exclude parent router without redirect
            res.push(data)
          }
        }
        // recursive child routes
        if (router.children) {
          const tempRoutes = this.generateRoutes(router.children, data.path, data.title)
          if (tempRoutes.length >= 1) {
            res = [...res, ...tempRoutes]
          }
        }
      }
      return res
    },
    querySearch(query) {
      if (query !== '') {
        this.fetching = true
        // 这里也可以远程搜索
        setTimeout(()=>{
          this.options = this.fuse.search(query)
          this.fetching = false
        }, 200)

      } else {
        this.options = []
      }
    }
  }
}
</script>
<style lang="less" scoped>
.header-search {

  .search-icon {
    cursor: pointer;
    font-size: 28px;
    vertical-align: middle;
  }
  .header-search-select {
    transition: width 0.2s;
    width: 0;
    overflow: hidden;
    background: transparent;
    border-radius: 0;
    display: inline-block;
    vertical-align: middle;

    /deep/ .ant-select-selection {
      border-radius: 0;
      border: 0;
      padding-left: 0;
      padding-right: 0;
      box-shadow: none !important;
      border-bottom: 1px solid #d9d9d9;
      vertical-align: middle;
    }
  }
  &.show {
    .header-search-select {
      width: 180px;
      margin-left: 10px;
    }
  }
}
</style>
