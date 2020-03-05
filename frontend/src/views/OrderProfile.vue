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
                                {{(new Date(order.issue_date)).toLocaleString()}}
                            </h5>
                            <hr>
                            <ul style="direction:rtl;list-style:none" class="text-center p-0">
                                <li v-for="(food,index) in foods" :key="index" class="text-sm">
                                    {{food.food_name + " | " + food.price + " | " + food.amount + " | " + (food.price * food.amount)}}
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
                            <form @submit.prevent>
                                <h6 v-if="order.hasName" class="heading-small text-muted mb-4">اطلاعات مشتری :</h6>
                                <div v-if="order.hasName" class="pl-lg-4">
                                    <div class="row" style="direction: rtl">
                                        <div class="col-lg-6">
                                            <base-input alternative=""
                                                        label="نام :"
                                                        placeholder="نام"
                                                        input-classes="form-control-alternative"
                                                        v-model="customer.first_name"
                                            />
                                        </div>
                                        <div class="col-lg-6">
                                            <base-input alternative=""
                                                        label="نام خانوادگی :"
                                                        placeholder="نام خانوادگی"
                                                        input-classes="form-control-alternative"
                                                        v-model="customer.last_name"
                                            />
                                        </div>
                                    </div>
                                    <div class="row" style="direction: rtl">
                                        <div class="col-lg-6">
                                            <base-input alternative=""
                                                        label="کد ملی :"
                                                        placeholder="کد ملی"
                                                        input-classes="form-control-alternative"
                                                        v-model="customer.identification_number"
                                            />
                                        </div>
                                        <div class="col-lg-6">
                                            <base-input alternative=""
                                                        label="شماره تماس :"
                                                        placeholder="شماره تماس"
                                                        input-classes="form-control-alternative"
                                                        v-model="customer.phone_number"
                                            />
                                        </div>
                                    </div>
                                </div>
                                <hr class="my-4"/>
                                <!-- Address -->
                                <h6 v-if="order.isDelivery" class="heading-small text-muted mb-4">اطلاعات بیرون بر
                                    :</h6>
                                <div v-if="order.isDelivery" class="pl-lg-4">
                                    <div class="row" style="direction: rtl">
                                        <div class="col-md-12">
                                            <base-input alternative=""
                                                        label="آدرس :"
                                                        placeholder="آدرس"
                                                        input-classes="form-control-alternative"
                                                        v-model="address.text"
                                            />
                                        </div>
                                    </div>
                                    <div class="row" style="direction: rtl">
                                        <div class="col-lg-6">
                                            <base-input alternative=""
                                                        label="شماره تماس :"
                                                        placeholder="شماره تماس"
                                                        input-classes="form-control-alternative"
                                                        v-model="address.static_phone"
                                            />
                                        </div>
                                        <div class="col-lg-6">
                                            <base-input alternative=""
                                                        label="نام آدرس :"
                                                        placeholder="نام آدرس"
                                                        input-classes="form-control-alternative"
                                                        v-model="address.name"
                                            />
                                        </div>
                                    </div>
                                </div>
                                <hr class="my-4"/>
                                <!-- Description -->
                                <h6 v-if="courier.id" class="heading-small text-muted mb-4">اطلاعات پیک :</h6>
                                <div v-if="courier.id" class="pl-lg-4">
                                    <div class="row" style="direction: rtl">
                                        <div class="col-lg-6">
                                            <base-input alternative=""
                                                        label="نام :"
                                                        placeholder="نام"
                                                        input-classes="form-control-alternative"
                                                        v-model="courier.first_name"
                                            />
                                        </div>
                                        <div class="col-lg-6">
                                            <base-input alternative=""
                                                        label="نام خانوادگی :"
                                                        placeholder="نام خانوادگی"
                                                        input-classes="form-control-alternative"
                                                        v-model="courier.last_name"
                                            />
                                        </div>
                                    </div>
                                    <div class="row" style="direction: rtl">
                                        <div class="col-lg-6">
                                            <base-input alternative=""
                                                        label="کد ملی :"
                                                        placeholder="کد ملی"
                                                        input-classes="form-control-alternative"
                                                        v-model="courier.identification_number"
                                            />
                                        </div>
                                        <div class="col-lg-6">
                                            <base-input alternative=""
                                                        label="شماره تماس :"
                                                        placeholder="شماره تماس"
                                                        input-classes="form-control-alternative"
                                                        v-model="courier.phone_number"
                                            />
                                        </div>
                                    </div>
                                    <div class="row" style="direction: rtl">
                                        <div class="col-md-12 text-center">
                                            <base-alert v-if="courier.status == 'notdelivered'" type="warning">
                                                هنوز به دست مشتری نرسیده است.
                                            </base-alert>
                                            <base-alert v-if="courier.status == 'delivered'" type="success">سفارش به
                                                دست مشتری رسیده است.
                                            </base-alert>
                                        </div>
                                        <div class="col-md-12">
                                            <base-button v-if="courier.status == 'notdelivered'" type="success"
                                                         @click="makeDelivery()">تغییر به "رسیده به دست مشتری"
                                            </base-button>
                                            <base-button @click="removeCourierFromOrder()" type="danger">
                                                حذف این پیک از سفارش
                                            </base-button>
                                        </div>
                                    </div>
                                </div>
                                <div v-if="!courier.id && order.isDelivery">
                                    <!-- There is no courier for this order-->
                                    <select v-model="selectedCourier" class="form-control">
                                        <option :value="courier" v-for="(courier, index) in freeCouriers">
                                            {{courier.first_name + " " + courier.last_name + " | " + courier.phone_number}}
                                        </option>
                                    </select>
                                    <base-button v-if="selectedCourier.id" class="mt-3" style="direction: rtl" type="success" @click="assignOrderToSelectedCourier()">
                                        دادن سفارش به آقای {{selectedCourier.first_name + " " + selectedCourier.last_name}}
                                    </base-button>
                                </div>
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
        name: "OrderProfile",
        data() {
            return {
                order: {},
                foods: [],
                customer: {},
                address: {},
                courier: {},
                model: {},

                freeCouriers : [],
                selectedCourier: {}
            }
        },
        computed: {
            orderTotalSum: function () {
                let sum = 0;
                for (let food of this.foods) {
                    sum += (food.amount * food.price)
                }
                return sum;
            }
        },
        methods: {
            async getOrder() {
                this.order = (await axios.get('http://localhost:3000/api/v1/orders/' + this.$route.params.id)).data;
                console.log(this.order);
            },

            async getOrderFoods() {
                this.foods = (await axios.get('http://localhost:3000/api/v1/orders/' + this.$route.params.id + '/foods')).data;
                console.log('foods', this.foods);
            },
            async getOrderCustomer() {
                this.customer = (await axios.get('http://localhost:3000/api/v1/orders/' + this.$route.params.id + '/user')).data;
                console.log('customer', this.customer);
            },
            async getOrderAddress() {
                this.address = (await axios.get('http://localhost:3000/api/v1/orders/' + this.$route.params.id + '/address')).data;
                console.log('address', this.address);
            },
            async getOrderCourier() {
                this.courier = (await axios.get('http://localhost:3000/api/v1/orders/' + this.$route.params.id + '/courier')).data;
                console.log('courier', this.courier);
            },
            async makeDelivery() {
                let updateDeliveryStatusResponse = await axios.patch('http://localhost:3000/api/v1/orders/' + this.$route.params.id + '/courier/' + this.courier.id + '/status', {"status": "delivered"})
                console.log(updateDeliveryStatusResponse);
            },
            async removeCourierFromOrder() {
                let deleteCourierFromOrderResponse = await axios.delete('http://localhost:3000/api/v1/orders/' + this.$route.params.id + '/courier/' + this.courier.id);
                console.log(deleteCourierFromOrderResponse);
            },

            async assignOrderToSelectedCourier() {
                try {
                    let assignCourierToOrderResponse = await axios.put('http://localhost:3000/api/v1/orders/' + this.$route.params.id + '/courier/' + this.selectedCourier.id);
                    console.log(assignCourierToOrderResponse);
                }catch (e) {
                    console.log(e.response);
                }

            },

            async getFreeCouriers() {
                let fcResponse = await axios.get('http://localhost:3000/api/v1/couriers/available');
                this.freeCouriers = fcResponse.data;
                console.log('free couriers ',this.freeCouriers);
            }
        },
        created() {
            this.getOrder();
            this.getOrderFoods();
            this.getOrderCustomer();
            this.getOrderAddress();
            this.getOrderCourier();
            this.getFreeCouriers();
        }
    }
</script>

<style scoped>

</style>