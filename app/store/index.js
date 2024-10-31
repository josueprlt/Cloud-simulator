import { createStore } from 'vuex';

const store = createStore({
    state() {
        return {
            message: 'Hello from Vuex!'
        };
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
