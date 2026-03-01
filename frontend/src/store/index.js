import { createStore } from 'vuex'
import { api } from '../api'
import cart from './modules/cart'

const store = createStore({
  modules: {
    user: {
      namespaced: true,
      state: () => ({
        isLoggedIn: false,
        userInfo: null
      }),
      mutations: {
        setLoginState(state, { isLoggedIn, userInfo }) {
          state.isLoggedIn = isLoggedIn
          state.userInfo = userInfo
        }
      },
      actions: {
        async login({ commit }, { username, password }) {
          try {
            const userInfo = await api.login(username, password)
            commit('setLoginState', { isLoggedIn: true, userInfo })
            return true
          } catch (error) {
            commit('setLoginState', { isLoggedIn: false, userInfo: null })
            throw error
          }
        },
        async register({ commit }, { username, password }) {
          try {
            const userInfo = await api.register(username, password)
            commit('setLoginState', { isLoggedIn: true, userInfo })
            return true
          } catch (error) {
            throw error
          }
        },
        logout({ commit }) {
          commit('setLoginState', { isLoggedIn: false, userInfo: null })
        }
      }
    },
    cart,
    products: {
      namespaced: true,
      state: () => ({
        products: [],
        premiumProducts: []
      }),
      mutations: {
        setProducts(state, products) {
          state.products = products
        },
        setPremiumProducts(state, products) {
          state.premiumProducts = products
        }
      },
      actions: {
        async fetchProducts({ commit }) {
          const products = await api.getProducts()
          commit('setProducts', products)
        },
        async fetchPremiumProducts({ commit }) {
          const products = await api.getPremiumProducts()
          commit('setPremiumProducts', products)
        }
      }
    }
  }
})

export default store 