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
          :src="activeTravel?.thumbnail || defaultThumbnail"
          :alt="activeTravel?.title || 'Voyage'"
        />
      </div>
      <div class="w-full flex flex-col gap-0">
        <h5 class="text-sm font-bold text-left">{{ activeTravel?.title || 'Voyage inconnu' }}</h5>
        <p class="text-sm mt-[-5px] text-left">1 membre</p>
      </div>
      <svg
        :class="{ 'rotate-180': isOpen }"
        class="transition-transform"
        width="20"
        viewBox="0 0 24 24"
        xmlns="http://www.w3.org/2000/svg"
      >
        <path d="M12 22c-.3 0-.5-.1-.7-.3l-5-5a1 1 0 1 1 1.4-1.4L12 19.6l4.3-4.3a1 1 0 1 1 1.4 1.4l-5 5c-.2.2-.4.3-.7.3z"/>
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
              :src="travel.thumbnail || defaultThumbnail"
              :alt="travel.title"
            />
          </div>
          <div class="w-full flex flex-col gap-0">
            <h5 class="text-sm font-bold">{{ travel.title }}</h5>
            <p class="text-sm mt-[-5px]">1 membre</p>
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
import { ref, computed, watch } from "vue"
import { useRouter } from 'vue-router'
import { useStore } from 'vuex'

const router = useRouter()
const store = useStore()

const travels = computed(() => store.getters["user/trips"] || [])
const defaultThumbnail = 'https://i.postimg.cc/T1Vjc2h0/trip.jpg'

// ID du voyage actif (init avec le premier voyage non archivé si dispo)
const activeTravelId = ref(null)

watch(travels, () => {
  if (!activeTravelId.value && travels.value.length) {
    const firstValid = travels.value.find(t => !t.isArchive)
    if (firstValid) activeTravelId.value = firstValid.id
  }
}, { immediate: true })

const activeTravel = computed(() =>
  travels.value.find(t => t.id === activeTravelId.value)
)

const otherTravels = computed(() =>
  travels.value.filter(t => !t.isArchive && t.id !== activeTravelId.value)
)

const isOpen = ref(false)
const toggleDropdown = () => (isOpen.value = !isOpen.value)

const selectTravel = (travel) => {
  activeTravelId.value = travel.id
  isOpen.value = false
}

const addTravel = () => {
  router.push({ name: 'Form trip' })
}
</script>
