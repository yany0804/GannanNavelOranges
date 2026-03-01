<template>
    <el-dialog
      v-model="dialogVisible"
      :title="selectedProduct?.name"
      width="50%"
    >
      <div v-if="selectedProduct" class="product-details">
        <img :src="selectedProduct.image" class="detail-image">
        <div class="detail-content">
          <h3>商品特点</h3>
          <ul>
            <li v-for="feature in selectedProduct.features" :key="feature">
              {{ feature }}
            </li>
          </ul>
          <h3>商品描述</h3>
          <p>{{ selectedProduct.description }}</p>
          <div class="detail-price">
            价格: ¥{{ selectedProduct.price }}
          </div>
        </div>
      </div>
    </el-dialog>
  </template>
  
  <script setup>
  import { defineProps, ref, watch } from 'vue'
  
  const props = defineProps({
    product: Object
  })
  
  const dialogVisible = ref(false)
  const selectedProduct = ref(null)
  
  watch(() => props.product, (newProduct) => {
    if (newProduct) {
      selectedProduct.value = newProduct
      dialogVisible.value = true
    }
  })
  
  watch(dialogVisible, (newVal) => {
    if (!newVal) {
      selectedProduct.value = null
    }
  })
  </script>
  
  <style scoped>
  /* 弹窗样式 */
  .el-dialog {
    padding: 0; /* 去除默认的内边距 */
  }
  
  .product-details {
    display: flex;
    justify-content: space-between;
    padding: 20px;
  }
  
  .detail-image {
    width: 200px;
    height: 200px;
    object-fit: cover;
    margin-right: 20px;
    border-radius: 8px;
  }
  
  .detail-content {
    flex-grow: 1;
  }
  
  h3 {
    font-size: 18px;
    color: #333;
    margin-bottom: 10px;
  }
  
  ul {
    list-style: none;
    padding-left: 0;
  }
  
  ul li {
    margin-bottom: 5px;
    font-size: 14px;
    color: #666;
  }
  
  .detail-price {
    font-size: 18px;
    font-weight: bold;
    color: #e87e04;
    margin-top: 20px;
  }
  
  /* 弹窗标题样式 */
  .el-dialog__header {
    background-color: #f5f5f5;
    color: #333;
    font-size: 18px;
    font-weight: 600;
  }
  
  /* 调整按钮位置 */
  .el-dialog__footer {
    display: flex;
    justify-content: flex-end;
    padding: 10px 20px;
  }
  
  .el-dialog__footer .el-button {
    margin-left: 10px;
  }
  </style>
  