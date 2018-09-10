import Vue from 'vue'
import Router from 'vue-router'
import Register from '@/components/Register'
// import Signup from '@/components/Signup'
import Dashboard from '@/components/Dashboard'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'register',
      component: Register
    },
    {
      path: '/test',
      name: 'dashboard',
      component: Dashboard
    }
  ]
})
