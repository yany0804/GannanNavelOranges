const express = require('express')
const router = express.Router()
const db = require('../config/database')

// 获取所有产品
router.get('/', async (req, res) => {
  try {
    const [products] = await db.query('SELECT * FROM products')
    res.json(products)
  } catch (error) {
    res.status(500).json({ error: error.message })
  }
})

// 获取精品产品
router.get('/premium', async (req, res) => {
  try {
    const [products] = await db.query('SELECT * FROM products WHERE category = ?', ['premium'])
    res.json(products)
  } catch (error) {
    res.status(500).json({ error: error.message })
  }
})

// 获取单个产品
router.get('/:id', async (req, res) => {
  try {
    const [products] = await db.query('SELECT * FROM products WHERE id = ?', [req.params.id])
    if (products.length > 0) {
      res.json(products[0])
    } else {
      res.status(404).json({ error: '产品不存在' })
    }
  } catch (error) {
    res.status(500).json({ error: error.message })
  }
})

module.exports = router 