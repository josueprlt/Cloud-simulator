import { createStore } from 'vuex';
import user from '@/../store/module/user'

const store = createStore({
    state() {
        return {
            message: 'Hello from Vuex!'
        };
    },
    modules: {
        user
    },
    mutations: {
        updateMessage(state, newMessage) {
            state.message = newMessage;
        }
    },
    actions: {
        setMessage({ commit }, newMessage) {
            commit('updateMessage', newMessage);
        }
    },
    getters: {
        message(state) {
            return state.message;
        }
    }
});

export default store;
