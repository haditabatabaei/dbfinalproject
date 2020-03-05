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
                    <th>نام خانوادگی</th>
                    <th>کد ملی</th>
                    <th>شماره تماس</th>
                    <th>عملیات</th>
                </template>

                <template slot-scope="{row}">
                    <th scope="row">
                        {{row.id}}
                    </th>
                    <td class="budget">
                        {{row.first_name}}
                    </td>
                    <td>
                        {{row.last_name}}
                    </td>
                    <td>
                        {{row.identification_number}}
                    </td>
                    <td>
                        {{row.phone_number}}
                    </td>
                    <td class="text-right">
                        <base-dropdown class="dropdown"
                                       position="left">
                            <a slot="title" class="btn btn-sm btn-icon-only text-light" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-ellipsis-v"></i>
                            </a>
                            <template>
                                <button @click="handleUpdateCourierModal(row)" class="dropdown-item" >ویرایش پیک</button>
                                <button @click="removeCourier(row.id)" class="dropdown-item">حذف پیک</button>
                            </template>
                        </base-dropdown>
                    </td>

                </template>

            </base-table>
            <div class="row">
                <div class="col-md-12">
                    <modal :show.sync="showUpdateCourierModal"
                           body-classes="p-0"
                           modal-classes="modal-dialog-centered modal-lg">
                        <div class="p-4">
                            <h6 class="heading-small text-muted text-sm text-right" style="direction: rtl">ویرایش شرکت :</h6>
                            <div class="row" style="direction: rtl">
                                <div class="col-lg-6">
                                    <base-input alternative=""
                                                label="نام :"
                                                placeholder="نام"
                                                input-classes="form-control-alternative"
                                                v-model="onEditCourier.first_name"
                                    />
                                </div>
                                <div class="col-lg-6">
                                    <base-input alternative=""
                                                label="نام خانوادگی :"
                                                placeholder="نام خانوادگ"
                                                input-classes="form-control-alternative"
                                                v-model="onEditCourier.last_name"
                                    />
                                </div>
                                <div class="col-lg-6">
                                    <base-input alternative=""
                                                label="کد ملی :"
                                                input-classes="form-control-alternative"
                                                v-model="onEditCourier.identification_number"
                                    />
                                </div>
                                <div class="col-lg-6">
                                    <base-input alternative=""
                                                label= "شماره تماس"
                                                input-classes="form-control-alternative"
                                                v-model="onEditCourier.phone_number"
                                    />
                                </div>
                            </div>
                        </div>
                        <template slot="footer">
                            <base-button outline type="success" @click="updateOnEditCourier()">ویرایش شرکت</base-button>
                            <base-button type="link-seocndary" class="ml-auto" @click="showUpdateCourierModal = false">
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
        name: 'CouriersTable',
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
            async removeCourier(courierId) {
                try {
                    let result = (await axios.delete("http://localhost:3000/api/v1/couriers/" + courierId)).data;
                    console.log(result);
                    this.$emit('updateCouriersList');
                } catch (e) {
                    console.log(e.response);
                }
            },
            async updateOnEditCourier() {
                try {
                    let result = (await axios.patch('http://localhost:3000/api/v1/couriers/' + this.onEditCourier.id, this.onEditCourier)).data;
                    console.log(result);
                    this.showUpdateCourierModal = false;
                    await this.$emit('updateCouriersList');
                }catch (e) {
                    console.log(e.response);
                }
            },
            handleUpdateCourierModal(inputCourier) {
                this.showUpdateCourierModal = true;
                this.onEditCourier = inputCourier;
            }
        },
        data() {
            return {
                onEditCourier : {},
                showUpdateCourierModal : false
            }
        }
    }
</script>
<style>
</style>
