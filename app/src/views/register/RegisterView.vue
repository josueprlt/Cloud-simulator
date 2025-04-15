<script setup>
import LogoComponent from '@/components/logoComponent.vue'
import { computed, ref } from 'vue'
import axios from 'axios'
import { useRouter } from 'vue-router';

const router = useRouter();

const errorMessage = ref('')

const register = ref({
    username: '',
    email: '',
    password: ''
})

const passwordsMatch = computed(() => {
  return register.value.password === register.value.confirmPassword
})

const submitRegistration = async () => {
    try {
        const response = await axios.post(
            'http://localhost:8000/api/register',
            JSON.stringify(register.value),
            {
                headers: {
                    'Content-Type': 'application/json'
                }
            }
        );
        if(response.status === 201) {
            router.push({name: 'Login'});
        }
    } catch (error) {
        errorMessage.value = error.response.data.error
    }
}
</script>
<template>
    <LogoComponent />
    <div v-if="errorMessage" class="bg-red-100 border border-red-400 text-red-700 py-2 mt-5 rounded relative"
        role="alert">
        <strong class="font-bold">Erreur : </strong>
        <span class="block sm:inline">{{ errorMessage }}</span>
    </div>
    <div class="flex min-h-full flex-col justify-center px-6 py-12 lg:px-8">
        <div class="sm:mx-auto sm:w-full sm:max-w-sm">
            <h2 class="mt-10 text-center text-2xl/9 font-bold tracking-tight text-gray-900">Inscrivez-vous</h2>
        </div>
        <div class="mt-10 sm:mx-auto sm:w-full sm:max-w-sm">
            <form @submit.prevent="submitRegistration" class="space-y-6" action="#" method="POST">
                <div>
                    <label for="username" class="text-left block text-sm/6 font-medium text-gray-900">Nom d'utilisateur</label>
                    <div class="mt-2">
                        <input type="username" v-model="register.username" id="email" autocomplete="username" required
                            class="block w-full border-2 border-solid rounded-md bg-white px-3 py-1.5 text-base text-gray-900 outline-1 -outline-offset-1 outline-gray-300 placeholder:text-gray-400 focus:outline-2 focus:-outline-offset-2 focus:outline-stone-600 sm:text-sm/6">
                    </div>
                </div>
                <div>
                    <label for="email" class="text-left block text-sm/6 font-medium text-gray-900">Email</label>
                    <div class="mt-2">
                        <input type="email" v-model="register.email" id="email" autocomplete="email" required
                            class="block w-full border-2 border-solid rounded-md bg-white px-3 py-1.5 text-base text-gray-900 outline-1 -outline-offset-1 outline-gray-300 placeholder:text-gray-400 focus:outline-2 focus:-outline-offset-2 focus:outline-stone-600 sm:text-sm/6">
                    </div>
                </div>
                <div>
                    <label for="email" class="text-left block text-sm/6 font-medium text-gray-900">Mot de passe</label>
                    <div class="mt-2">
                        <input type="password" v-model="register.password" id="password" autocomplete="password"
                            required
                            class="block w-full border-2 border-solid rounded-md bg-white px-3 py-1.5 text-base text-gray-900 outline-1 -outline-offset-1 outline-gray-300 placeholder:text-gray-400 focus:outline-2 focus:-outline-offset-2 focus:outline-stone-600 sm:text-sm/6">
                    </div>
                </div>
                <div>
                    <label for="email" class="text-left block text-sm/6 font-medium text-gray-900">Confirmer mot de passe</label>
                    <div class="mt-2">
                        <input type="password" v-model="register.confirmPassword" id="password" autocomplete="password"
                            required
                            class="block w-full border-2 border-solid rounded-md bg-white px-3 py-1.5 text-base text-gray-900 outline-1 -outline-offset-1 outline-gray-300 placeholder:text-gray-400 focus:outline-2 focus:-outline-offset-2 focus:outline-stone-600 sm:text-sm/6">
                    </div>
                    <div v-if="!passwordsMatch && register.confirmPassword" class="text-red-500 text-sm mt-1">
                        Les mots de passe ne correspondent pas.
                    </div>
                </div>
                <div>
                    <button type="submit" class="flex w-full justify-center rounded-md bg-stone-900 px-3 py-1.5 mt-10 text-sm/6 
                        font-semibold text-white shadow-xs hover:bg-stone-500 focus-visible:outline-2 
                        focus-visible:outline-offset-2 focus-visible:outline-stone-600">S'enregistrer
                    </button>
                </div>
            </form>
            <p class="mt-10">Vous avez déjà un compte<router-link class="underline" :to="{ name: 'Login' }"> Se
                    connecter</router-link></p>
        </div>
    </div>
</template>
<style>
</style>
