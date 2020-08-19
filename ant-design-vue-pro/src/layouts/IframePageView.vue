<template>

    <iframe  :id="id" :src="url" frameborder="0" width="100%" height="800px" scrolling="auto"></iframe>

</template>

<script>
  import Vue from 'vue'
  import {ACCESS_TOKEN} from "@/store/mutation-types"

  export default {
    name: "IframePageContent",
    data () {
      return {
        url: "",
        id:""
      }
    },
    created () {
      this.goUrl()
    },
    updated () {
      this.goUrl()
    },
    watch: {
      $route(to, from) {
        this.goUrl();
      }
    },
    methods: {
      goUrl () {
        const url = this.$route.meta.url
        this.id = this.$route.path
        if (url !== null && url !== undefined) {
          if (this.$route.meta.external) {
            const view = this.$route
            this.$store.dispatch('tagsView/delView', view).then(({ visitedViews }) => {
              if (view.path === this.$route.path) {
                this.toLastView(visitedViews, view)
              }
            })
            // 外部url加入token
            const tokenStr = '${token}'
            if (url.indexOf(tokenStr) > 0) {
              const token = Vue.ls.get(ACCESS_TOKEN);
              this.url = url.replace(tokenStr, token)
            }
            window.open(url)
          } else {
            this.url = url
          }
        }
      }
    }
  }
</script>

<style>
</style>