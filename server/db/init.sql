-- 创建数据库
CREATE DATABASE IF NOT EXISTS gannan_mall;
USE gannan_mall;

-- 创建产品表
CREATE TABLE IF NOT EXISTS products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    image VARCHAR(255) NOT NULL,
    description TEXT,
    category ENUM('normal', 'premium') NOT NULL,
    features JSON,
    stock INT NOT NULL DEFAULT 100,
    sales INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 创建用户表
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 创建订单表
CREATE TABLE IF NOT EXISTS orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    status ENUM('pending', 'paid', 'shipped', 'completed', 'cancelled') NOT NULL,
    shipping_address TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- 创建订单详情表
CREATE TABLE IF NOT EXISTS order_items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- 插入示例产品数据
INSERT INTO products (name, price, image, description, category, features, stock) VALUES
('赣南脐橙 精品礼盒', 88.00, '/images/product1.jpg', '精选优质脐橙，礼盒包装，送礼首选。果形端正，色泽金黄，果肉细嫩多汁。', 'normal', '["优质果", "礼盒装", "送礼首选"]', 200),
('赣南脐橙 家庭装', 58.00, '/images/product2.jpg', '实惠家庭装，新鲜多汁。每箱约5kg，适合家庭日常食用。', 'normal', '["实惠装", "家庭装", "新鲜直达"]', 300),
('赣南脐橙 尝鲜装', 29.90, '/images/product3.jpg', '小包装尝鲜，甜蜜多汁。约2kg装，适合单人或小家庭。', 'normal', '["小包装", "尝鲜装", "新手推荐"]', 500),
('赣南脐橙 臻品礼盒', 168.00, '/images/premium1.jpg', '精选特级赣南脐橙，单果重250g以上，口感细腻，汁水充沛。高端礼盒包装，送礼体面。', 'premium', '["特级果", "礼盒装", "产地直发", "单果250g+"]', 100),
('赣南脐橙 黄金果', 128.00, '/images/premium2.jpg', '黄金果系列，果形端正，色泽金黄，果肉细嫩多汁。精选特级果，保证品质。', 'premium', '["黄金果", "生态种植", "新鲜采摘", "特级果"]', 150),
('赣南脐橙 有机认证', 198.00, '/images/premium3.jpg', '有机认证脐橙，无农药残留，绿色健康食品。采用生态种植方式，保证果品品质。', 'premium', '["有机认证", "生态种植", "营养丰富", "无农药"]', 80),
('赣南脐橙 儿童装', 45.00, '/images/product4.jpg', '专为儿童设计的小果装，果径适中，方便儿童食用。精选无农药果品，安全健康。', 'normal', '["儿童装", "安全健康", "适中果径"]', 200),
('赣南脐橙 商务礼盒', 258.00, '/images/premium4.jpg', '高端商务礼盒，精美包装，内含12个特级果。送礼首选，展现品味与诚意。', 'premium', '["商务礼盒", "精美包装", "特级果", "送礼首选"]', 50),
('赣南脐橙 超值装', 99.00, '/images/product5.jpg', '超值大包装，约8kg装。适合团购或家庭储存，性价比极高。', 'normal', '["超值装", "大包装", "团购优选"]', 150),
('赣南脐橙 精品小果', 68.00, '/images/product6.jpg', '精选小果装，果径适中，口感极佳。适合送礼或自用。', 'normal', '["精品小果", "口感佳", "送礼自用"]', 200),
('赣南脐橙 至尊礼盒', 328.00, '/images/premium5.jpg', '至尊豪华礼盒，甄选特级果中的极品。采用高端礼盒包装，送礼倍有面子。', 'premium', '["至尊礼盒", "特级极品", "豪华包装", "送礼佳选"]', 30),
('赣南脐橙 年货礼盒', 188.00, '/images/premium6.jpg', '专为年货定制的礼盒装，内含优质脐橙。传统喜庆包装，年节送礼首选。', 'premium', '["年货礼盒", "喜庆包装", "优质果品", "节日特供"]', 100);

-- 插入测试用户
INSERT INTO users (username, password, email, phone, address) VALUES
('test', '$2a$10$xPJ5SzqDJ5i4VR6UiBU6NOv0yxQxP.0S1F5XUwtQMX5h5GXp5XK6', 'test@example.com', '13800138000', '北京市朝阳区xxx街道'),
('user1', '$2a$10$xPJ5SzqDJ5i4VR6UiBU6NOv0yxQxP.0S1F5XUwtQMX5h5GXp5XK6', 'user1@example.com', '13800138001', '上海市浦东新区xxx路'),
('user2', '$2a$10$xPJ5SzqDJ5i4VR6UiBU6NOv0yxQxP.0S1F5XUwtQMX5h5GXp5XK6', 'user2@example.com', '13800138002', '广州市天河区xxx号'),
('user3', '$2a$10$xPJ5SzqDJ5i4VR6UiBU6NOv0yxQxP.0S1F5XUwtQMX5h5GXp5XK6', 'user3@example.com', '13800138003', '深圳市南山区xxx路'),
('user4', '$2a$10$xPJ5SzqDJ5i4VR6UiBU6NOv0yxQxP.0S1F5XUwtQMX5h5GXp5XK6', 'user4@example.com', '13800138004', '杭州市西湖区xxx街');

-- 插入订单数据
INSERT INTO orders (user_id, total_amount, status, shipping_address) VALUES
(1, 176.00, 'completed', '北京市朝阳区xxx街道 张三 13800138000'),
(1, 258.00, 'shipped', '北京市朝阳区xxx街道 张三 13800138000'),
(2, 88.00, 'paid', '上海市浦东新区xxx路 李四 13800138001'),
(2, 168.00, 'pending', '上海市浦东新区xxx路 李四 13800138001'),
(3, 328.00, 'completed', '广州市天河区xxx号 王五 13800138002'),
(3, 198.00, 'shipped', '广州市天河区xxx号 王五 13800138002'),
(4, 99.00, 'cancelled', '深圳市南山区xxx路 赵六 13800138003'),
(4, 188.00, 'pending', '深圳市南山区xxx路 赵六 13800138003'),
(5, 128.00, 'completed', '杭州市西湖区xxx街 孙七 13800138004'),
(5, 258.00, 'paid', '杭州市西湖区xxx街 孙七 13800138004');

-- 插入订单详情数据
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
-- 订单1的商品
(1, 1, 2, 88.00),  -- 2个精品礼盒
-- 订单2的商品
(2, 8, 1, 258.00), -- 1个商务礼盒
-- 订单3的商品
(3, 1, 1, 88.00),  -- 1个精品礼盒
-- 订单4的商品
(4, 4, 1, 168.00), -- 1个臻品礼盒
-- 订单5的商品
(5, 11, 1, 328.00), -- 1个至尊礼盒
-- 订单6的商品
(6, 6, 1, 198.00), -- 1个有机认证
-- 订单7的商品
(7, 9, 1, 99.00),  -- 1个超值装
-- 订单8的商品
(8, 12, 1, 188.00), -- 1个年货礼盒
-- 订单9的商品
(9, 5, 1, 128.00), -- 1个黄金果
-- 订单10的商品
(10, 8, 1, 258.00); -- 1个商务礼盒

-- 更新产品销量数据
UPDATE products SET sales = 
  CASE id
    WHEN 1 THEN 3  -- 精品礼盒
    WHEN 4 THEN 1  -- 臻品礼盒
    WHEN 5 THEN 1  -- 黄金果
    WHEN 6 THEN 1  -- 有机认证
    WHEN 8 THEN 2  -- 商务礼盒
    WHEN 9 THEN 1  -- 超值装
    WHEN 11 THEN 1 -- 至尊礼盒
    WHEN 12 THEN 1 -- 年货礼盒
    ELSE 0
  END;

-- 更新产品库存数据
UPDATE products SET stock = 
  CASE id
    WHEN 1 THEN 197  -- 精品礼盒 (原200-3)
    WHEN 4 THEN 99   -- 臻品礼盒 (原100-1)
    WHEN 5 THEN 149  -- 黄金果 (原150-1)
    WHEN 6 THEN 79   -- 有机认证 (原80-1)
    WHEN 8 THEN 48   -- 商务礼盒 (原50-2)
    WHEN 9 THEN 149  -- 超值装 (原150-1)
    WHEN 11 THEN 29  -- 至尊礼盒 (原30-1)
    WHEN 12 THEN 99  -- 年货礼盒 (原100-1)
    ELSE stock       -- 其他商品保持原库存
  END;

-- 添加一些测试用户的订单统计视图
CREATE OR REPLACE VIEW user_order_stats AS
SELECT 
    u.username,
    COUNT(o.id) as total_orders,
    SUM(o.total_amount) as total_spent,
    MAX(o.created_at) as last_order_date
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.id, u.username;

-- 添加商品销售统计视图
CREATE OR REPLACE VIEW product_sales_stats AS
SELECT 
    p.name,
    p.category,
    p.price,
    p.sales,
    p.stock,
    (p.price * p.sales) as total_revenue
FROM products p
ORDER BY total_revenue DESC;