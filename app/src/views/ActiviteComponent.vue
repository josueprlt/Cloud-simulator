<script setup>
import {useRouter} from 'vue-router';

const router = useRouter();

function goToVoyage() {
  router.push({name: 'Voyage'});
}
</script>

<template>
  <div>
    <h1>Page d'Activité</h1>
    <button @click="goToVoyage" class="btn btn-blue">Retour à Voyage</button>
  </div>
</template>