<template>
  <div>
    <div class="flex justify-between text-stone-800 ">
      <h2 class="text-xl font-bold">{{title}}</h2>
      <a class="text-sm" :href="urlButton">{{textButton}}</a>
    </div>
    <div class="flex gap-2 overflow-x-auto lg:overflow-x-visible lg:flex-wrap lg:gap-4 lg:w-full scrollbar-hide py-4 text-stone-800">
      <div v-for="item in apiData" :key="item.id" class="border-2 border-stone-300 rounded-xl p-2 w-48 lg:w-[calc(25%-1rem)] flex-shrink-0">
        <h3>{{ item.title }}</h3>
        <p>{{ item.expense }} €</p>
      </div>
    </div>
  </div>
</template>

<script setup>
import { defineProps } from 'vue';

defineProps({
  title: {
    type: String,
    required: true,
    default: 'Vos Dépenses',
  },
  textButton: {
    type: String,
    required: true,
    default: 'Voir tout',
  },
  urlButton: {
    type: String,
    required: true,
    default: '/expense',
  },
});

const apiData = [
  {
    id: 1,
    title: 'Mes dépenses',
    expense: 98.47,
  },
  {
    id: 2,
    title: 'Total des dépenses',
    expense: 147.70,
  },
  {
    id: 3,
    title: 'Vous devez',
    expense: 0.00,
  },
  {
    id: 4,
    title: 'On vous doit',
    expense: 45.21,
  },

]
</script>
