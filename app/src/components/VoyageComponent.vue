<script setup>
import {useRouter} from 'vue-router';

const router = useRouter();

function goToHebergement() {
  router.push({name: 'Hebergement'});
}

function goToActivite() {
  router.push({name: 'Activite'});
}
</script>

<template>
  <div>
    <h1>Page de Voyage</h1>
    <button @click="goToHebergement" class="btn btn-blue">Voir Hébergement</button>
    <button @click="goToActivite" class="btn btn-blue">Voir Activité</button>
  </div>
</template>