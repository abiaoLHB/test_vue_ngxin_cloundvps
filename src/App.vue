<template>
  <div style="padding: 20px">
    <h2>Vue 3 + 本地 Express 联调测试</h2>
    <button @click="getData">点击请求本地后端</button>

    <div v-if="serverData" style="margin-top: 15px; background: #f0f0f0; padding: 10px">
      <p>消息：{{ serverData.message }}</p>
      <p>姓名：{{ serverData.data.name }}</p>
      <p>时间：{{ serverData.data.time }}</p>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import axios from 'axios'

const serverData = ref(null)

const getData = async () => {
  try {
    // 这里用相对路径 /api/user 即可，Vite 代理会转给 http://localhost:3000/api/user
    const res = await axios.get('/api/user')
    serverData.value = res.data
  } catch (error) {
    console.error('请求失败：', error)
  }
}
</script>
