<template>
    <div>
        <base-header class="header pb-8 pt-5 pt-lg-8 d-flex align-items-center"
                     style="min-height: 200px">
            <!-- Mask -->

            <span class="mask bg-gradient-success opacity-8"></span>
            <!-- Header container -->
            <div class="container-fluid" style="direction:rtl">
                <div class="row">
                    <div class="col-lg-7 col-md-10">
                        <h1 class="display-2 text-white text-right">ویرایش مشتری :</h1>
                    </div>
                </div>
            </div>
        </base-header>

        <div class="container-fluid mt--7">
            <div class="row">

                <div class="col-xl-12">
                    <card shadow type="secondary">
                        <div slot="header" class="bg-white border-0">
                            <div class="row align-items-center">
                                <div class="col-8">
                                </div>
                                <div class="col-4 text-right">
                                </div>
                            </div>
                        </div>
                        <template>
                            <form @submit.prevent style="direction:rtl;">
                                <h6 class="heading-small text-muted mb-4 text-right">اطلاعات مشتری</h6>
                                <div class="pl-lg-4">
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <base-input alternative=""
                                                        label="نام :"
                                                        placeholder="نام"
                                                        input-classes="form-control-alternative"
                                                        label-classes="is-rtl"
                                                        v-model="user.first_name"
                                            />
                                        </div>
                                        <div class="col-lg-6">
                                            <base-input alternative=""
                                                        label="نام خانوادگی :"
                                                        placeholder="نام خانوادگی"
                                                        input-classes="form-control-alternative"
                                                        v-model="user.last_name"
                                            />
                                        </div>

                                    </div>
                                    <div class="row">
                                        <div class="col-lg-5">
                                            <base-input alternative=""
                                                        label="کد ملی :"
                                                        placeholder="کد ملی"
                                                        input-classes="form-control-alternative"
                                                        v-model="user.identification_number"
                                            />
                                        </div>
                                        <div class="col-lg-5">
                                            <base-input alternative=""
                                                        label="شماره تماس :"
                                                        placeholder="شماره تماس"
                                                        input-classes="form-control-alternative"
                                                        v-model="user.phone_number"
                                            />
                                        </div>
                                        <div class="col-lg-2">
                                            <base-input
                                                    label="سن :"
                                                    placeholder="سن"
                                                    input-classes="form-control-alternative"
                                                    v-model="user.age"
                                            />
                                        </div>
                                        <div class="col-md-12">
                                            <base-button type="success" @click="editUser()">ویرایش اطلاعات مشتری
                                            </base-button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                            <hr class="my-4"/>
                            <form style="direction:rtl">
                                <!-- Address -->
                                <h6 class="heading-small text-muted mb-4 text-right">آدرس های کاربر :</h6>
                                <div v-for="(userAddr, index) in userAddresses" :key="index" class="pl-lg-4">
                                    <h6 class="heading-small text-muted text-sm text-right"> آدرس : {{index + 1}}</h6>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <base-input alternative=""
                                                        label="آدرس :"
                                                        placeholder="آدرس"
                                                        input-classes="form-control-alternative"
                                                        v-model="userAddr.text"
                                            />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <base-input alternative=""
                                                        label="شماره تلفن ثابت :"
                                                        placeholder="شماره تلفن ثابت"
                                                        input-classes="form-control-alternative"
                                                        v-model="userAddr.static_phone"
                                            />
                                        </div>
                                        <div class="col-lg-6">
                                            <base-input alternative=""
                                                        label="نام آدرس :"
                                                        placeholder="نام آدرس"
                                                        input-classes="form-control-alternative"
                                                        v-model="userAddr.name"
                                            />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-12 d-flex align-items-center justify-content-center">
                                            <base-button role="button" type="info" @click="editAddress(userAddr.id,userAddr)">ویرایش این آدرس</base-button>
                                            <base-button role="button" class="mr-2" type="danger" @click="removeAddress(userAddr.id)">حذف این آدرس</base-button>
                                        </div>
                                    </div>
                                </div>
                                <hr class="my-4"/>
                            </form>

                            <div class="row">
                                <div class="col-md-12">
                                    <base-button type="success" class="mt-3" @click="showNewAddrModal = true">
                                        اضافه کردن آدرس جدید
                                    </base-button>

                                    <modal :show.sync="showNewAddrModal"
                                           body-classes="p-0"
                                           style="direction:ltr"
                                           modal-classes="modal-dialog-centered modal-lg">
                                        <div class="p-4">
                                            <h6 class="heading-small text-muted text-sm text-right" style="direction: rtl">آدرس جدید :</h6>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <base-input alternative=""
                                                                label="آدرس :"
                                                                placeholder="آدرس"
                                                                input-classes="form-control-alternative"
                                                                v-model="newAddr.text"
                                                    />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-lg-6">
                                                    <base-input alternative=""
                                                                label="شماره تلفن ثابت :"
                                                                placeholder="شماره تلفن ثابت"
                                                                input-classes="form-control-alternative"
                                                                v-model="newAddr.static_phone"
                                                    />
                                                </div>
                                                <div class="col-lg-6">
                                                    <base-input alternative=""
                                                                label="نام آدرس :"
                                                                placeholder="نام آدرس"
                                                                input-classes="form-control-alternative"
                                                                v-model="newAddr.name"
                                                    />
                                                </div>
                                            </div>
                                        </div>
                                        <template slot="footer">
                                            <base-button outline type="success" @click="createNewAddr()">ثبت آدرس جدید</base-button>
                                            <base-button type="link-seocndary" class="ml-auto" @click="showNewAddrModal = false">
                                                منصرف شدم
                                            </base-button>
                                        </template>
                                    </modal>
                                </div>
                            </div>
                            <div class="row mt-2">
                                <div class="col-md-12">
                                    <card header-classes="bg-transparent">
                                        <div slot="header" class="row align-items-center">
                                            <div class="col">
                                                <h6 class="text-uppercase text-muted ls-1 mb-1">غذا های محبوب</h6>
                                                <h5 class="h3 mb-0">بیشترین دفعات سفارش</h5>
                                            </div>
                                        </div>

                                        <bar-chart
                                                :height="350"
                                                ref="barChart"
                                                :chart-data="redBarChart.chartData">
                                        </bar-chart>
                                    </card>
                                </div>
                            </div>
                        </template>
                    </card>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    import axios from 'axios';
    import * as chartConfigs from '@/components/Charts/config';
    import LineChart from '@/components/Charts/LineChart';
    import BarChart from '@/components/Charts/BarChart';
    export default {
        components : {
            LineChart,
            BarChart
        },
        name: 'user-profile',
        data() {
            return {
                showNewAddrModal : false,
                newAddr : {},
                user: {},
                userAddresses: [],
                redBarChart: {
                    chartData: {
                        labels: [],
                        datasets: [{
                            label: 'تعداد غذا ها',
                            data: []
                        }]
                    }
                },
                model: {
                    username: '',
                    email: '',
                    firstName: '',
                    lastName: '',
                    address: '',
                    city: '',
                    country: '',
                    zipCode: '',
                    about: '',
                },
                dataModels : []
            }
        },
        methods: {
            async getCurrentUser() {
                this.user = (await axios.get('http://localhost:3000/api/v1/users/' + this.$route.params.id)).data;
                console.log(this.user);
            },
            async getUserAddresses() {
                this.userAddresses = (await axios.get('http://localhost:3000/api/v1/users/' + this.$route.params.id + '/addresses')).data;
                console.log(this.userAddresses);
            },
            async editUser() {
                console.log(this.user);
                try {
                    let result = (await axios.patch('http://localhost:3000/api/v1/users/' + this.$route.params.id, this.user)).data;
                    console.log(result);
                } catch (e) {
                    console.log(e.response);
                }
            },

            async editAddress(addressId, payload) {
                try {
                    let result = await (axios.patch('http://localhost:3000/api/v1/addresses/' + addressId , payload)).data;
                    console.log(result);
                    await this.getUserAddresses();
                }catch (e){
                    console.log(e.response);
                }
            },

            async removeAddress(addressId) {
              try {
                  let result = await (axios.delete('http://localhost:3000/api/v1/users/' + this.$route.params.id + '/addresses/' + addressId)).data;
                  console.log(result);
                  this.getUserAddresses();
              }  catch(e) {
                  console.log(e.response);
              }
            },

            async createNewAddr() {
                try {
                    // create new address
                    let newAddrResult = (await axios.post('http://localhost:3000/api/v1/addresses', this.newAddr)).data;
                    //add address to user
                    console.log(newAddrResult);
                    let putresult = (await axios.put("http://localhost:3000/api/v1/users/" + this.$route.params.id + "/addresses/" + newAddrResult.id)).data;
                    console.log(putresult);
                    this.getUserAddresses();
                } catch(e) {
                    console.log(e.response);
                }
            },
            async getMostFavFoods() {
                try {
                    let result = await axios.get("http://localhost:3000/api/v1/reports/users/" + this.$route.params.id + '/mostfavfoods');
                    console.log(result.data);
                    for(let item of result.data) {
                        this.redBarChart.chartData.labels.push(item.food_name);
                        this.redBarChart.chartData.datasets[0].data.push(item.total_picks)
                    }

                }catch (e) {
                    console.log(e.response);
                }
            }
        },
        created() {
            this.getCurrentUser();
            this.getUserAddresses();
            this.getMostFavFoods();
        }

    };
</script>
<style scoped>

</style>
