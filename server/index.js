const express = require('express')
const cors = require('cors')
const productsRouter = require('./routes/products')
const db = require('./config/database')


const app = express()
const port = process.env.port_val

// 中间件
app.use(cors())
app.use(express.json())

// 静态文件服务
app.use('/images', express.static('public/images'))

// 路由
app.use('/api/products', productsRouter)

// 错误处理中间件
app.use((err, req, res, next) => {
  console.error(err.stack)
  res.status(500).json({ error: '服务器内部错误' })
})

// 启动服务器前确保数据库连接
db.getConnection()
  .then(() => {
    app.listen(port, () => {
      console.log(`服务器运行在 http://localhost:${port}`)
    })
  })
  .catch(err => {
    console.error('无法启动服务器:', err)
  }) 



