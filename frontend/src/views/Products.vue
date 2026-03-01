<template>
  <div class="products-container">
    <div class="filters">
      <el-card>
        <el-form :inline="true" :model="filters">
          <el-form-item label="价格区间 ">
            <el-select v-model="filters.priceRange">
              <el-option label="全部" value="" />
              <el-option label="0-50元" value="0-50" />
              <el-option label="50-100元" value="50-100" />
              <el-option label="100元以上" value="100+" />
            </el-select>
          </el-form-item>
          <el-form-item label="排序">
            <el-select v-model="filters.sort">
              <el-option label="默认排序" value="" />
              <el-option label="价格从低到高" value="price-asc" />
              <el-option label="价格从高到低" value="price-desc" />
            </el-select>
          </el-form-item>
        </el-form>
      </el-card>
    </div>

    <div class="products-list">
      <el-row :gutter="20">
        <el-col :span="6" v-for="product in filteredProducts" :key="product.id">
          <el-card :body-style="{ padding: '0px' }" class="product-card">
            <img :src="product.image" class="product-image">
            <div class="product-info">
              <h3>{{ product.name }}</h3>
              <div class="price">¥{{ product.price }}</div>
              <div class="description">{{ product.description }}</div>
              <div class="actions">
                <el-button type="primary" @click="addToCart(product)">加入购物车</el-button>
              </div>
            </div>
          </el-card>
        </el-col>
      </el-row>
    </div>

    <div class="pagination">
      <el-pagination
        background
        layout="prev, pager, next"
        :total="total"
        :page-size="pageSize"
        @current-change="handlePageChange"
      />
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { api } from '../api'

const products = ref([])
const loading = ref(false)

const filters = reactive({
  priceRange: '',
  sort: ''
})

// 获取产品数据
const fetchProducts = async () => {
  loading.value = true
  try {
    products.value = await api.getProducts()
  } catch (error) {
    ElMessage.error(error.message)
  } finally {
    loading.value = false
  }
}

onMounted(fetchProducts)

const pageSize = 8
const total = ref(products.value.length)

const filteredProducts = computed(() => {
  let result = [...products.value]
  
  // 价格筛选
  if (filters.priceRange) {
    const [min, max] = filters.priceRange.split('-')
    result = result.filter(product => {
      if (max === '+') {
        return product.price >= Number(min)
      }
      return product.price >= Number(min) && product.price <= Number(max)
    })
  }
  
  // 排序
  if (filters.sort) {
    result.sort((a, b) => {
      if (filters.sort === 'price-asc') {
        return a.price - b.price
      }
      return b.price - a.price
    })
  }
  
  return result
})

const handlePageChange = (page) => {
  console.log('当前页:', page)
  // 这里应该调用API获取对应页码的数据
}

const addToCart = (product) => {
  
  ElMessage.success(`已将 ${product.name} 加入购物车`)
}
</script>

<style scoped>
.products-container {
  padding: 20px;
  max-width: 1200px;
  margin: 0 auto;
}

.filters {
  margin-bottom: 20px;
}

.product-card {
  margin-bottom: 20px;
  transition: transform 0.3s;
}

.product-card:hover {
  transform: translateY(-5px);
}

.product-image {
  width: 100%;
  height: 200px;
  object-fit: cover;
}

.product-info {
  padding: 14px;
}

.price {
  color: #f56c6c;
  font-size: 20px;
  font-weight: bold;
  margin: 10px 0;
}

.description {
  color: #666;
  font-size: 14px;
  margin-bottom: 10px;
}

.actions {
  text-align: center;
}

.pagination {
  margin-top: 20px;
  text-align: center;
}
</style> 