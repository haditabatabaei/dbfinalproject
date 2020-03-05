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
                    <th>وضعیت فعالیت</th>
                    <th>عملیات</th>
                </template>

                <template slot-scope="{row}">
                    <th scope="row">
                        {{row.supplier_id}}
                    </th>
                    <td class="budget">
                        {{row.title}}
                    </td>
                    <td>
                        {{row.is_available}}
                    </td>
                    <td class="text-right">
                        <base-dropdown class="dropdown"
                                       position="left">
                            <a slot="title" class="btn btn-sm btn-icon-only text-light" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-ellipsis-v"></i>
                            </a>
                            <template>
                                <button @click="handleUpdateSupplierModal(row)" class="dropdown-item" >ویرایش شرکت</button>
                                <button @click="removeSupplier(row.id)" class="dropdown-item">حذف شرکت از منو</button>
                            </template>
                        </base-dropdown>
                    </td>

                </template>

            </base-table>
            <div class="row">
                <div class="col-md-12">
                    <modal :show.sync="showUpdateSupplierModal"
                           body-classes="p-0"
                           modal-classes="modal-dialog-centered modal-lg">
                        <div class="p-4">
                            <h6 class="heading-small text-muted text-sm text-right" style="direction: rtl">ویرایش شرکت :</h6>
                            <div class="row" style="direction: rtl">
                                <div class="col-lg-6">
                                    <base-input alternative=""
                                                label="نام  :"
                                                placeholder="نام "
                                                input-classes="form-control-alternative"
                                                v-model="onEditSupplier.title"
                                    />
                                </div>
                                <div class="col-lg-6">
                                    <base-checkbox style="direction: rtl;text-align:right" class="mb-3" v-model="onEditSupplier.is_available">
                                        وضعیت فعال بودن شرکت
                                    </base-checkbox>
                                </div>
                            </div>
                        </div>
                        <template slot="footer">
                            <base-button outline type="success" @click="updateOnEditSupplier()">ویرایش شرکت</base-button>
                            <base-button type="link-seocndary" class="ml-auto" @click="showUpdateSupplierModal = false">
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
        name: 'SuppliersTable',
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
            async removeSupplier(supplierId) {
                try {
                    let result = (await axios.delete("http://localhost:3000/api/v1/suppliers/" + supplierId)).data;
                    console.log(result);
                    this.$emit('updateSuppliersList');
                } catch (e) {
                    console.log(e.response);
                }
            },
            async updateOnEditSupplier() {
                try {
                    let result = (await axios.patch('http://localhost:3000/api/v1/suppliers/' + this.onEditSupplier.id, this.onEditSupplier)).data;
                    console.log(result);
                    this.showUpdateSupplierModal = false;
                    await this.$emit('updateSuppliersList');
                }catch (e) {
                    console.log(e.response);
                }
            },
            handleUpdateSupplierModal(inputSupplier) {
                this.showUpdateSupplierModal = true;
                this.onEditSupplier = inputSupplier;
            }
        },
        data() {
            return {
                onEditSupplier : {},
                showUpdateSupplierModal : false
            }
        }
    }
</script>
<style>
</style>
