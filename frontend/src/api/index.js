const API_BASE_URL = import.meta.env.VITE_API_BASE_URL

export const api = {
  // 商品相关
  async getProducts() {
    const response = await fetch(`${API_BASE_URL}/products`)
    if (!response.ok) {
      throw new Error('获取商品列表失败')
    }
    return response.json()
  },

  async getPremiumProducts() {
    const response = await fetch(`${API_BASE_URL}/products/premium`)
    if (!response.ok) {
      throw new Error('获取精品商品失败')
    }
    return response.json()
  },

  async getProductById(id) {
    const response = await fetch(`${API_BASE_URL}/products/${id}`)
    if (!response.ok) {
      throw new Error('获取商品详情失败')
    }
    return response.json()
  }
} 