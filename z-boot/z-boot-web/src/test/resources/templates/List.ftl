<template>
  <a-card :bordered="false">
    <!-- 查询区域 -->
    <div class="table-page-search-wrapper">
      <a-form layout="inline" @keyup.enter.native="searchQuery">
        <a-row :gutter="24">
<#list table.fields as po>
<#if po.name !='id' && po_index<= 2>
          <a-col :xl="6" :lg="7" :md="8" :sm="24">
            <a-form-item label="${po.comment}">
              <a-input placeholder="请输入${po.comment}" v-model="queryParam.${po.name}"></a-input>
            </a-form-item>
          </a-col>
<#elseif po.name !='id' && po_index == 3>
          <template v-if="toggleSearchStatus">
            <a-col :xl="6" :lg="7" :md="8" :sm="24">
              <a-form-item label="${po.comment}">
                <a-input placeholder="请输入${po.comment}" v-model="queryParam.${po.name}"></a-input>
              </a-form-item>
            </a-col>
<#elseif po.name !='id' && po_index< 8>
            <a-col :xl="6" :lg="7" :md="8" :sm="24">
              <a-form-item label="${po.comment}">
                <a-input placeholder="请输入${po.comment}" v-model="queryParam.${po.name}"></a-input>
              </a-form-item>
            </a-col>
<#else>
</#if>
</#list>
        <#if (table.fields?size>1) >
          </template>
        </#if>
          <a-col :xl="6" :lg="7" :md="8" :sm="24">
            <span style="float: left;overflow: hidden;" class="table-page-search-submitButtons">
              <a-button type="primary" @click="searchQuery" icon="search">查询</a-button>
              <a-button type="primary" @click="searchReset" icon="reload" style="margin-left: 8px">重置</a-button>
              <a @click="handleToggleSearch" style="margin-left: 8px">
                {{ toggleSearchStatus ? '收起' : '展开' }}
                <a-icon :type="toggleSearchStatus ? 'up' : 'down'"/>
              </a>
            </span>
          </a-col>
        </a-row>
      </a-form>
    </div>

    <!-- 操作按钮区域 -->
    <div class="table-operator">
      <a-button @click="handleAdd" type="primary" icon="plus">新增</a-button>
      <a-button type="primary" icon="download" @click="handleExportXls('${table.comment}')">导出</a-button>
<#--      <a-upload name="file" :showUploadList="false" :multiple="false" :headers="tokenHeader" :action="importExcelUrl" @change="handleImportExcel">-->
<#--        <a-button type="primary" icon="import">导入</a-button>-->
<#--      </a-upload>-->
      <a-dropdown v-if="selectedRowKeys.length > 0">
        <a-menu slot="overlay">
          <a-menu-item key="1" @click="batchDel"><a-icon type="delete"/>删除</a-menu-item>
        </a-menu>
        <a-button style="margin-left: 8px"> 批量操作 <a-icon type="down" /></a-button>
      </a-dropdown>
    </div>

    <!-- table区域-begin -->
    <div>
      <div class="ant-alert ant-alert-info" style="margin-bottom: 16px;">
        <i class="anticon anticon-info-circle ant-alert-icon"></i> 已选择 <a style="font-weight: 600">{{ selectedRowKeys.length }}</a>项
        <a style="margin-left: 24px" @click="onClearSelected">清空</a>
      </div>
      <a-table
        ref="table"
        size="middle"
        bordered
        rowKey="id"
        :columns="columns"
        :dataSource="dataSource"
        :pagination="ipagination"
        :loading="loading"
        class="j-table-force-nowrap"
        :rowSelection="{selectedRowKeys: selectedRowKeys, onChange: onSelectChange}"
        @change="handleTableChange">
        <span slot="action" slot-scope="text, record">
          <a @click="handleEdit(record)">编辑</a>
          <a-divider type="vertical" />
          <a-dropdown>
            <a class="ant-dropdown-link">更多 <a-icon type="down" /></a>
            <a-menu slot="overlay">
              <a-menu-item>
                <a-popconfirm title="确定删除吗?" @confirm="() => handleDelete(record.id)">
                  <a>删除</a>
                </a-popconfirm>
              </a-menu-item>
            </a-menu>
          </a-dropdown>
        </span>
      </a-table>
    </div>
    <!-- table区域-end -->

    <!-- 表单区域 -->
    <${table.entityName?uncap_first}-modal ref="modalForm" @ok="modalFormOk"></${table.entityName?uncap_first}-modal>
  </a-card>
</template>

<script>
  import ${table.entityName}Modal from './modules/${table.entityName}Modal'
  import { ListMixin } from '@/mixins/ListMixin'

  export default {
    name: "${table.entityName}List",
    mixins:[ListMixin],
    components: {
      ${table.entityName}Modal
    },
    data () {
      return {
        description: '${table.comment}管理页面',
        // 表头
        columns: [
          {
            title: '#',
            dataIndex: '',
            key:'rowIndex',
            width:60,
            align:"center",
            customRender:function (t,r,index) {
              return parseInt(index)+1;
            }
           },
          <#list table.fields as po>
           <#if po.name !='id'>
		   {
            title: '${po.comment}',
            align:"center",
            dataIndex: '${po.name}'
           },
		   </#if>
		  </#list>
          {
            title: '操作',
            dataIndex: 'action',
            align:"center",
            scopedSlots: { customRender: 'action' },
          }
        ],
		url: {
          list: "/${package.ModuleName}/${table.entityName?uncap_first}/list",
          delete: "/${package.ModuleName}/${table.entityName?uncap_first}/delete",
          deleteBatch: "/${package.ModuleName}/${table.entityName?uncap_first}/deleteBatch",
          exportXlsUrl: "${package.ModuleName}/${table.entityName?uncap_first}/exportXls"
        },
      }
    },
    computed: {
    },
    methods: {
    }
  }
</script>