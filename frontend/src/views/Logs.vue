<template>
    <div>
        <div class="container-fluid mt--7">
            <div class="row">
                <div class="col">
                    <clogs-table title="لاگ مشتریان" :data="clogs"></clogs-table>
                    <alogs-table title="لاگ آدرس" :data="alogs"></alogs-table>
                    <slogs-table title="لاگ شرکت" :data="slogs"></slogs-table>
                    <courlogs-table title="لاگ پیک" :data="courlogs"></courlogs-table>
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
    import UserLogTable from "./Tables/UserLogTable";
    import SupplierLogTable from "./Tables/SupplierLogTable";
    import AddressLogTable from "./Tables/AddressLogTable";
    import CourierLogTable from "./Tables/CourierLogTable";
    export default {
        name: 'Orders',
        components: {
            "clogs-table" : UserLogTable,
            "alogs-table" : AddressLogTable,
            "slogs-table" : SupplierLogTable,
            "courlogs-table" : CourierLogTable,
        },
        data() {
            return {
                clogs : [],
                alogs : [],
                slogs : [],
                courlogs : [],
            }
        },
        computed : {

        },
        methods : {
            async getLogs() {
                this.clogs = (await axios.get('http://localhost:3000/api/v1/logs/customer')).data;
                this.alogs = (await axios.get('http://localhost:3000/api/v1/logs/address')).data;
                this.slogs = (await axios.get('http://localhost:3000/api/v1/logs/supplier')).data;
                this.courlogs = (await axios.get('http://localhost:3000/api/v1/logs/courier')).data;
            },
        },
        async created() {
            await this.getLogs();
        },
    };
</script>
<style scoped/>
