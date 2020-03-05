<template>
    <div>
        <base-header type="gradient-success" class="pb-6 pb-8 pt-5 pt-md-8">
            <!-- Card stats -->
            <div class="row">
                <div class="col-xl-3 col-lg-6">
                    <stats-card title="سفارشات"
                                type="gradient-red"
                                :sub-title="ordersLength"
                                icon="ni ni-active-40"
                                class="mb-4 mb-xl-0">

                        <template slot="footer">
                        </template>
                    </stats-card>
                </div>
            </div>
        </base-header>

        <div class="container-fluid mt--7">
            <div class="row">
                <div class="col">
                    <orders-table @updateOrdersList="getOrders" title="لیست سفارشات رستوران" :data="orders"></orders-table>
                </div>
            </div>
            <div class="row mt-5">
                <div class="col">
                </div>
            </div>
        </div>

    </div>
</template>
<script>
    import axios from 'axios';
    import OrdersTable from "@/views/Tables/OrdersTable";
    export default {
        name: 'Orders',
        components: {
            "orders-table" : OrdersTable
        },
        data() {
            return {
                orders : [],
            }
        },
        computed : {
            ordersLength : function() {
                if(this.orders === undefined) {
                    return "0"
                } else return this.orders.length + ""
            }
        },
        methods : {
            async getOrders() {
                this.orders = (await axios.get('http://localhost:3000/api/v1/orders')).data;
                console.log('orders ',this.orders);
            },
        },
        async created() {
            await this.getOrders();
        },
    };
</script>
<style scoped/>
