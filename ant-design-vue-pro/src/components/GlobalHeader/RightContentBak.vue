<template>
  <div :class="wrpCls">
    <span class="action" @click="showClick">
      <a-icon type="search"></a-icon>
    </span>
    <component :is="searchMenuComp" v-show="searchMenuVisible || isMobile" class="borders"
               :visible="searchMenuVisible" title="搜索菜单" :footer="null" @cancel="searchMenuVisible=false">
    <a-select
      class="search-input"
      showSearch
      :showArrow="false"
      placeholder="搜索菜单"
      optionFilterProp="children"
      :filterOption="filterOption"
      :open="isMobile?true:null"
      :getPopupContainer="(node) => node.parentNode"
      :style="isMobile?{width: '100%',marginBottom:'50px'}:{}"
      @change="searchMethods"
      @blur="hiddenClick"
    >
      <a-select-option v-for="(site,index) in searchMenuOptions" :key="index" :value="site.id">{{ $t(site.meta.title) }}</a-select-option>
    </a-select>
    </component>
    <avatar-dropdown :menu="showMenu" :current-user="currentUser" :class="prefixCls" />
    <select-lang :class="prefixCls" />
  </div>
</template>

<script>
  import AvatarDropdown from './AvatarDropdown'
  import SelectLang from '@/components/SelectLang'
  import {mapGetters, mapState} from "vuex";

  export default {
  name: 'RightContent',
  components: {
    AvatarDropdown,
    SelectLang
  },
  props: {
    prefixCls: {
      type: String,
      default: 'ant-pro-global-header-index-action'
    },
    isMobile: {
      type: Boolean,
      default: () => false
    },
    topMenu: {
      type: Boolean,
      required: true
    },
    theme: {
      type: String,
      required: true
    }
  },
  data () {
    return {
      showMenu: true,
      currentUser: {},
      searchMenuOptions:[],
      searchMenuComp: 'span',
      searchMenuVisible: false,
    }
  },
  computed: {
    ...mapState({
      // 后台菜单
      permissionMenuList: state => state.user.permissionList

    }),
    ...mapGetters(["nickname", "avatar"]),
    wrpCls () {
      return {
        'ant-pro-global-header-index-right': true,
        [`ant-pro-global-header-index-${(this.isMobile || !this.topMenu) ? 'light' : this.theme}`]: true
      }
    }
  },
  created() {
    let lists = []
    this.searchMenus(lists,this.permissionMenuList)
    this.searchMenuOptions=[...lists]
  },
  mounted () {
    setTimeout(() => {
      this.currentUser = {
        name: this.nickname,
        avatar: this.avatar
      }
    }, 1500)
  },
  methods: {
    showClick() {
      this.searchMenuVisible = true
    },
    searchMenus(arr,menus){
      for(let i of menus){
        if(!i.hidden && "layouts/RouteView"!==i.component){
          arr.push(i)
        }
        if(i.children&& i.children.length>0){
          this.searchMenus(arr,i.children)
        }
      }
    },
    searchMethods(value) {
      let route = this.searchMenuOptions.filter(item => item.id === value)[0]
      if (route.meta.external === true) {
        window.open(route.meta.url, '_blank')
      } else {
        this.$router.push({ path: route.path })
      }
      this.searchMenuVisible = false
    },
    filterOption(input, option) {
      return option.componentOptions.children[0].text.toLowerCase().indexOf(input.toLowerCase()) >= 0
    },
    hiddenClick(){
      this.searchMenuVisible = false
    }
  }
}
</script>
<style lang="less" scoped>
  .search-input {
    width: 180px;
    color: inherit;

    /deep/ .ant-select-selection {
      background-color: inherit;
      border: 0;
      border-bottom: 1px solid white;
      &__placeholder, &__field__placeholder {
        color: inherit;
      }
    }
  }
  .action {
    cursor: pointer;
    padding: 0 14px;
    display: inline-block;
    transition: all .3s;

    height: 70%;
    line-height: 46px;

    &.action-full {
      height: 100%;
    }
    &:hover {
      background: rgba(255, 255, 255, 0.3);
    }
  }
  &.dark {
    .user-wrapper {

      .action {
        color: black;

        &:hover {
          background: rgba(0, 0, 0, 0.05);
        }

        .anticon {
          color: black;
        }
      }
    }
  }
</style>
