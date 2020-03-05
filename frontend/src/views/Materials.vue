<template>
    <div>
        <base-header type="gradient-success" class="pb-6 pb-8 pt-5 pt-md-8">
            <!-- Card stats -->
            <div class="row">
                <div class="col-xl-3 col-lg-6">
                    <stats-card title="کل مواد اولیه موجود"
                                type="gradient-red"
                                :sub-title="materialsLength"
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
                    <materials-table @updateMaterialsList="getMaterials()" title="لیست مواد اولیه" :data="materials"></materials-table>
                </div>
                <base-button type="success" @click="showNewMaterialModal = true" >ایجاد مواد اولیه جدید</base-button>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <modal :show.sync="showNewMaterialModal"
                           body-classes="p-0"
                           modal-classes="modal-dialog-centered modal-lg">
                        <div class="p-4">
                            <h6 class="heading-small text-muted text-sm text-right" style="direction: rtl">ماده جدید :</h6>
                            <div class="row" style="direction: rtl">
                                <div class="col-lg-6">
                                    <base-input alternative=""
                                                label="نام :"
                                                placeholder="نام"
                                                input-classes="form-control-alternative"
                                                v-model="newMaterial.name"
                                    />
                                </div>
                                <div class="col-lg-6">
                                    <base-input alternative=""
                                                label="قیمت :"
                                                placeholder="قیمت"
                                                input-classes="form-control-alternative"
                                                v-model="newMaterial.price"
                                    />
                                </div>
                            </div>
                        </div>
                        <template slot="footer">
                            <base-button outline type="success" @click="createNewMaterial()">ثبت ماده اوله جدید</base-button>
                            <base-button type="link-seocndary" class="ml-auto" @click="showNewMaterialModal = false">
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
    import MaterialsTable from "@/views/Tables/MaterialsTable";
    export default {
        name: 'Materials',
        components: {
            "materials-table" : MaterialsTable
        },
        data() {
            return {
                materials : [],
                newMaterial : {},
                showNewMaterialModal : false,
            }
        },
        computed : {
            materialsLength : function() {
                if(this.materials === undefined) {
                    return "0"
                } else return this.materials.length + ""
            }
        },
        methods : {
            async getMaterials() {
                this.materials = (await axios.get('http://localhost:3000/api/v1/materials')).data;
                console.log('materials',this.materials);
            },
            async createNewMaterial() {
                try {
                    let result = (await axios.post('http://localhost:3000/api/v1/materials', this.newMaterial)).data;
                    console.log(result);
                    await this.getMaterials();
                    this.showNewMaterialModal = false;
                    this.newMaterial = {}
                }catch (e) {
                    console.log(e.response);
                }
            },


        },
        created() {
            this.getMaterials();
        },
    };
</script>
<style scoped/>
