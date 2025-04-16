<script setup>

import SidebarComponent from "@/components/navbar/SidebarComponent.vue";
import CardMini from "@/components/card/CardMini.vue";
import Card from "@/components/card/CardWithImage.vue";


const activity = [
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

const accommodation = [
  {
    id: 1,
    title: "Hotel de la Plage",
    expense: 50.00,
    date: "2023-10-01",
    image: "https://images.unsplash.com/photo-1685537309786-baefb9ba7bbf?q=80&w=2061&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    registered : true,
  },
]
</script>

<template>
  <SidebarComponent>
    <div class="flex flex-col gap-10">
      <CardMini />
      <Card :api-data="activity" categorie="activity" />
      <Card :api-data="accommodation" title="Vos Logement" categorie="accommodation"/>
    </div>

  </SidebarComponent>

</template>

<style scoped>

</style>
