<template>
    <div>
        <base-header type="gradient-success" class="pb-6 pb-8 pt-5 pt-md-8">
            <!-- Card stats -->
            <div class="row">
                <div class="col-xl-3 col-lg-6">
                    <stats-card title="کل شرکت های موجود"
                                type="gradient-red"
                                :sub-title="suppliersLength"
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
                    <suppliers-table @updateSuppliersList="getSuppliers()" title="لیست شرکت ها" :data="suppliers"></suppliers-table>
                </div>
                <base-button type="success" @click="showNewSupplierModal = true" >ایجاد شرکت جدید</base-button>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <modal :show.sync="showNewSupplierModal"
                           body-classes="p-0"
                           modal-classes="modal-dialog-centered modal-lg">
                        <div class="p-4">
                            <h6 class="heading-small text-muted text-sm text-right" style="direction: rtl">شرکت جدید :</h6>
                            <div class="row" style="direction: rtl">
                                <div class="col-lg-6">
                                    <base-input alternative=""
                                                label="نام :"
                                                placeholder="نام"
                                                input-classes="form-control-alternative"
                                                v-model="newSupplier.title"
                                    />
                                </div>
                                <div class="col-lg-6">
                                    <base-checkbox v-model="newSupplier.is_available">
                                        وضعیت فعال بودن شرکت
                                    </base-checkbox>
                                </div>
                            </div>
                        </div>
                        <template slot="footer">
                            <base-button outline type="success" @click="createNewSupplier()">ثبت شرکت جدید</base-button>
                            <base-button type="link-secondary" class="ml-auto" @click="showNewSupplierModal = false">
                                منصرف شدم
                            </base-button>
                        </template>
                    </modal>
                </div>
            </div>
        </div>

    </div>
</template>
<script>
    import axios from 'axios';
    import SuppliersTable from "@/views/Tables/SuppliersTable";
    export default {
        name: 'Suppliers',
        components: {
            "suppliers-table" : SuppliersTable
        },
        data() {
            return {
                suppliers : [],
                newSupplier : {},
                showNewSupplierModal : false,
            }
        },
        computed : {
            suppliersLength : function() {
                if(this.suppliers === undefined) {
                    return "0"
                } else return this.suppliers.length + ""
            }
        },
        methods : {
            async getSuppliers() {
                this.suppliers = (await axios.get('http://localhost:3000/api/v1/suppliers')).data;
                console.log('suppliers',this.suppliers);
            },
            async createNewSupplier() {
                try {
                    let result = (await axios.post('http://localhost:3000/api/v1/suppliers', this.newSupplier)).data;
                    console.log(result);
                    await this.getSuppliers();
                    this.showNewSupplierModal = false;
                    this.newSupplier = {}
                }catch (e) {
                    console.log(e.response);
                }
            },


        },
        created() {
            this.getSuppliers();
        },
    };
</script>
<style scoped/>
