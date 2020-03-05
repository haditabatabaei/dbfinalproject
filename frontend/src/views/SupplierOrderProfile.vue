<template>
    <div>
        <base-header class="header pb-8 pt-5 pt-lg-8 d-flex align-items-center"
                     style="min-height: 300px;">
            <!-- Mask -->
            <span class="mask bg-gradient-success opacity-8"></span>
            <!-- Header container -->
        </base-header>

        <div class="container-fluid mt--7">
            <div class="row">
                <div class="col-xl-4 order-xl-2 mb-5 mb-xl-0">
                    <div class="card card-profile shadow">
                        <div class="card-body pt-0 pt-md-4">
                            <h5 class="text-center">
                                {{(new Date(supplierOrder.issue_date)).toLocaleString()}}
                            </h5>
                            <hr>
                            <ul style="direction:rtl;list-style:none" class="text-center p-0">
                                <li v-for="(material,index) in materials" :key="index" class="text-sm mt-1">
                                    {{material.material_name + " | " + material.price + " | " + material.amount + " | " + (material.total_price)}}
                                </li>
                            </ul>

                            <base-alert class="text-center" type="info"> هزینه قابل پرداخت :
                                <strong>{{orderTotalSum}}</strong> تومان
                            </base-alert>
                        </div>
                    </div>
                </div>

                <div class="col-xl-8 order-xl-1">
                    <card shadow type="secondary">
                        <div slot="header" class="bg-white border-0">
                            <div class="row align-items-center">
                                <div class="col-8">
                                    <h3 class="mb-0">اطلاعات کلی سفارش</h3>
                                </div>
                            </div>
                        </div>
                        <template>
                            <form>
                                <h6 class="heading-small text-muted mb-4">اطلاعات شرکت :</h6>
                                <div class="pl-lg-4">
                                    <div class="row" style="direction: rtl">
                                        <div class="col-lg-6">
                                            <base-input alternative=""
                                                        label="نام :"
                                                        disabled
                                                        placeholder="نام"
                                                        input-classes="form-control-alternative"
                                                        v-model="supplier.title"
                                            />
                                        </div>
                                        <div class="col-lg-6">
                                            <base-alert style="direction: rtl;text-align:center" type="success" v-if="supplier.is_available">
                                                وضعیت : فعال
                                            </base-alert>
                                            <base-alert style="direction: rtl;text-align:center" v-else type="warning">
                                                وضعیت : غیر فعال
                                            </base-alert>
                                        </div>
                                    </div>
                                </div>
                                <hr class="my-4"/>
                            </form>
                        </template>
                    </card>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import axios from 'axios'

    export default {
        name: "SupplierOrderProfile",
        data() {
            return {
                supplierOrder: {},
                materials : [],
                supplier: {},
            }
        },
        computed: {
            orderTotalSum: function () {
                let sum = 0;
                for (let material of this.materials) {
                    sum += Number(material.total_price);
                }
                return sum;
            }
        },
        methods: {
            async getSupplierOrder() {
                this.supplierOrder = (await axios.get('http://localhost:3000/api/v1/supplierorders/' + this.$route.params.id)).data;
                console.log(this.supplierOrder);
            },

            async getSupplierOrderMaterials() {
                this.materials = (await axios.get('http://localhost:3000/api/v1/supplierorders/' + this.$route.params.id + '/materials')).data;
                console.log('materials', this.materials);
            },
            async getSupplierOrderSupplier() {
                this.supplier = (await axios.get('http://localhost:3000/api/v1/supplierorders/' + this.$route.params.id + '/supplier')).data;
                console.log('supplier', this.supplier);
            },
        },
        created() {
            this.getSupplierOrder();
            this.getSupplierOrderMaterials();
            this.getSupplierOrderSupplier();
        }
    }
</script>

<style scoped>

</style>