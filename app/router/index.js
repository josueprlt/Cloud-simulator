import { createRouter, createWebHistory } from 'vue-router';

// Définir les routes de l'application
const routes = [
    {
        path: '/results',
        name: 'ResultsView',
        component: () => import('../src/views/ResultsView.vue')
    },
    {
        path: "/",
        name: "DashboardView",
        component: () => import('../src/views/DashboardView.vue')
    },
    {
        path: '/history',
        name: 'HistoryView',
        component: () => import('../src/views/HistoryView.vue')
    },
    {
        path: '/simulate',
        name: 'SimulateConfig',
        component: () => import('../src/views/SimulateConfig.vue')
    }
];

const router = createRouter({
    history: createWebHistory(),
    routes
});

export default router;
