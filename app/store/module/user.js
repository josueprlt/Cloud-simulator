import api from '@/../utils/axios'

export default {
  namespaced: true,
  state: () => ({
    user: null,
    trips: []
}),
  mutations: {
    SET_USER(state, user) {
      state.user = user
    },
    SET_TRIPS(state, trips) {
        state.trips = trips
    }
  },
  actions: {
    async fetchUser({ commit, state, dispatch }) {
      if (state.user) return // déjà chargé

      try {
        const response = await api.get('/get_user')
        commit('SET_USER', response.data)
        dispatch('fetchTripByUser')
      } catch (error) {
        console.error('Erreur lors de la récupération de l’utilisateur:', error)
      }
    },
    async fetchTripByUser({commit, state}) {
        try {
            const response = await api.get(`users/${state.user.id}`)
             commit('SET_TRIPS', response.data.trips)
        } catch (error) {
         console.error('Erreur lors de la récupération des voyages:', error)
      }
    }
  },
  getters: {
    user: (state) => state.user,
    trips: (state) => state.trips,
    isAuthenticated: (state) => !!state.user
  }
}
