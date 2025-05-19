<template>
  <SidebarComponent>
    <div class="max-w-md mx-auto mt-10 p-6 bg-white rounded shadow">
      <h2 class="text-2xl font-bold mb-4">Ajouter un voyage</h2>
      <form @submit.prevent="submitForm">
        <div class="mb-4">
          <label class="block font-semibold">Titre</label>
          <input v-model="form.title" type="text" class="w-full border rounded p-2" required />
        </div>

        <div class="mb-4">
          <label class="block font-semibold">Description</label>
          <textarea v-model="form.description" class="w-full border rounded p-2" required></textarea>
        </div>

        <div class="mb-4">
          <label class="block font-semibold">Date de début</label>
          <input v-model="form.startAt" type="date" class="w-full border rounded p-2" required />
        </div>

        <div class="mb-4">
          <label class="block font-semibold">Date de fin</label>
          <input v-model="form.endAt" type="date" class="w-full border rounded p-2" required />
        </div>

        <div class="flex flex-col items-center mb-5">
          <div class="w-32 h-32 mb-2">
            <img :src="imagePreview || defaultImage" alt="Aperçu de l'image"
              class="w-full h-full object-cover rounded" />
          </div>
          <button type="button" @click="triggerFileInput"
            class="bg-blue-500 hover:bg-blue-600 text-white py-1 px-3 rounded shadow">Changer vignette</button>
          <input ref="fileInput" type="file" class="hidden" @change="handleImageChange" accept="image/*" />
        </div>
        <div class="flex flex-col items-center">
          <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded">Ajouter</button>
        </div>
      </form>
      <div v-if="errorMassage" class="mt-4 text-red-600">
        {{ errorMassage }}
      </div>
    </div>
  </SidebarComponent>
</template>
  
  <script setup>
import { ref } from 'vue'
import api from '@/../utils/axios'
import SidebarComponent from '@/components/navbar/SidebarComponent.vue'

const form = ref({
  title: '',
  description: '',
  startAt: '',
  endAt: '',
  thumbnail: 'https://i.postimg.cc/T1Vjc2h0/trip.jpg',
  isArchive: false,
})

const errorMassage = ref('')
const imagePreview = ref('')
const defaultImage = 'https://i.postimg.cc/T1Vjc2h0/trip.jpg'
import { useRouter } from 'vue-router'

const router = useRouter()
// Référence pour le champ file caché
const fileInput = ref(null)

const triggerFileInput = () => {
  fileInput.value.click()
}

const handleImageChange = (event) => {
  const file = event.target.files[0]

  if (file) {
    imagePreview.value = URL.createObjectURL(file)
    form.value.thumbnail = file
  }
}

const submitForm = async () => {
    console.log(form.value.thumbnail);
  
  try {          
    const payload = {
      ...form.value,
      startAt: new Date(form.value.startAt).toISOString(),
      endAt: new Date(form.value.endAt).toISOString(),
    }

    await api.post('/trips', payload, {
       headers: {
        'Content-Type': 'multipart/form-data',
      },
    })

    form.value = {
      title: '',
      description: '',
      startAt: '',
      endAt: '',
      thumbnail: '',
      isArchive: false,
    }
    router.push({ name: 'Dashboard', query: { successMessage: 'Voyage ajouté avec succès !' } })

  } catch (error) {
    errorMassage.value = error.response?.data?.message || "Une erreur est survenue."
  }
}
</script>
  
<style scoped>
  input, textarea {
    outline: none;
  }
  </style>
