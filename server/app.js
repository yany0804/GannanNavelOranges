const express = require('express')
const cors = require('cors')
const productsRouter = require('./routes/products')
const { sequelize } = require('./models/Product')

const app = express()
const port = process.env.port_val

app.use(cors())
app.use(express.json())
app.use('/api/products', productsRouter)

// 初始化数据库
sequelize.sync({ force: true }).then(async () => {
  // 添加示例数据
  await Product.bulkCreate([
    {
      name: '赣南脐橙 精品礼盒',
      price: 88,
      image: '/images/product1.jpg',
      description: '精选优质脐橙，礼盒包装，送礼首选',
      category: 'normal'
    },
    {
      name: '赣南脐橙 家庭装',
      price: 58,
      image: '/images/product2.jpg',
      description: '实惠家庭装，新鲜多汁',
      category: 'normal'
    },
    {
      name: '赣南脐橙 臻品礼盒',
      price: 168,
      image: '/images/premium1.jpg',
      description: '精选特级赣南脐橙，单果重250g以上',
      category: 'premium',
      features: ['特级果', '礼盒装', '产地直发']
    }
  ])
})

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`)
}) 