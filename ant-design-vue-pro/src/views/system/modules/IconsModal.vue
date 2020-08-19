<template>
  <a-modal
    v-model="show"
    :width="900"
    :keyboard="false"
    :closable="false"
    :centered="true"
    @ok="ok"
    @cancel="cancel"
    :maskClosable="false"
    :mask="false"
    okText="确认"
    cancelText="取消">
    <icon-selector ref="icons" v-model="selectedIcon" @change="chooseIcon"></icon-selector>
  </a-modal>
</template>
<script>
  import IconSelector from '@/components/IconSelector'

  export default {
  name: 'IconsModal',
  props: {
    iconChooseVisible: {
      default: false
    },
    value: {
      type: String
    }
  },
  components: {IconSelector},
  data () {
    return {
      selectedIcon: ''
    }
  },
  computed: {
    show: {
      get: function () {
        return this.iconChooseVisible
      },
      set: function () {
      }
    }
  },
  watch: {
    value (val) {
      this.selectedIcon = val
    }
  },
  methods: {
    chooseIcon (icon) {
      this.selectedIcon = icon
      this.$message.success(`选中 ${icon}`)
    },
    ok () {
      if (this.selectedIcon === '') {
        this.$message.warning('尚未选择任何图标')
        return
      }
      this.$emit('choose', this.selectedIcon)
    },
    cancel () {
      this.$emit('close')
    }
  }
}
</script>
