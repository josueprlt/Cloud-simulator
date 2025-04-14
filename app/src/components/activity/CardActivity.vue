<template>
  <div>
    <div class="flex justify-between text-stone-800 ">
      <h2 class="text-xl font-bold">{{title}}</h2>
      <a class="text-sm" :href="urlButton">{{textButton}}</a>
    </div>
    <div class="flex gap-2 overflow-x-auto lg:overflow-x-visible lg:flex-wrap lg:gap-4 lg:w-full scrollbar-hide py-4 text-stone-800">
      <a :href="`/activity/${item.id}`" v-for="(item) in apiData.slice(0, 4)" :key="item.id" class="relative border-2 border-stone-100 rounded-xl w-64 h-64 lg:w-[calc(25%-1rem)] flex-shrink-0 overflow-hidden">
      <img :src="item.image" alt="Image" class="absolute inset-0 w-full h-full rounded-xl object-cover z-0">
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
    default: '/activity',
  },
});

const apiData = [
  {
    id: 1,
    title: "Visite maritime îles Athènes",
    expense: 14.05,
    date: "2023-10-01",
    image: "https://images.unsplash.com/photo-1622500230863-94ebf0748181?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    registered : true,
  },
  {
    id: 2,
    title: "Visite maritime îles Athènes",
    expense: 14.05,
    date: "2023-10-01",
    image: "https://images.unsplash.com/photo-1622500230863-94ebf0748181?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    registered : false,
  },
  {
    id: 3,
    title: "Visite maritime îles Athènes",
    expense: 14.05,
    date: "2023-10-01",
    image: "https://images.unsplash.com/photo-1622500230863-94ebf0748181?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    registered : true,
  },
  {
    id: 4,
    title: "Visite maritime îles Athènes",
    expense: 14.05,
    date: "2023-10-01",
    image: "https://images.unsplash.com/photo-1622500230863-94ebf0748181?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    registered : false,
  },
  {
    id: 5,
    title: "Visite maritime îles Athènes",
    expense: 14.05,
    date: "2023-10-01",
    image: "https://images.unsplash.com/photo-1622500230863-94ebf0748181?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    registered : true,
  },
  {
    id: 6,
    title: "Visite maritime îles Athènes",
    expense: 14.05,
    date: "2023-10-01",
    image: "https://www.example.com/image6.jpg",
    registered : false,
  },
]

</script>
