import Vue from 'vue'
import App from './App.vue'
import VueMq from 'vue-mq'
import router from './router'

import VueAxios from 'vue-axios'
import { securedAxiosInstance, plainAxiosInstance } from './backend/axios'

// import 'bootstrap/dist/js/bootstrap'
import 'bootstrap'

// import plugins individually - require exports-loader
import 'bootstrap/js/dist/modal'
import 'bootstrap/js/dist/tooltip'

// import 'bootstrap/dist/css/bootstrap.min.css'
// import 'bootstrap/scss/bootstrap.scss'

import * as VueGoogleMaps from 'vue2-google-maps'

Vue.config.productionTip = false
Vue.use(VueAxios, {
  secured: securedAxiosInstance,
  plain: plainAxiosInstance
})

// jquery
global.$ = $

Vue.use(VueGoogleMaps, {
  load: {
    key: 'AIzaSyDhckeqRinlpHeTfo3T-ethx8hJyTG62UY',
    libraries: 'places',
    language: 'en'
  },
  autobindAllEvents: false,
  installComponents: true
})

// Breakpoints for reactive design: these are available to all components with $mq
Vue.use(VueMq, {
  breakpoints: {
    sm: 450,
    md: 1250,
    lg: Infinity
  }
})

Vue.config.productionTip = false

global.store = {
  state: {
    currentLocation: null,
    currentUserId: 1,
    currentTrip: {
      address: null,
      trip_time: null,
      trip_owner: null
    },
    right: 'RightHome',
    loggedIn: false
  },
  setCurrentLocation (newLocation) {
    this.state.currentLocation = newLocation
    this.setRightPane('SubmitReview')
  },
  clearCurrentLocation () {
    this.state.currentLocation = null
  },
  setRightPane (name) {
    this.state.right = name
  },
  setCurrentLocationId (id) {
    this.state.currentLocation.id = id
  }
}

new Vue({
  router,
  securedAxiosInstance,
  plainAxiosInstance,
  render: h => h(App)
}).$mount('#app')
