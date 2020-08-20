<template>
  <a-modal
    :title="title"
    :width="800"
    :visible="visible"
    :confirmLoading="confirmLoading"
    switchFullscreen
    @ok="handleOk"
    @cancel="handleCancel"
    cancelText="关闭">
    <a-spin :spinning="confirmLoading">
      <a-form :form="form">
<#list table.fields as po><#rt/>
<#if po.name !='id'><#rt/>
        <a-form-item
          :labelCol="labelCol"
          :wrapperCol="wrapperCol"
          label="${po.comment}">
          <#if po.type =='date'>
          <a-date-picker v-decorator="[ '${po.name}', validatorRules.${po.name}]" />
          <#elseif po.type =='datetime'>
          <a-date-picker showTime format='YYYY-MM-DD HH:mm:ss' v-decorator="[ '${po.name}', validatorRules.${po.name}]" />
          <#elseif "int,decimal,double,"?contains(po.type)>
          <a-input-number v-decorator="[ '${po.name}', validatorRules.${po.name}]" />
          <#else>
          <a-input placeholder="请输入${po.comment}" v-decorator="['${po.name}', validatorRules.${po.name}]" />
          </#if>
        </a-form-item>
</#if>
</#list>
      </a-form>
    </a-spin>
  </a-modal>
</template>

<script>
  import { httpAction } from '@/api/manage'
  import pick from 'lodash.pick'
  import moment from "moment"

  export default {
    name: "${table.entityName}Modal",
    data () {
      return {
        title:"操作",
        visible: false,
        model: {},
        labelCol: {
          xs: { span: 24 },
          sm: { span: 5 },
        },
        wrapperCol: {
          xs: { span: 24 },
          sm: { span: 16 },
        },

        confirmLoading: false,
        form: this.$form.createForm(this),
        validatorRules:{
        <#list table.fields as po>
        <#if po.name !='id'>
        ${po.name}:{rules: [{ required: false, message: '请输入${po.comment}!' }]},
        </#if>
	    </#list>
        },
        url: {
          add: "/${package.ModuleName}/${table.entityName?uncap_first}/add",
          edit: "/${package.ModuleName}/${table.entityName?uncap_first}/edit"
        },
      }
    },
    created () {
    },
    methods: {
      add () {
        this.edit({});
      },
      edit (record) {
        this.form.resetFields();
        this.model = Object.assign({}, record);
        this.visible = true;
        this.$nextTick(() => {
          this.form.setFieldsValue(pick(this.model<#list table.fields as po><#if po.name !='id' && po.type?index_of("date")==-1>,'${po.name}'</#if></#list>))
		  //时间格式化
          <#list table.fields as po>
          <#if po.name !='id' && po.type?index_of("date")!=-1>
          this.form.setFieldsValue({${po.name}:this.model.${po.name}?moment(this.model.${po.name}):null})
          </#if>
          </#list>
        })
      },
      close () {
        this.$emit('close');
        this.visible = false;
      },
      handleOk () {
        const that = this;
        // 触发表单验证
        this.form.validateFields((err, values) => {
          if (!err) {
            that.confirmLoading = true;
            let httpurl = '';
            let method = '';
            if(!this.model.id){
              httpurl+=this.url.add;
              method = 'post';
            }else{
              httpurl+=this.url.edit;
               method = 'put';
            }
            let formData = Object.assign(this.model, values);
            //时间格式化
            <#list table.fields as po>
            <#if po.name !='id' && po.type =='date'>
            formData.${po.name} = formData.${po.name}?formData.${po.name}.format():null;
            <#elseif po.name !='id' && po.type =='datetime'>
            formData.${po.name} = formData.${po.name}?formData.${po.name}.format('YYYY-MM-DD HH:mm:ss'):null;
            </#if>
            </#list>
            httpAction(httpurl,formData,method).then((res)=>{
              if(res.success){
                that.$message.success(res.message);
                that.$emit('ok');
                that.close();
              }else{
                that.$message.warning(res.message);
              }
            }).finally(() => {
              that.confirmLoading = false;
            })
          }
        })
      },
      handleCancel () {
        this.close()
      }
    }
  }
</script>
<style lang="less" scoped>

</style>