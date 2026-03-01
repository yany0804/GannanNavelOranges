<template>
  <div class="register-container">
    <el-card class="register-card">
      <template #header>
        <h2>用户注册</h2>
      </template>
      <el-form :model="registerForm" :rules="rules" ref="registerFormRef">
        <!-- 用户名 -->
        <el-form-item prop="username">
          <el-input 
            v-model="registerForm.username"
            placeholder="用户名"
            prefix-icon="User"
          />
        </el-form-item>
        <!-- 密码 -->
        <el-form-item prop="password">
          <el-input 
            v-model="registerForm.password"
            type="password"
            placeholder="密码"
            prefix-icon="Lock"
            show-password
          />
        </el-form-item>
        <!-- 确认密码 -->
        <el-form-item prop="confirmPassword">
          <el-input 
            v-model="registerForm.confirmPassword"
            type="password"
            placeholder="确认密码"
            prefix-icon="Lock"
            show-password
          />
        </el-form-item>
        <!-- 邮箱 -->
        <el-form-item prop="email">
          <el-input 
            v-model="registerForm.email"
            placeholder="邮箱"
            prefix-icon="Message"
          />
        </el-form-item>
        <!-- 电话 -->
        <el-form-item prop="phone">
          <el-input 
            v-model="registerForm.phone"
            placeholder="电话"
            prefix-icon="Phone"
          />
        </el-form-item>
        <!-- 地址 -->
        <el-form-item prop="address">
          <el-input 
            v-model="registerForm.address"
            placeholder="地址"
            type="textarea"
            rows="4"
          />
        </el-form-item>

        <!-- 注册按钮 -->
        <el-form-item>
          <el-button type="primary" @click="handleRegister" :loading="loading" class="submit-btn">
            注册
          </el-button>
        </el-form-item>
        <!-- 登录链接 -->
        <div class="links">
          <router-link to="/login">已有账号？立即登录</router-link>
        </div>
      </el-form>
    </el-card>
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import axios from 'axios';

const router = useRouter()
const registerFormRef = ref(null)
const loading = ref(false)

const registerForm = reactive({
  username: '',
  password: '',
  confirmPassword: '',
  email: '',
  phone: '',
  address: ''
})

const validatePass2 = (rule, value, callback) => {
  if (value !== registerForm.password) {
    callback(new Error('两次输入密码不一致!'))
  } else {
    callback()
  }
}

const rules = {
  username: [
    { required: true, message: '请输入用户名', trigger: 'blur' },
    { min: 3, max: 20, message: '长度在 3 到 20 个字符', trigger: 'blur' }
  ],
  password: [
    { required: true, message: '请输入密码', trigger: 'blur' },
    { min: 6, max: 20, message: '长度在 6 到 20 个字符', trigger: 'blur' }
  ],
  confirmPassword: [
    { required: true, message: '请再次输入密码', trigger: 'blur' },
    { validator: validatePass2, trigger: 'blur' }
  ],
  email: [
    { required: true, message: '请输入邮箱地址', trigger: 'blur' },
    { type: 'email', message: '请输入有效的邮箱地址', trigger: 'blur' }
  ],
  phone: [
    { required: true, message: '请输入电话号码', trigger: 'blur' },
    { pattern: /^[0-9]{10,20}$/, message: '请输入有效的电话号码', trigger: 'blur' }
  ],
  address: [
    { required: true, message: '请输入地址', trigger: 'blur' },
    { min: 5, message: '地址至少 5 个字符', trigger: 'blur' }
  ]
}

const handleRegister = async () => {
  if (!registerFormRef.value) return

  await registerFormRef.value.validate(async (valid) => {
    if (valid) {
      loading.value = true;
      try {
          // 调用后端 API 提交注册信息
          const response = await axios.post('http://localhost:3001/users', registerForm.value);
          
            // 假设后端返回的 JSON 数据有 success 字段
            if (response.data.success) {
                // 注册成功的提示
                ElMessage.success('注册成功');
                // 跳转到登录页面
                router.push('/login');
            } else {
            // 注册失败的提示
                ElMessage.error(response.data.message || '注册失败，请稍后重试');
          }
          } catch (error) {
              console.error(error);
              ElMessage.error('注册失败，请稍后重试');
          } finally {
              loading.value = false; // 无论成功与否，取消加载状态
          }
    }
  })
}
</script>

<style scoped>
.register-container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: calc(100vh - 60px);
  /* background-color: #f5f5f5; */
  background-image:url('../../public/images/backimg.jpg');
}

.register-card {
  width: 400px;
}

.submit-btn {
  width: 100%;
}

.links {
  text-align: right;
  margin-top: 10px;
}

.links a {
  color: #409EFF;
  text-decoration: none;
}
</style> 