<template>
  <div class="nav-container">
    <el-menu
      :default-active="currentPath"
      class="nav-menu"
      mode="horizontal"
      router
    >
      <el-menu-item index="/">
        <el-icon><House /></el-icon>
        首页
      </el-menu-item>
      <el-menu-item index="/products">
        <el-icon><ShoppingBag /></el-icon>
        全部商品
      </el-menu-item>
      <el-menu-item index="/premium">
        <el-icon><Star /></el-icon>
        精品脐橙
      </el-menu-item>
      <el-menu-item index="/About">
        <el-icon><Message /></el-icon>
        关于我们
      </el-menu-item>
      <div class="flex-grow" />
      <template v-if="!loginState">
        <el-menu-item index="/login">
          <el-icon><User /></el-icon>登录 </el-menu-item>
        <el-menu-item index="/register">注册</el-menu-item>
      </template>
      <el-menu-item v-else @click="handleLogout">退出</el-menu-item>
    </el-menu>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { useStore } from 'vuex'
import { House, ShoppingBag, Star, User } from '@element-plus/icons-vue'

const router = useRouter()
const route = useRoute()
const store = useStore()

const currentPath = computed(() => route.path)
const loginState = computed(() => {
  try {
    return store?.state?.user?.isLoggedIn || false
  } catch {
    return false
  }
})

const handleLogout = () => {
  try {
    store.dispatch('user/logout')
    router.push('/login')
  } catch (error) {
    console.error('Logout failed:', error)
  }
}
</script>

<style scoped>
.nav-container {
  position: sticky;
  top: 0;
  z-index: 100;
}

.nav-menu {
  padding: 0 20px;
  background-color: #fff;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.flex-grow {
  flex-grow: 1;
}

.el-menu-item {
  font-size: 16px;
  display: flex;
  align-items: center;
}

.el-icon {
  margin-right: 4px;
}
</style> 