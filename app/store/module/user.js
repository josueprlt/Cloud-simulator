import api from '@/../utils/axios'

export default {
  namespaced: true,
  state: () => ({
    user: null
  }),
  mutations: {
    SET_USER(state, user) {
      state.user = user
    }
  },
  actions: {
    async fetchUser({ commit, state }) {
      if (state.user) return // déjà chargé

      try {
        const response = await api.get('/get_user')
        commit('SET_USER', response.data)
      } catch (error) {
        console.error('Erreur lors de la récupération de l’utilisateur:', error)
      }
    }
  },
  getters: {
    user: (state) => state.user,
    trips: (state) => state.user?.trips || [],
    isAuthenticated: (state) => !!state.user
  }
}
