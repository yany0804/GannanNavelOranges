export default {
  namespaced: true,
  state: () => ({
    items: []
  }),
  mutations: {
    addItem(state, item) {
      const existingItem = state.items.find(i => i.id === item.id)
      if (existingItem) {
        existingItem.quantity++
      } else {
        state.items.push({ ...item, quantity: 1 })
      }
    },
    removeItem(state, item) {
      const index = state.items.findIndex(i => i.id === item.id)
      if (index > -1) {
        state.items.splice(index, 1)
      }
    },
    updateItem(state, item) {
      const existingItem = state.items.find(i => i.id === item.id)
      if (existingItem) {
        existingItem.quantity = item.quantity
      }
    },
    clearCart(state) {
      state.items = []
    }
  },
  actions: {
    addItem({ commit }, item) {
      commit('addItem', item)
    },
    removeItem({ commit }, item) {
      commit('removeItem', item)
    },
    updateItem({ commit }, item) {
      commit('updateItem', item)
    },
    clearCart({ commit }) {
      commit('clearCart')
    }
  },
  getters: {
    itemCount: state => {
      return state.items.reduce((count, item) => count + item.quantity, 0)
    },
    totalAmount: state => {
      return state.items.reduce((total, item) => total + item.price * item.quantity, 0)
    }
  }
} 