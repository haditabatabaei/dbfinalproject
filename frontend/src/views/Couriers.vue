<template>
    <div>
        <base-header type="gradient-success" class="pb-6 pb-8 pt-5 pt-md-8">
            <!-- Card stats -->
            <div class="row">
                <div class="col-xl-3 col-lg-6">
                    <stats-card title="کل شرکت های موجود"
                                type="gradient-red"
                                :sub-title="couriersLength"
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
                    <couriers-table @updateCouriersList="getCouriers()" title="لیست پیک ها" :data="couriers"></couriers-table>
                </div>
                <base-button type="success" @click="showNewCourierModal = true" >ایجاد پیک جدید</base-button>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <modal :show.sync="showNewCourierModal"
                           body-classes="p-0"
                           modal-classes="modal-dialog-centered modal-lg">
                        <div class="p-4">
                            <h6 class="heading-small text-muted text-sm text-right" style="direction: rtl">پیک جدید :</h6>
                            <div class="row" style="direction: rtl">
                                <div class="col-lg-6">
                                    <base-input alternative=""
                                                label="نام :"
                                                placeholder="نام"
                                                input-classes="form-control-alternative"
                                                v-model="newCourier.title"
                                    />
                                </div>
                                <div class="col-lg-6">
                                    <base-input alternative=""
                                                label="نام :"
                                                placeholder="نام"
                                                input-classes="form-control-alternative"
                                                v-model="newCourier.first_name"
                                    />
                                </div>
                                <div class="col-lg-6">
                                    <base-input alternative=""
                                                label="نام خانوادگی :"
                                                placeholder="نام خانوادگ"
                                                input-classes="form-control-alternative"
                                                v-model="newCourier.last_name"
                                    />
                                </div>
                                <div class="col-lg-6">
                                    <base-input alternative=""
                                                label="کد ملی :"
                                                input-classes="form-control-alternative"
                                                v-model="newCourier.identification_number"
                                    />
                                </div>
                                <div class="col-lg-6">
                                    <base-input alternative=""
                                                label= "شماره تماس"
                                                input-classes="form-control-alternative"
                                                v-model="newCourier.phone_number"
                                    />
                                </div>
                            </div>
                        </div>
                        <template slot="footer">
                            <base-button outline type="success" @click="createNewCourier()">ثبت پیک جدید</base-button>
                            <base-button type="link-secondary" class="ml-auto" @click="showNewCourierModal = false">
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
    import CouriersTable from "@/views/Tables/CouriersTable";
    export default {
        name: 'Couriers',
        components: {
            "couriers-table" : CouriersTable
        },
        data() {
            return {
                couriers : [],
                newCourier : {},
                showNewCourierModal : false,
            }
        },
        computed : {
            couriersLength : function() {
                if(this.couriers === undefined) {
                    return "0"
                } else return this.couriers.length + ""
            }
        },
        methods : {
            async getCouriers() {
                this.couriers = (await axios.get('http://localhost:3000/api/v1/couriers')).data;
                console.log('couriers',this.couriers);
            },
            async createNewCourier() {
                try {
                    let result = (await axios.post('http://localhost:3000/api/v1/couriers', this.newCourier)).data;
                    console.log(result);
                    await this.getCouriers();
                    this.showNewCourierModal = false;
                    this.newCourier = {}
                }catch (e) {
                    console.log(e.response);
                }
            },


        },
        created() {
            this.getCouriers();
        },
    };
</script>
<style scoped/>
