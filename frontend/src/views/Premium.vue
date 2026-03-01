<template>
  <div class="premium-container">
    <div class="banner">
      <h1>精品脐橙专区</h1>
      <p>严选优质赣南脐橙，品质保证</p>
    </div>

    <div class="premium-products">
      <el-row :gutter="30">
        <el-col :span="8" v-for="product in premiumProducts" :key="product.id">
          <el-card class="premium-card">
            <div class="premium-badge">精品</div>
            <img :src="product.image" class="premium-image">
            <div class="premium-info">
              <h2>{{ product.name }}</h2>
              <div class="features">
                <el-tag v-for="feature in product.features" :key="feature">
                  {{ feature }}
                </el-tag>
              </div>
              <div class="price">¥{{ product.price }}</div>
              <div class="description">{{ product.description }}</div>
              <div class="actions">
                <el-button type="danger" @click="addToCart(product)">立即购买</el-button>
                <el-button @click="showDetails(product)">查看详情</el-button>
              </div>
            </div>
          </el-card>
        </el-col>
      </el-row>
    </div>

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
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { api } from '../api'

const premiumProducts = ref([])
const loading = ref(false)
const dialogVisible = ref(false)
const selectedProduct = ref(null)

// 获取精品产品数据
const fetchPremiumProducts = async () => {
  loading.value = true
  try {
    premiumProducts.value = await api.getPremiumProducts()
  } catch (error) {
    ElMessage.error(error.message)
  } finally {
    loading.value = false
  }
}

onMounted(fetchPremiumProducts)

const addToCart = (product) => {
  ElMessage.success(`已将 ${product.name} 加入购物车`)
}

const showDetails = (product) => {
  selectedProduct.value = product
  dialogVisible.value = true
}
</script>

<style scoped>
.premium-container {
  padding: 20px;
  max-width: 1200px;
  margin: 0 auto;
}

.banner {
  text-align: center;
  padding: 40px 0;
  background: linear-gradient(135deg, #ff9a44 0%, #fc6076 100%);
  color: white;
  border-radius: 8px;
  margin-bottom: 40px;
}

.banner h1 {
  font-size: 36px;
  margin-bottom: 10px;
}

.premium-card {
  margin-bottom: 30px;
  position: relative;
  overflow: hidden;
}

.premium-badge {
  position: absolute;
  top: 10px;
  right: 10px;
  background-color: #f56c6c;
  color: white;
  padding: 5px 10px;
  border-radius: 4px;
}

.premium-image {
  width: 100%;
  height: 250px;
  object-fit: cover;
}

.premium-info {
  padding: 20px;
}

.features {
  margin: 10px 0;
}

.features .el-tag {
  margin-right: 5px;
  margin-bottom: 5px;
}

.price {
  color: #f56c6c;
  font-size: 24px;
  font-weight: bold;
  margin: 10px 0;
}

.description {
  color: #666;
  margin-bottom: 15px;
}

.actions {
  display: flex;
  gap: 10px;
}

.detail-image {
  width: 100%;
  max-height: 300px;
  object-fit: cover;
  border-radius: 4px;
}

.detail-content {
  padding: 20px 0;
}

.detail-price {
  font-size: 20px;
  color: #f56c6c;
  margin-top: 20px;
}
</style> 