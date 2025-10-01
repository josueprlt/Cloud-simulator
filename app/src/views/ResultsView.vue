<template>
  <div class="page results">
    <header><h1>Results</h1></header>

    <main>
      <section v-if="!results.length">
        <p>No results yet.</p>
      </section>

      <section v-else>
        <ul>
          <li v-for="r in results" :key="r.id">
            <strong>{{ r.name }}</strong> — <span>{{ r.estimatedCostUSD }} USD</span>
            <button @click="view(r)">View</button>
          </li>
        </ul>
      </section>
    </main>
  </div>
</template>

<script setup>
import { ref } from 'vue'
const results = ref([
  { id: 1, name: 'EC2-heavy', estimatedCostUSD: '123.45' },
  { id: 2, name: 'S3-archive', estimatedCostUSD: '12.34' }
])

function view(r) {
  // replace with router push to details or modal
  alert(JSON.stringify(r, null, 2))
}
</script>

<style scoped>
.page { padding: 24px; }
ul { list-style:none; padding:0; }
li { display:flex; gap:12px; align-items:center; padding:8px 0; }
</style>
