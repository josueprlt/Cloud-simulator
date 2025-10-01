<template>
  <div class="page simulate">
    <header>
      <h1>Simulate</h1>
    </header>

    <main>
      <form @submit.prevent="runSimulation">
        <label>
          Simulation name
          <input v-model="name" required />
        </label>

        <label>
          Monthly estimated hours
          <input type="number" v-model.number="hours" min="0" />
        </label>

        <button type="submit">Run simulation</button>
      </form>

      <div v-if="running">Running simulation...</div>
      <div v-if="result">
        <h3>Result</h3>
        <pre>{{ result }}</pre>
      </div>
    </main>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const name = ref('')
const hours = ref(720)
const running = ref(false)
const result = ref(null)

function runSimulation() {
  running.value = true
  result.value = null
  // placeholder: replace with API call
  setTimeout(() => {
    result.value = { name: name.value || 'untitled', estimatedCostUSD: (hours.value * 0.05).toFixed(2) }
    running.value = false
  }, 700)
}
</script>

<style scoped>
.page { padding: 24px; }
form { display:flex; flex-direction:column; gap:8px; max-width:420px; }
</style>
