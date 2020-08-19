<template>
  <global-footer class="footer custom-render">
    <template v-slot:links>
      <a href="https://www.github.com/vueComponent/pro-layout" target="_blank">Pro Layout</a>
      <a href="https://www.github.com/vueComponent/ant-design-vue-pro" target="_blank">Github</a>
      <a href="https://www.github.com/sendya/" target="_blank">@Sendya</a>
    </template>
    <template v-slot:copyright>
      <div class="copyright">
        Copyright
        <a-icon type="copyright"/>
        2020 <span><a href="https://github.com/vueComponent" target="_blank">vueComponent</a> 出品</span>
      </div>
    </template>
  </global-footer>
</template>

<script>
  import {GlobalFooter} from '@ant-design-vue/pro-layout'

  export default {
  name: 'ProGlobalFooter',
  components: {
    GlobalFooter
  }
}
</script>
<style lang="less" scoped>
  .footer {
    padding: 0 16px;
    margin: 48px 0 24px;
    text-align: center;
    .copyright {
      color: rgba(0, 0, 0, .45);
      font-size: 14px;
    }
  }
</style>
