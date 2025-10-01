<template>
  <div class="dashboard">
    <header class="header">
      <h1>Cloud Cost Simulator</h1>
      <p class="subtitle">Overview</p>
    </header>

    <section class="cards">
      <div class="card">
        <div class="card-title">Estimated Monthly Cost</div>
        <div class="card-value">{{ formatCurrency(estMonthly) }}</div>
      </div>

      <div class="card">
        <div class="card-title">Projected Savings</div>
        <div class="card-value">{{ formatCurrency(projectedSavings) }}</div>
      </div>

      <div class="card">
        <div class="card-title">Simulations</div>
        <div class="card-value">{{ simulationsCount }}</div>
      </div>

      <div class="card">
        <div class="card-title">Last run</div>
        <div class="card-value">{{ lastRun || '—' }}</div>
      </div>
    </section>

    <section class="chart">
      <h2>Cost Breakdown (placeholder)</h2>
      <div class="chart-placeholder">Chart will render here</div>
    </section>

    <section class="recent">
      <h2>Recent simulations</h2>
      <ul>
        <li v-for="sim in recent" :key="sim.id">
          <strong>{{ sim.name }}</strong> — {{ formatCurrency(sim.estimatedCost) }} — {{ sim.date }}
        </li>
      </ul>
    </section>
  </div>
</template>

<script>
export default {
  name: 'DashboardView',
  props: {
    initialData: {
      type: Object,
      default: () => ({})
    }
  },
  data() {
    return {
      estMonthly: this.initialData.estMonthly ?? 0,
      projectedSavings: this.initialData.projectedSavings ?? 0,
      simulationsCount: this.initialData.simulationsCount ?? 0,
      lastRun: this.initialData.lastRun ?? null,
      recent: this.initialData.recent ?? [
        // sample placeholders; remove when wiring API
        { id: 1, name: 'Baseline', estimatedCost: 1245.5, date: '2025-09-30' },
        { id: 2, name: 'Optimized', estimatedCost: 842.2, date: '2025-09-29' }
      ]
    }
  },
  methods: {
    formatCurrency(v) {
      return new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(v)
    }
  }
}
</script>

<style scoped>
.dashboard { padding: 20px; font-family: system-ui, sans-serif; }
.header h1 { margin: 0; font-size: 1.6rem; }
.header .subtitle { color: #666; margin-top: 4px; }

.cards { display: grid; grid-template-columns: repeat(4, 1fr); gap: 12px; margin: 18px 0; }
.card { background: #fff; border: 1px solid #e6e6e6; padding: 14px; border-radius: 8px; box-shadow: 0 1px 2px rgba(0,0,0,0.03); }
.card-title { color: #666; font-size: 0.85rem; }
.card-value { font-weight: 600; margin-top: 6px; font-size: 1.1rem; }

.chart { margin-top: 20px; }
.chart-placeholder { height: 220px; border: 1px dashed #ccc; border-radius: 6px; display:flex; align-items:center; justify-content:center; color:#999; background:#fafafa; }

.recent { margin-top: 18px; }
.recent ul { list-style: none; padding: 0; margin: 0; }
.recent li { padding: 8px 0; border-bottom: 1px solid #f0f0f0; }
</style>
