<template>
  <div class="about-page">
    <div class="about-page-content">
      <h1>赣南脐橙详细介绍</h1>
      <br>
      <p>赣南脐橙，产自中国江西省赣州市，是一种享有国家地理标志保护的优质水果。其果实圆润饱满，果皮鲜艳橙红，果肉细嫩多汁，口感香甜可口，深受消费者喜爱。</p>
      
      <h2>品种特点</h2>
      <ul>
        <li>独特的地理环境赋予了赣南脐橙卓越的品质。</li>
        <li>富含多种维生素和矿物质，对人体健康有益。</li>
        <li>果实在每年秋季成熟，是秋季水果中的佼佼者。</li>
      </ul>
      
      <h2>种植与采摘</h2>
      <p>赣南脐橙的种植过程严格遵循绿色生态原则，采用先进的农业技术和管理模式。采摘时节，果农们会精心挑选每一颗成熟的果实，确保消费者能够品尝到最佳口感的赣南脐橙。</p>
      
      <h2>荣誉认证</h2>
      <ul>
        <li>2001年赣南脐橙获中国绿色食品发展中心“绿色食品”A级奖。</li>
        <li>2003年赣南脐橙已被批准为中华人民共和国地理标志保护产品。</li>
        <li>2011年国家工商总局商标局批准“赣南脐橙”地理标志证明商标为中国驰名商标。</li>
        <li>2019年11月15日，赣南脐橙入选中国农业品牌目录。</li>
        <li>2020年7月20日，赣南脐橙入选中欧地理标志首批保护清单。</li>
        <li>2023年5月12日，赣南脐橙入选区域品牌（地理标志）100强，位列第5位。</li>
      </ul>

      <h2>历史文化</h2>
      <p>为了更好地推广赣州脐橙，提升“赣南脐橙”的效益和影响力，赣州从2002年开始在脐橙的收获季节（每年的11月）举办“中国（赣州）国际脐橙节”，利用开展节庆活动，进行营销，走出了全方位打造“赣南脐橙”品牌的关键一步。</p>
      <p>赣州市在中央电视台播放赣南脐橙广告，积极组织参加全国各地举办的农产品展示展销会，通过展示展销宣传赣南脐橙。此外，赣州市人民还为赣南脐橙拍摄专题电影《赣南之恋》、动画片《脐橙寻宝记》等，其创作的戏剧《快乐标兵》还荣获国家“五个一”工程奖，这些文化形式都大大提高赣南脐橙品牌知晓度，形成了独特的“脐橙经济”。</p>
      
      <el-button type="primary" @click="$router.push('/')">返回首页</el-button>
    </div>
  </div>
</template>

<script setup>
</script>

<style scoped>
/* 页面整体样式 */
.about-page {
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  background-color: #f0f4f8;
  padding: 20px;
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  transition: background-color 0.3s ease;
}

/* 内容容器样式 */
.about-page-content {
  max-width: 960px;
  background-color: #ffffff;
  padding: 40px;
  border-radius: 12px;
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
  text-align: center;
  transition: transform 0.3s ease;
}

.about-page-content:hover {
  transform: scale(1.02);
}

/* 页面标题样式 */
.about-page-content h1 {
  font-size: 36px;
  color: #FF8C00;
  font-weight: 700;
  margin-bottom: 24px;
  letter-spacing: 1px;
  text-transform: uppercase;
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
}

/* 页面段落文本 */
.about-page-content p {
  font-size: 18px;
  color: #333;
  line-height: 1.8;
  margin-bottom: 20px;
  text-align: justify;
  letter-spacing: 0.5px;
  transition: color 0.3s ease;
}

.about-page-content p:hover {
  color: #FF8C00;
}

/* 二级标题样式 */
.about-page-content h2 {
  font-size: 28px;
  color: #FF8C00;
  margin-top: 24px;
  margin-bottom: 18px;
  font-weight: 600;
  text-align: left;
  text-transform: capitalize;
}

/* 无序列表样式 */
.about-page-content ul {
  list-style-type: none;
  padding-left: 0;
  text-align: left;
  font-size: 18px;
  color: #333;
}

.about-page-content ul li {
  position: relative;
  padding-left: 40px;
  margin-bottom: 12px;
  transition: background-color 0.3s ease;
}

.about-page-content ul li:hover {
  background-color: #f8f8f8;
  border-radius: 8px;
}

.about-page-content ul li::before {
  content: '🍊';
  position: absolute;
  left: 10px;
  top: 50%;
  transform: translateY(-50%);
  font-size: 22px;
  transition: color 0.3s ease;
}

.about-page-content ul li:hover::before {
  color: #FF8C00;
}

/* 返回首页按钮 */
.el-button {
  margin-top: 30px;
  padding: 12px 24px;
  font-size: 18px;
  background-color: #FF8C00;
  border: none;
  border-radius: 6px;
  color: #fff;
  cursor: pointer;
  transition: background-color 0.3s ease, transform 0.3s ease;
  text-transform: uppercase;
  font-weight: bold;
}

.el-button:hover {
  background-color: #e07b00;
  transform: scale(1.05);
}

.el-button:focus {
  outline: none;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .about-page-content {
    padding: 20px;
    margin: 0 10px;
  }

  .about-page-content h1 {
    font-size: 28px;
  }

  .about-page-content h2 {
    font-size: 24px;
  }

  .about-page-content p {
    font-size: 16px;
  }

  .el-button {
    padding: 10px 20px;
    font-size: 16px;
  }
}

</style>
