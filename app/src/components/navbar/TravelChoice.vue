<template>
  <div class="relative">
    <!-- Bouton principal affichant le voyage actif -->
    <button
      @click="toggleDropdown"
      class="flex justify-between items-center gap-4 border-2 border-stone-300 p-2 rounded-md w-full"
    >
      <div class="h-10 w-14 rounded-md overflow-hidden">
        <img
          class="h-full w-full object-cover"
          :src="activeTravel.img"
          :alt="activeTravel.title"
        />
      </div>
      <div class="w-full flex flex-col gap-0">
        <h5 class="text-lg font-bold text-left">{{ activeTravel.title }}</h5>
        <p class="text-sm mt-[-5px] text-left">{{ activeTravel.member }} membres</p>
      </div>
      <svg
        id="fi_7693521"
        enable-background="new 0 0 24 24"
        viewBox="0 0 24 24"
        width="20px"
        xmlns="http://www.w3.org/2000/svg"
        :class="{ 'rotate-180': isOpen }"
        class="transition-transform"
      >
        <g>
          <path
            d="m12 22c-.3 0-.5-.1-.7-.3l-5-5c-.4-.4-.4-1 0-1.4s1-.4 1.4 0l4.3 4.3 4.3-4.3c.4-.4 1-.4 1.4 0s.4 1 0 1.4l-5 5c-.2.2-.4.3-.7.3z"
          ></path>
        </g>
        <g>
          <path
            d="m7 9c-.3 0-.5-.1-.7-.3-.4-.4-.4-1 0-1.4l5-5c.4-.4 1-.4 1.4 0l5 5c.4.4.4 1 0 1.4s-1 .4-1.4 0l-4.3-4.3-4.3 4.3c-.2.2-.4.3-.7.3z"
          ></path>
        </g>
      </svg>
    </button>

    <!-- Dropdown -->
    <div
      v-if="isOpen"
      class="absolute z-10 mt-2 w-full bg-white border border-stone-300 rounded-md shadow-lg"
    >
      <ul>
        <li
          v-for="travel in otherTravels"
          :key="travel.id"
          @click="selectTravel(travel)"
          class="flex items-center gap-4 p-2 hover:bg-stone-100 cursor-pointer"
        >
          <div class="h-10 w-14 rounded-md overflow-hidden">
            <img
              class="h-full w-full object-cover"
              :src="travel.img"
              :alt="travel.title"
            />
          </div>
          <div class="w-full flex flex-col gap-0">
            <h5 class="text-lg font-bold">{{ travel.title }}</h5>
            <p class="text-sm mt-[-5px]">{{ travel.member }} membres</p>
          </div>
        </li>
          <li class="p-2 border-t border-stone-200">
            <button @click="addTravel" class="w-full flex gap-x-3 bg-stone-900 text-white p-2 px-4 rounded-md">
              Ajouter un voyage
            </button>
        </li>
      </ul>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from "vue";

const router = useRouter();

// Liste des voyages
const travels = [
  {
    id: 1,
    title: "Grèce 2024",
    img: "https://images.unsplash.com/photo-1603288986817-7973bc90d346?q=80&w=2068&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    member: 5,
    active: true,
  },
  {
    id: 2,
    title: "Italie 2023",
    img: "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?q=80&w=2068&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    member: 3,
    active: false,
  },
  {
    id: 3,
    title: "Espagne 2022",
    img: "https://images.unsplash.com/photo-1512453979798-5ea266f8880c?q=80&w=2068&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    member: 4,
    active: false,
  },
];

// État du dropdown
const isOpen = ref(false);

// Voyage actif
const activeTravel = computed(() => travels.find((travel) => travel.active));

// Autres voyages
const otherTravels = computed(() =>
  travels.filter((travel) => !travel.active)
);

// Fonction pour ouvrir/fermer le dropdown
const toggleDropdown = () => {
  isOpen.value = !isOpen.value;
};

// Fonction pour sélectionner un voyage
const selectTravel = (travel) => {
  travels.forEach((t) => (t.active = t.id === travel.id));
  isOpen.value = false;
};

const addTravel = () => {
  router.push({name: 'formTrip'})
};
</script>
