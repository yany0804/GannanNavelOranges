// 商品数据
const defaultImage = new URL('../assets/vue.svg', import.meta.url).href

export const products = [
  {
    id: 1,
    name: '赣南脐橙 精品礼盒',
    price: 88,
    image: defaultImage,
    description: '精选优质脐橙，礼盒包装，送礼首选'
  },
  {
    id: 2,
    name: '赣南脐橙 家庭装',
    price: 58,
    image: '/src/assets/images/product2.jpg',
    description: '实惠家庭装，新鲜多汁'
  },
  {
    id: 3,
    name: '赣南脐橙 尝鲜装',
    price: 29.9,
    image: '/src/assets/images/product3.jpg',
    description: '小包装尝鲜，甜蜜多汁'
  }
]

// 精品商品数据
export const premiumProducts = [
  {
    id: 1,
    name: '赣南脐橙 臻品礼盒',
    price: 168,
    image: '/src/assets/images/premium1.jpg',
    features: ['特级果', '礼盒装', '产地直发'],
    description: '精选特级赣南脐橙，单果重250g以上，口感细腻，汁水充沛'
  },
  {
    id: 2,
    name: '赣南脐橙 黄金果',
    price: 128,
    image: '/src/assets/images/premium2.jpg',
    features: ['黄金果', '生态种植', '新鲜采摘'],
    description: '黄金果系列，果形端正，色泽金黄，果肉细嫩多汁'
  },
  {
    id: 3,
    name: '赣南脐橙 有机认证',
    price: 198,
    image: '/src/assets/images/premium3.jpg',
    features: ['有机认证', '生态种植', '营养丰富'],
    description: '有机认证脐橙，无农药残留，绿色健康食品'
  }
]

// 用户数据
// 仅供演示的 Mock 数据
export const users = [
  {
    id: 1,
    username: 'admin',
    password: import.meta.env.VITE_TEST_PASSWORD || ''
  }
] 