import { createRouter, createWebHistory } from 'vue-router';

// Définir les routes de l'application
const routes = [
    {
        path: '/',
        name: 'Voyage',
        component: () => import('../src/components/VoyageComponent.vue')
    },
    {
        path: '/hebergement',
        name: 'Hebergement',
        component: () => import('../src/components/HebergementComponent.vue')
    },
    {
        path: '/activite',
        name: 'Activite',
        component: () => import('../src/components/ActiviteComponent.vue')
    }
];

const router = createRouter({
    history: createWebHistory(),
    routes
});

export default router;
