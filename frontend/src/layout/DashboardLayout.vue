<template>
    <div class="wrapper" :class="{ 'nav-open': $sidebar.showSidebar }">
        <side-bar
                :background-color="sidebarBackground"
                short-title="Seyed Mohammad Hadi Tabatabaei"
                title="Seyed Mohammad Hadi Tabatabaei"
        >
            <template slot="links">
                <sidebar-item v-for="(item,index) in menuItems" :key="index" :link="item"/>
                <base-button @click="createFoodTable()" type="success" outline>ساخت جدول غذا</base-button>
                <base-button @click="deleteFoodTable()" type="danger" outline>حذف جدول غذا</base-button>
            </template>
        </side-bar>
        <div class="main-content" :data="sidebarBackground">
            <dashboard-navbar></dashboard-navbar>
            <div @click="toggleSidebar">
                <fade-transition :duration="200" origin="center top" mode="out-in">
                    <!-- your content here -->
                    <router-view></router-view>
                </fade-transition>
            </div>
        </div>
    </div>
</template>
<script>
    import DashboardNavbar from './DashboardNavbar.vue';
    import ContentFooter from './ContentFooter.vue';
    import {FadeTransition} from 'vue2-transitions';
    import axios from 'axios'
    export default {
        components: {
            DashboardNavbar,
            ContentFooter,
            FadeTransition
        },
        data() {
            return {
                menuItems: [
                    {name: 'مشتریان', icon: 'ni ni-single-02', path: '/users'},
                    {name: 'پیک ها', icon: 'ni ni-single-02', path: '/couriers'},
                    {name : 'منوی رستوران', icon : 'ni ni-shop', path : '/foods'},
                    {name : 'سفارش جدید' ,icon : 'ni ni-single-copy-04', path : '/new/order'},
                    {name : 'سفارشات', icon : 'ni ni-bullet-list-67', path : '/orders'},
                    {name : 'لیست مواد اولیه', icon : 'ni ni-bullet-list-67', path : '/materials'},
                    {name : 'شرکت ها', icon : 'ni ni-bullet-list-67', path : '/suppliers'},
                    {name : 'سفارش مواد اولیه جدید', icon : 'ni ni-bullet-list-67', path : '/new/supplierorder'},
                    {name : 'سفارشات شرکتی', icon : 'ni ni-bullet-list-67', path : '/supplierorders'},
                    {name : 'گزارش ها', icon : 'ni ni-bullet-list-67', path : '/reports'},
                    {name : 'لاگ ها', icon : 'ni ni-bullet-list-67', path : '/logs'},
                ],
                sidebarBackground: 'vue' //vue|blue|orange|green|red|primary
            };
        },
        methods: {
            toggleSidebar() {
                if (this.$sidebar.showSidebar) {
                    this.$sidebar.displaySidebar(false);
                }
            },

            async createFoodTable() {
                let result = await axios.post('http://localhost:3000/api/v1/logs/foods/table');
                console.log(result);
            },

            async deleteFoodTable() {
                let result = await axios.delete('http://localhost:3000/api/v1/logs/foods/table')
                console.log(result);
            }

        }
    };
</script>
<style lang="scss">
</style>
