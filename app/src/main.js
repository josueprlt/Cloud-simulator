import { createApp } from 'vue'
import './assets/main.css';
import './assets/css/fonts.css';
import App from './App.vue'
import router from '../router/index';
import store from '../store/index';

createApp(App).use(router).use(store).mount('#app')
