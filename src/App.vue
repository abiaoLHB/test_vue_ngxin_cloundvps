<template>
  <div style="padding: 20px">
    <h2>Vue 3 + 本地 Express 联调测试</h2>
    <button @click="getData">点击请求本地后端</button>

    <div v-if="serverData" style="margin-top: 15px; background: #f0f0f0; padding: 10px">
      <p>消息：{{ serverData.message }}</p>
      <p>姓名：{{ serverData.data.name }}</p>
      <p>时间：{{ serverData.data.time }}</p>
    </div>

    <!-- 表单区域 -->
    <form @submit.prevent="submitData" style="display: flex; flex-direction: column; gap: 12px">
      <div>
        <label style="display: block; margin-bottom: 4px">姓名：</label>
        <input
          v-model="form.name"
          type="text"
          placeholder="例如：张三"
          required
          style="width: 100%; padding: 8px; box-sizing: border-box"
        />
      </div>

      <div>
        <label style="display: block; margin-bottom: 4px">年龄：</label>
        <input
          v-model.number="form.age"
          type="number"
          placeholder="例如：25"
          required
          style="width: 100%; padding: 8px; box-sizing: border-box"
        />
      </div>

      <div>
        <label style="display: block; margin-bottom: 4px">职业：</label>
        <input
          v-model="form.job"
          type="text"
          placeholder="例如：前端开发"
          required
          style="width: 100%; padding: 8px; box-sizing: border-box"
        />
      </div>

      <button type="submit" :disabled="loading" style="padding: 10px; cursor: pointer">
        {{ loading ? '提交中...' : '提交数据到 PostgreSQL' }}
      </button>
    </form>
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue'
import axios from 'axios'

const serverData = ref(null)

const getData = async () => {
  try {
    // 这里用相对路径 /api/users 即可，Vite 代理会转给 http://localhost:3000/api/users
    const res = await axios.get('/api/users')
    serverData.value = res.data
  } catch (error) {
    console.error('请求失败：', error)
  }
}

// 表单响应式数据
const form = reactive({
  name: '',
  age: null,
  job: ''
})
const loading = ref(false)
const serverData2 = ref(null)

// 提交表单方法
const submitData = async () => {
  loading.value = true
  serverData2.value = null

  try {
    // 走 Vite 代理请求 POST /api/users，把 form 对象发给 Express
    const res = await axios.post('/api/users', form)

    // 拿到 Express 返回的数据并渲染
    serverData2.value = res.data

    // 提交成功后清空表单输入框
    if (res.data.success) {
      form.name = ''
      form.age = null
      form.job = ''
    }
  } catch (error) {
    console.error('提交失败：', error)
    alert('提交失败，请检查控制台或后端日志！')
  } finally {
    loading.value = false
  }
}
</script>
