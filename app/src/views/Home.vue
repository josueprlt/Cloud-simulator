<script setup>

import Navbar from "@/components/navbar/Sidebar.vue";
import CardExpense from "@/components/expense/CardExpense.vue";
import CardActivity from "@/components/activity/CardActivity.vue";
</script>

<template>
  <Navbar>
    <div class="flex flex-col gap-10">
      <CardExpense />
      <CardActivity />
    </div>

  </Navbar>

</template>

<style scoped>

</style>
