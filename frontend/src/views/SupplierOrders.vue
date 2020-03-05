<template>
    <div>
        <base-header type="gradient-success" class="pb-6 pb-8 pt-5 pt-md-8">
            <!-- Card stats -->
            <div class="row">
                <div class="col-xl-3 col-lg-6">
                    <stats-card title="سفارشات"
                                type="gradient-red"
                                :sub-title="supplierOrdersLength"
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
                    <supplierOrders-table @updateSupplierOrdersList="getSupplierOrders" title="لیست سفارشات مواد اولیه رستوران" :data="supplierOrders"></supplierOrders-table>
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
    import SupplierOrdersTable from "@/views/Tables/SupplierOrdersTable";
    export default {
        name: 'SupplierOrders',
        components: {
            "supplierOrders-table" : SupplierOrdersTable
        },
        data() {
            return {
                supplierOrders : [],
            }
        },
        computed : {
            supplierOrdersLength : function() {
                if(this.supplierOrders === undefined) {
                    return "0"
                } else return this.supplierOrders.length + ""
            }
        },
        methods : {
            async getSupplierOrders() {
                let tempSupplierOrders = (await axios.get('http://localhost:3000/api/v1/supplierorders')).data;
                for(let order of tempSupplierOrders) {
                    order.supplier = (await axios.get("http://localhost:3000/api/v1/supplierorders/" + order.id + '/supplier')).data;
                }
                this.supplierOrders = tempSupplierOrders;
                console.log('supplierOrders ',this.supplierOrders);
            }
        },
        created() {
            this.getSupplierOrders();
        },
    };
</script>
<style scoped/>
