<template>
  <div class="home">
    <el-carousel height="500px" class="banner">
      <el-carousel-item v-for="item in carouselItems" :key="item.id">
        <div class="carousel-content" :style="{ backgroundImage: `url(${item.image})` }">
          <div class="carousel-text">
            <h2>{{ item.title }}</h2>
            <p>{{ item.description }}</p>
          </div>
        </div>
      </el-carousel-item>
    </el-carousel>
    
    <div class="features">
      <div class="feature-item">
        <el-icon><Van /></el-icon>
        <h3>全国包邮</h3>
        <p>满99元包邮</p>
      </div>
      <div class="feature-item">
        <el-icon><ShoppingBag /></el-icon>
        <h3>品质保证</h3>
        <p>严选优质果品</p>
      </div>
      <div class="feature-item">
        <el-icon><Timer /></el-icon>
        <h3>新鲜速达</h3>
        <p>48小时内发货</p>
      </div>
      <div class="feature-item">
        <el-icon><Service /></el-icon>
        <h3>售后无忧</h3>
        <p>7天无理由退换</p>
      </div>
    </div>

    <div class="featured-products" >
      <div class="section-title">
        <h2>精选商品</h2>
        <router-link to="/products" class="view-more">查看更多 <el-icon><ArrowRight /></el-icon></router-link>
      </div>

      <el-row :gutter="30">
        <el-col :span="6" v-for="product in premiumProducts" :key="product.id">
          <el-card :body-style="{ padding: '0px' }" class="product-card">

            <div class="product-image">
              <img :src="product.image" :alt="product.name">
              <div class="product-actions">
                <el-button circle @click="addToCart(product)">
                  <el-icon><ShoppingCart /></el-icon>
                </el-button>
                <el-button circle @click="showProductDetail(product)">
                  <el-icon><View /></el-icon>
                </el-button>
               
              </div>
            </div>

            <div class="product-info">
              <h3>{{ product.name }}</h3>
              <div class="price">¥{{ product.price }}</div>
              <div class="description">{{ product.description }}</div>
            </div>
            <!-- 将 DetailDialog 组件移到这里，并传递必要的 props -->
            <!-- 弹窗子组件 -->
            <DetailDialog
              v-if="dialogVisible"
              :product="selectedProduct" 
              @close="dialogVisible = false" 
            />
          </el-card>
        </el-col>
      </el-row>
      
    </div>

    

    <div class="about-section">
      <div class="about-content">
        <h2>关于赣南脐橙</h2>
        <p>赣南脐橙以其独特的品质和口感享誉全国，产自江西省赣州市，具有国家地理标志保护。果实圆润饱满，果皮橙红，果肉细嫩多汁，香甜可口。</p>
        <el-button type="primary" @click="$router.push('/about')">了解更多</el-button>
      </div>
    </div>
  </div>

  <!-- 购物车抽屉 -->
  <el-drawer
    v-model="cartDrawerVisible"
    title="购物车     "
    direction="rtl"
    size="400px"
  >
    <div class="cart-content">
      <div v-if="cartItems.length === 0" class="empty-cart">
        <el-empty description="购物车是空的" />
      </div>
      <template v-else>
        <div class="cart-items">
          <div v-for="item in cartItems" :key="item.id" class="cart-item">
            <img :src="item.image" :alt="item.name" class="cart-item-image">
            <div class="cart-item-info">
              <h4>{{ item.name }}</h4>
              <div class="cart-item-price">¥{{ item.price }}</div>
              <el-input-number 
                v-model="item.quantity" 
                :min="1" 
                :max="99"
                size="small"
                @change="updateCartItem(item)"
              />
            </div>
            <el-button 
              circle 
              type="danger" 
              size="small"
              @click="removeFromCart(item)"
            >
              <el-icon><Delete /></el-icon>
            </el-button>
          </div>
        </div>
        <div class="cart-footer">
          <div class="cart-total">
            总计: <span>¥{{ cartTotal }}</span>
          </div>
          <el-button type="primary" @click="checkout">结算</el-button>
        </div>
      </template>
    </div>
  </el-drawer>
</template>

<script setup>
import { ref, computed,onMounted  } from 'vue'
import { useStore } from 'vuex'
import { ElMessage } from 'element-plus'
import { Van, ShoppingBag, Timer, Service, ArrowRight, ShoppingCart, View, Delete } from '@element-plus/icons-vue'
import { api } from '@/api';  // 导入 api 模块
import DetailDialog from "../components/DetailDialog.vue";

const store = useStore()
const cartDrawerVisible = ref(true)

const premiumProducts = ref([])
const loading = ref(false)

const dialogVisible = ref(false)
const selectedProduct = ref(null)

const carouselItems = ref([
  {
    id: 1,
    image: 'public/images/1.png',
    title: '赣南脐橙',
    description: '新鲜采摘，产地直发'
  },
  {
    id: 2,
    image: 'public/images/2.png',
    title: '新鲜采摘',
    description: '新鲜采摘，产地直发'
  },
  {
    id: 3,
    image: 'public/images/3.png',
    title: '产地直供',
    description: '产地直供，新鲜直达'
  }
])

// 获取精品产品数据
const fetchPremiumProducts = async () => {
  loading.value = true
  try {
    premiumProducts.value = await api.getPremiumProducts()
    console.log('Premium Products:', premiumProducts.value)
  } catch (error) {
    ElMessage.error(error.message)
  } finally {
    loading.value = false
  }
}

onMounted(fetchPremiumProducts)

const cartItems = computed(() => store.state.cart.items)
const cartTotal = computed(() => {
  return cartItems.value.reduce((total, item) => {
    return total + item.price * item.quantity
  }, 0).toFixed(2)
})

const addToCart = (product) => {
  store.dispatch('cart/addItem', product)
  ElMessage.success('已添加到购物车')
}

const removeFromCart = (item) => {
  store.dispatch('cart/removeItem', item)
}

const updateCartItem = (item) => {
  store.dispatch('cart/updateItem', item)
}

const checkout = () => {
  if (cartItems.value.length === 0) {
    ElMessage.warning('购物车是空的')
    return
  }
  // 实现结算逻辑
  ElMessage.success('正在跳转到结算页面...')
}

const showProductDetail = (product) => {
  selectedProduct.value = product
  dialogVisible.value = true
}

</script>

<style lang="scss" scoped>
// 定义主题变量
$primary-color: #ff6b01;
$secondary-color: #ffa500;
$accent-color: #ff8c00;
$bg-color: #fff9f2;
$card-bg: #ffffff;
$text-primary: #333333;
$text-secondary: #666666;
$border-color: #ffdab9;

.home {
  background-color: $bg-color;
  min-height: 100vh;
  padding-bottom: 40px;
}

.banner {
  margin-bottom: 40px;
  
  .carousel-content {
    height: 100%;
    background-size: cover;
    background-position: center;
    position: relative;
    
    &::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: rgba(0, 0, 0, 0.3);
    }
  }
  
  .carousel-text {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    color: white;
    text-align: center;
    
    h2 {
      font-size: 48px;
      margin-bottom: 20px;
    }
    
    p {
      font-size: 24px;
    }
  }
}

.features {
  display: flex;
  justify-content: space-around;
  max-width: 1200px;
  margin: 0 auto 60px;
  padding: 0 20px;
  
  .feature-item {
    text-align: center;
    padding: 20px;
    
    .el-icon {
      font-size: 40px;
      color: $primary-color;
      margin-bottom: 16px;
    }
    
    h3 {
      color: $text-primary;
      margin-bottom: 8px;
    }
    
    p {
      color: $text-secondary;
    }
  }
}

.featured-products {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
  
  .section-title {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
    
    h2 {
      font-size: 28px;
      color: $text-primary;
    }
    
    .view-more {
      color: $primary-color;
      text-decoration: none;
      display: flex;
      align-items: center;
      gap: 4px;
      
      &:hover {
        color: $accent-color;
      }
    }
  }
  
  .product-card {
    transition: all 0.3s ease;
    margin-bottom: 20px;
    
    &:hover {
      transform: translateY(-5px);
      box-shadow: 0 4px 12px rgba($primary-color, 0.15);
      
      .product-actions {
        opacity: 1;
      }
    }
  }
  
  .product-image {
    position: relative;
    height: 200px;
    overflow: hidden;
    
    img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
    
    .product-actions {
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: rgba(0, 0, 0, 0.5);
      display: flex;
      justify-content: center;
      align-items: center;
      gap: 16px;
      opacity: 0;
      transition: opacity 0.3s ease;
    }
  }
  
  .product-info {
    padding: 16px;
    text-align: center;
    
    h3 {
      color: $text-primary;
      margin-bottom: 8px;
    }
    
    .price {
      color: $primary-color;
      font-size: 20px;
      font-weight: bold;
      margin-bottom: 8px;
    }
    
    .description {
      color: $text-secondary;
      font-size: 14px;
      line-height: 1.5;
    }
  }
}

.about-section {
  background: linear-gradient(135deg, $primary-color, $secondary-color);
  padding: 60px 20px;
  margin-top: 60px;
  color: white;
  
  .about-content {
    max-width: 800px;
    margin: 0 auto;
    text-align: center;
    
    h2 {
      font-size: 36px;
      margin-bottom: 20px;
    }
    
    p {
      font-size: 16px;
      line-height: 1.6;
      margin-bottom: 30px;
    }
    
    .el-button {
      background-color: white;
      color: $primary-color;
      border: none;
      
      &:hover {
        background-color: darken(white, 5%);
      }
    }
  }
}

.cart-content {
  padding: 20px;
  
  .cart-items {
    .cart-item {
      display: flex;
      align-items: center;
      padding: 10px 0;
      border-bottom: 1px solid $border-color;
      
      .cart-item-image {
        width: 80px;
        height: 80px;
        object-fit: cover;
        margin-right: 16px;
      }
      
      .cart-item-info {
        flex: 1;
        
        h4 {
          margin-bottom: 8px;
          color: $text-primary;
        }
        
        .cart-item-price {
          color: $primary-color;
          font-weight: bold;
          margin-bottom: 8px;
        }
      }
    }
  }
  
  .cart-footer {
    margin-top: 20px;
    padding-top: 20px;
    border-top: 1px solid $border-color;
    
    .cart-total {
      font-size: 18px;
      margin-bottom: 16px;
      text-align: right;
      
      span {
        color: $primary-color;
        font-weight: bold;
      }
    }
  }
}
</style> 