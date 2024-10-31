<script setup>
import { useRouter } from 'vue-router';
import {onMounted, ref} from 'vue';
import axios from 'axios';

const router = useRouter();

function goToHebergement() {
  router.push({ name: 'Hebergement' });
}

function goToActivite() {
  router.push({ name: 'Activite' });
}

const voyage = ref({
  title: '',
  startAt: '',
  endAt: ''
});

async function submitVoyage() {
  try {
    const response = await axios.post(
        'http://localhost:8000/api/voyages',
        JSON.stringify(voyage.value),
        {
          headers: {
            'Content-Type': 'application/json'
          }
        }
    );
    console.log('Voyage ajouté:', response.data);
    voyage.value = { title: '', startAt: '', endAt: '' };
  } catch (error) {
    console.error("Erreur lors de l'ajout du voyage:", error);
  }
}

const voyages = ref([]); // Variable pour stocker la liste des voyages

async function getVoyage() {
  try {
    const response = await axios.get('http://localhost:8000/api/voyages');
    console.log(response.data); // Vérifie les données dans la console
    voyages.value = response.data.member; // Assigne les voyages à la variable `voyages`
  } catch (error) {
    console.error("Erreur lors de la récupération des voyages:", error);
  }
}
onMounted(() => {
  getVoyage();
});
</script>

<template>
  <div>
    <h1>Page de Voyage</h1>
    <button @click="goToHebergement" class="btn btn-blue">Voir Hébergement</button>
    <button @click="goToActivite" class="btn btn-blue">Voir Activité</button>

    <h2 class="mt-5">Ajouter un Nouveau Voyage</h2>
    <form @submit.prevent="submitVoyage" class="max-w-sm mx-auto pt-5">
      <div  class="mb-5">
        <label for="title" class="block mb-2 text-sm font-medium text-gray-900">Titre:</label>
        <input v-model="voyage.title" id="title" required  class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" />
      </div>
      <div  class="mb-5">
        <label for="startAt" class="block mb-2 text-sm font-medium text-gray-900">Date de Début:</label>
        <input v-model="voyage.startAt" id="startAt" type="date" required  class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" />
      </div>
      <div  class="mb-5">
        <label for="endAt" class="block mb-2 text-sm font-medium text-gray-900">Date de Fin:</label>
        <input v-model="voyage.endAt" id="endAt" type="date" required  class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" />
      </div>
      <button type="submit" class="btn btn-blue">Ajouter Voyage</button>
    </form>
  </div>
  <div>
    <h1>Liste des Voyages</h1>
    <ul>
      <li v-for="voyage in voyages" :key="voyage.id">
        {{ voyage.title }} - Du {{ voyage.startAt }} au {{ voyage.endAt }}
      </li>
    </ul>
  </div>
</template>
