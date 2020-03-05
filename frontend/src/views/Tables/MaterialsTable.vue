<template>
    <div class="card shadow"
         :class="type === 'dark' ? 'bg-default': ''">
        <div class="card-header border-0"
             :class="type === 'dark' ? 'bg-transparent': ''">
            <div class="row" style="direction:rtl" >
                <div class="col-md-12 d-flex align-items-center justify-content-between">
                    <h3 class="mb-0 text-right" :class="type === 'dark' ? 'text-white': ''">
                        {{title}}
                    </h3>
                </div>
            </div>
        </div>

        <div class="table-responsive">
            <base-table class="table align-items-center table-flush" style="direction:rtl;text-align:right;"
                        :class="type === 'dark' ? 'table-dark': ''"
                        :thead-classes="type === 'dark' ? 'thead-dark': 'thead-light'"
                        tbody-classes="list"
                        :data="data">
                <template slot="columns">
                    <th>ID</th>
                    <th>نام</th>
                    <th>قیمت</th>
                    <th>عملیات</th>
                </template>

                <template slot-scope="{row}">
                    <th scope="row">
                        {{row.material_id}}
                    </th>
                    <td class="budget">
                        {{row.name}}
                    </td>
                    <td>
                        {{row.price}}
                    </td>
                    <td class="text-right">
                        <base-dropdown class="dropdown"
                                       position="left">
                            <a slot="title" class="btn btn-sm btn-icon-only text-light" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-ellipsis-v"></i>
                            </a>
                            <template>
                                <button @click="handleUpdateMaterialModal(row)" class="dropdown-item" >ویرایش ماده اولیه</button>
                                <button @click="removeMaterial(row.material_id)" class="dropdown-item">حذف ماده اولیه از منو</button>
                            </template>
                        </base-dropdown>
                    </td>

                </template>

            </base-table>
            <div class="row">
                <div class="col-md-12">
                    <modal :show.sync="showUpdateMaterialModal"
                           body-classes="p-0"
                           modal-classes="modal-dialog-centered modal-lg">
                        <div class="p-4">
                            <h6 class="heading-small text-muted text-sm text-right" style="direction: rtl">ویرایش ماده اولیه :</h6>
                            <div class="row" style="direction: rtl">
                                <div class="col-lg-6">
                                    <base-input alternative=""
                                                label="نام :"
                                                placeholder="نام "
                                                input-classes="form-control-alternative"
                                                v-model="onEditMaterial.name"
                                    />
                                </div>
                                <div class="col-lg-6">
                                    <base-input alternative=""
                                                label="قیمت :"
                                                placeholder="قیمت"
                                                input-classes="form-control-alternative"
                                                v-model="onEditMaterial.price"
                                    />
                                </div>
                            </div>
                        </div>
                        <template slot="footer">
                            <base-button outline type="success" @click="updateOnEditMaterial()">ویرایش ماده اولیه</base-button>
                            <base-button type="link-seocndary" class="ml-auto" @click="showUpdateMaterialModal = false">
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
    import axios from 'axios'
    export default {
        name: 'MaterialsTable',
        props: {
            type: {
                type: String
            },
            title: String,
            data: {
                type : Array
            }
        },
        methods : {
            async removeMaterial(materialId) {
                try {
                    let result = (await axios.delete("http://localhost:3000/api/v1/materials/" + materialId)).data;
                    console.log(result);
                    this.$emit('updateMaterialsList');
                } catch (e) {
                    console.log(e.response);
                }
            },
            async updateOnEditMaterial() {
                try {
                    let result = (await axios.patch('http://localhost:3000/api/v1/materials/' + this.onEditMaterial.material_id, this.onEditMaterial)).data;
                    console.log(result);
                    this.showUpdateMaterialModal = false;
                    await this.$emit('updateMaterialsList');
                }catch (e) {
                    console.log(e.response);
                }
            },
            handleUpdateMaterialModal(inputMaterial) {
                this.showUpdateMaterialModal = true;
                this.onEditMaterial = inputMaterial;
            }
        },
        data() {
            return {
                onEditMaterial : {},
                showUpdateMaterialModal : false
            }
        }
    }
</script>
<style>
</style>
