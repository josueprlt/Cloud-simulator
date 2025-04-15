<template>
  <div>
    <div class="flex justify-between text-stone-800 ">
      <h2 class="text-xl font-bold">{{title}}</h2>
      <a class="text-sm" :href="`/${categorie}/all`">{{textButton}}</a>
    </div>
    <div class="flex gap-2 overflow-x-auto lg:overflow-x-visible lg:flex-wrap lg:gap-4 lg:w-full scrollbar-hide py-4 text-stone-800">
      <a :href="`/${categorie}/${item.id}`" v-for="(item) in apiData.slice(0, 3)" :key="item.id" class="relative border-2 border-stone-100 rounded-xl w-64 h-64 lg:w-[calc(25%-1rem)] flex-shrink-0 overflow-hidden">
      <img :src="item.image" alt="Image" class="absolute inset-0 w-full h-full rounded-l object-cover z-0">
        <div class="absolute w-full bottom-0 z-10 p-2 bg-white">
          <div class="flex justify-between w-full">
            <h4 class="truncate">{{ item.title.substring(0, 20) }}{{ item.title.length > 40 ? '...' : '' }}</h4>
            <p class="text-xs text-gray-500">{{ item.date }}</p>
          </div>
          <div class="flex justify-between w-full">
            <p>{{ item.expense }} €</p>
            <div class="flex gap-1 items-center">
              <span :class="`h-2 w-2 rounded-full ${item.registered ? 'bg-green-500' : 'bg-stone-500'}`"></span>
              <p :class="`text-sm text-gray-500 ${item.registered ? 'text-green-500' : 'text-stone-500'}`">{{ item.registered ? 'Inscrit' : 'Non inscrit' }}</p>
            </div>
          </div>
        </div>
      </a>
      <a class="relative border-2 border-stone-300 rounded-xl border-dashed w-64 h-64 lg:w-[calc(25%-1rem)] flex-shrink-0 overflow-hidden">
        <div class="flex items-center justify-center h-full">
          <svg width="16px" viewBox="0 0 469.33333 469.33333" fill="rgb(168 162 158)" xmlns="http://www.w3.org/2000/svg" id="fi_1828921"><path d="m437.332031 192h-160v-160c0-17.664062-14.335937-32-32-32h-21.332031c-17.664062 0-32 14.335938-32 32v160h-160c-17.664062 0-32 14.335938-32 32v21.332031c0 17.664063 14.335938 32 32 32h160v160c0 17.664063 14.335938 32 32 32h21.332031c17.664063 0 32-14.335937 32-32v-160h160c17.664063 0 32-14.335937 32-32v-21.332031c0-17.664062-14.335937-32-32-32zm0 0"></path></svg>
        </div>
      </a>
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
    default: '/card',
  },
  categorie: {
    type: String,
    required: true,
    default: 'activity',
  },
  apiData: {
    type: Array,
    required: true,
    default: () => [],
  },
});

</script>
