<script setup>
import LogoComponent from '@/components/logoComponent.vue'
import { ref } from 'vue'
import axios from 'axios'
import { useRouter } from 'vue-router';

const router = useRouter();

const login = ref({
    email: '',
    password: ''
})

const checkTokenToRedirect = () => {
    const token = sessionStorage.getItem('token')
    if (token) {
        axios.get('http://localhost:8000/api', {
            headers: { Authorization: `Bearer ${token}` }
        }).then(() => {
            router.push({name: 'Hebergement'});
        }).catch(() => {
            router.push({name: 'Login'});
        });
    } else {
        router.push('/login');
    }
}

const submitConnexion = async () => {
    try {
        const response = await axios.post(
            'http://localhost:8000/api/auth/login_check',
            JSON.stringify(login.value),
            {
            headers: {
                'Content-Type': 'application/json'
            }
            }
        );
        sessionStorage.setItem('token', response.data.token)
        checkTokenToRedirect()
  } catch (error) {
    console.error("Connexion imposible:", error)
  }
}
</script>
<template>
    <LogoComponent />
    <div class="flex min-h-full flex-col justify-center px-6 py-12 lg:px-8">
        <div class="sm:mx-auto sm:w-full sm:max-w-sm">
            <h2 class="mt-10 text-center text-2xl/9 font-bold tracking-tight text-gray-900">Connectez-vous à votre
                compte</h2>
            <p class="mt-2 text-center text-1xl/9 font-thin tracking-tight text-gray-900">Entrez votre email et votre
                mot de passe pour vous connecter</p>
        </div>
        <div class="mt-10 sm:mx-auto sm:w-full sm:max-w-sm">
            <form @submit.prevent="submitConnexion" class="space-y-6" action="#" method="POST">
                <div>
                    <label for="email" class="text-left block text-sm/6 font-medium text-gray-900">Email</label>
                    <div class="mt-2">
                        <input type="email" v-model="login.email" id="email" autocomplete="email" required
                            class="block w-full border-2 border-solid rounded-md bg-white px-3 py-1.5 text-base text-gray-900 outline-1 -outline-offset-1 outline-gray-300 placeholder:text-gray-400 focus:outline-2 focus:-outline-offset-2 focus:outline-stone-600 sm:text-sm/6">
                    </div>
              
                </div>
                <div>
                    <label for="email" class="text-left block text-sm/6 font-medium text-gray-900">Mot de passe</label>
                    <div class="mt-2">
                        <input type="password" v-model="login.password" id="password" autocomplete="password" required
                            class="block w-full border-2 border-solid rounded-md bg-white px-3 py-1.5 text-base text-gray-900 outline-1 -outline-offset-1 outline-gray-300 placeholder:text-gray-400 focus:outline-2 focus:-outline-offset-2 focus:outline-stone-600 sm:text-sm/6">
                    </div>
                </div>
                <div>
                <div class="flex justify-between">
                    <label><input class="me-1" id="checkbox" v-model="rememberMe" type="checkbox"/>Se souvenir de moi</label>
                    <a class="underline" href="">mot de passe oublié ?</a>
                </div>
                    <button type="submit"
                        class="flex w-full justify-center rounded-md bg-stone-900 px-3 py-1.5 mt-10 text-sm/6 
                        font-semibold text-white shadow-xs hover:bg-stone-500 focus-visible:outline-2 
                        focus-visible:outline-offset-2 focus-visible:outline-stone-600">Sign in
                    </button>
                </div>
            </form>
            <p class="mt-10">Vous n’avez pas de compte ?<router-link class="underline" :to="{ name: 'Register'}"> S’inscrire</router-link></p>

        </div>
    </div>
</template>
<style>
</style>
