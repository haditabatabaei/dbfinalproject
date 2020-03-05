import Vue from 'vue'
import Router from 'vue-router'
import DashboardLayout from '@/layout/DashboardLayout'

Vue.use(Router);

export default new Router({
    linkExactActiveClass: 'active',
    routes: [
        {
            path: '/',
            redirect : 'users',
            component: DashboardLayout,
            children: [
                {
                    path: '/profile',
                    name: 'profile',
                    component: () => import(/* webpackChunkName: "demo" */ './views/UserProfile.vue')
                },
                {
                    path: '/users',
                    name: 'users',
                    component: () => import(/* webpackChunkName: "demo" */ './views/Users.vue'),
                },
                {
                    path: '/new/user',
                    name: 'newuser',
                    component: () => import('./views/NewUser.vue'),
                },
                {
                    path: '/users/:id',
                    name: 'userProfile',
                    component: () => import('@/views/UserProfile.vue')
                },
                {
                    path: '/foods',
                    name: 'Foods',
                    component: () => import('@/views/Foods.vue')
                },
                {
                    path: '/new/order',
                    name: 'NewOrder',
                    component: () => import("@/views/NewOrder.vue")
                },
                {
                    path : '/orders',
                    name : 'Orders',
                    component: () => import('@/views/Orders')
                },
                {
                    path: '/orders/:id',
                    name : 'OrderProfile',
                    component: () => import('@/views/OrderProfile')
                },
                {
                    path : '/materials',
                    name : 'Materials',
                    component: () => import('@/views/Materials.vue')
                },
                {
                    path : '/suppliers',
                    name : 'Suppliers',
                    component: () => import('@/views/Suppliers.vue')
                },
                {
                    path : '/new/supplierorder/',
                    name : 'NewSupplierOrder',
                    component: () => import('@/views/NewSupplierOrder.vue')
                },
                {
                    path : '/supplierorders',
                    name : 'SupplierOrders',
                    component: () => import("@/views/SupplierOrders.vue")
                },
                {
                    path : '/supplierorders/:id',
                    name : 'SupplierOrderProfile',
                    component : () => import("@/views/SupplierOrderProfile.vue")
                },
                {
                    path : '/reports',
                    name : 'Reports',
                    component: () => import("@/views/Reports.vue")
                },
                {
                    path : '/logs',
                    name : 'Logs',
                    component: () =>  import('@/views/Logs.vue')
                },
                {
                    path : '/couriers',
                    name : 'Couriers',
                    component : () => import('@/views/Couriers.vue')
                }
            ]
        },
    ]
})
