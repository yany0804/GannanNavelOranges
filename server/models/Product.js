const { Sequelize, DataTypes } = require('sequelize')
const sequelize = new Sequelize({
  dialect: 'sqlite',
  storage: './db/database.sqlite'
})

const Product = sequelize.define('Product', {
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  name: {
    type: DataTypes.STRING,
    allowNull: false
  },
  price: {
    type: DataTypes.DECIMAL(10, 2),
    allowNull: false
  },
  image: {
    type: DataTypes.STRING,
    allowNull: false
  },
  description: {
    type: DataTypes.TEXT
  },
  category: {
    type: DataTypes.STRING,
    allowNull: false
  },
  features: {
    type: DataTypes.TEXT,
    get() {
      const rawValue = this.getDataValue('features')
      return rawValue ? JSON.parse(rawValue) : []
    },
    set(value) {
      this.setDataValue('features', JSON.stringify(value))
    }
  }
})

module.exports = Product 