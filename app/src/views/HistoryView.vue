<template>
  <div class="page history">
    <header><h1>History</h1></header>

    <main>
      <table>
        <thead>
          <tr><th>Name</th><th>Date</th><th>Cost (USD)</th></tr>
        </thead>
        <tbody>
          <tr v-for="h in history" :key="h.id">
            <td>{{ h.name }}</td>
            <td>{{ h.date }}</td>
            <td>{{ h.cost }}</td>
          </tr>
        </tbody>
      </table>
    </main>
  </div>
</template>

<script setup>
import { ref } from 'vue'
const history = ref([
  { id: 1, name: 'EC2-heavy', date: '2025-10-01', cost: '123.45' },
  { id: 2, name: 'S3-archive', date: '2025-09-29', cost: '12.34' }
])
</script>

<style scoped>
.page { padding: 24px; }
table { width:100%; border-collapse:collapse; }
th,td { text-align:left; padding:8px; border-bottom:1px solid #eee; }
</style>
