<template>
    <div>
        <div class="container-fluid mt-7" style="direction: rtl">
            <div class="row">
                <div class="col-lg-6">
                    <materials-for-supplierOrder @materialAmountChanged="updateMaterialTotalAmount" title="لیست مواد اولیه فعلی" :data="materials"></materials-for-supplierOrder>
                </div>
                <div class="col-lg-6">
                    <div class="row">
                        <div class="col-md-12">
                            <h6 class="text-muted text-right">
                                لطفا شرکت را انتخاب کنید :
                            </h6>
                            <select v-model="selectedSupplier" class="form-control">
                                <option :value="supplier" v-for="(supplier, index) in suppliers" :key="index">
                                    {{supplier.title}}
                                </option>
                            </select>
                        </div>

                        <div class="col-md-12 mt-3">
                            <base-button @click="createNewSupplierOrder()" type="success">
                                ایجاد سفارش جدید | مبلغ کل : {{supplierOrderTotalPrice}}
                            </base-button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import axios from 'axios'
    import MaterialsForSupplierOrderTable from "@/views/Tables/MaterialsForSupplierOrderTable";

    export default {
        name: "NewSupplierOrder",
        components: {
            'materials-for-supplierOrder': MaterialsForSupplierOrderTable
        },
        data() {
            return {
                materials: [],
                suppliers: [],
                selectedSupplier: {},
                selectedMaterials : [],
                supplierOrderTotalPrice : 0,
            }
        },
        methods: {
            async getMaterials() {
                this.materials = (await axios.get('http://localhost:3000/api/v1/materials')).data;
                console.log('materials', this.materials);
            },
            async getSuppliers() {
                this.suppliers = (await axios.get('http://localhost:3000/api/v1/suppliers')).data;
                console.log('suppliers', this.suppliers);
            },
            async createNewSupplierOrder() {
                try {
                    let supplierOrderToSend = {};
                    supplierOrderToSend.materials = this.selectedMaterials;
                    supplierOrderToSend.supplier_id = this.selectedSupplier.id;
                    console.log(supplierOrderToSend);
                    let createSupplierOrderResponse = await axios.post('http://localhost:3000/api/v1/supplierorders', supplierOrderToSend);
                    console.log(createSupplierOrderResponse.data);
                } catch (e) {
                    console.log(e.response);
                }
            },

            updateMaterialTotalAmount(materials) {
                this.selectedMaterials = [];
                this.supplierOrderTotalPrice = 0;
                for(let material of materials) {
                    if(material.amount && material.amount > 0) {
                        this.supplierOrderTotalPrice += (material.amount * material.price);
                        this.selectedMaterials.push(material);
                    }
                }
            },
        },
        computed: {
        },
        created() {
            this.getMaterials();
            this.getSuppliers();
        }
    }
</script>

<style scoped>

</style>