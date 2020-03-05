<template>
    <div>
        <div class="container-fluid mt-7" style="direction: rtl">
            <div class="row">
                <div class="col-lg-6">
                    <foods-for-order @foodAmountChanged="updateFoodTotalAmount" title="منوی غذای فعلی رستوران" :data="foods"></foods-for-order>
                </div>
                <div class="col-lg-6">
                    <div class="row">
                        <base-checkbox style="direction: rtl;text-align:right" class="mb-3" v-model="withName">
                            سفارش با نام است
                        </base-checkbox>
                        <div class="col-md-12" v-if="withName">
                            <h6 class="text-muted text-right">
                                در صورت تمایل فاکتور با اسم صادر کنید :
                            </h6>
                            <select @change="getSelectedUserAddresses()" v-model="selectedUser" class="form-control">
                                <option :value="user" v-for="(user, index) in users">
                                    {{user.first_name + " " + user.last_name + " | " + user.phone_number}}
                                </option>
                            </select>
                        </div>

                        <div class="col-md-12 mt-3">
                            <!--                            address part-->
                            <base-checkbox style="direction: rtl;text-align:right" class="mb-3" v-model="isDelivery">
                                سفارش بیرون بر است
                            </base-checkbox>


                            <div v-if="isDelivery">
                                <base-checkbox style="direction: rtl;text-align:right" class="mb-3" v-model="isFavAddress">
                                    آدرس های ثبت شده کاربر
                                </base-checkbox>

                                <select v-if="isFavAddress" v-model="selectedAddress" class="form-control">
                                    <option :value="addr" v-for="(addr, index) in selectedUserAddresses">{{addr.name + " | " + addr.static_phone}}
                                    </option>
                                </select>
                                <p v-if="isFavAddress">
                                    آدرس انتخاب شده :
                                    <br>
                                    {{selectedAddress.text}}
                                </p>

                                <div class="row" v-if="!isFavAddress">
                                    <div class="col-lg-6">
                                        <base-input alternative=""
                                                    label="آدرس :"
                                                    placeholder="ادرس"
                                                    input-classes="form-control-alternative"
                                                    v-model="inputNewAddress.text"/>

                                    </div>

                                    <div class="col-lg-6">
                                        <base-input alternative=""
                                                    label="شماره تلفن ثابت :"
                                                    placeholder="شماره تلفن ثابت"
                                                    input-classes="form-control-alternative"
                                                    v-model="inputNewAddress.static_phone"/>

                                    </div>
                                </div>
                            </div>

                            <base-button @click="createNewOrder()" type="success">
                                ایجاد سفارش جدید | مبلغ کل : {{orderTotalPrice}}
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
    import FoodsForOrderTable from "@/views/Tables/FoodsForOrderTable";

    export default {
        name: "NewOrder",
        components: {
            'foods-for-order': FoodsForOrderTable
        },
        data() {
            return {
                foods: [],
                users: [],
                selectedUserIndex: '',
                selectedUser: {},
                selectedUserAddresses: [],
                isDelivery: false,
                isFavAddress: true,
                withName : false,
                selectedAddress: {},
                inputNewAddress: {},
                selectedFoods : [],
                orderTotalPrice : 0,
            }
        },
        methods: {
            async getFoods() {
                this.foods = (await axios.get('http://localhost:3000/api/v1/foods')).data;
                console.log('foods', this.foods);
            },
            async getUsers() {
                this.users = (await axios.get('http://localhost:3000/api/v1/users')).data;
                console.log('users', this.users);
            },
            async getSelectedUserAddresses() {
                console.log('get addresses for user with id ', this.selectedUser.id);
                this.selectedUserAddresses = (await axios.get('http://localhost:3000/api/v1/users/' + this.selectedUser.id + '/addresses')).data;
                console.log(this.selectedUserAddresses);
            },
            async createNewOrder() {
                try {
                    let orderToSend = {};
                    orderToSend.foods = this.selectedFoods;

                    if(this.withName) {
                        orderToSend.customer_id = this.selectedUser.id;
                    } else orderToSend.customer_id = null;

                    if(this.isDelivery) {
                        if(this.isFavAddress) {
                            //delivery with user fav address
                            orderToSend.address_id = this.selectedAddress.id;
                        }else {
                            //create an address with data provided then use its id to create order
                            let newAddrResponse = await axios.post('http://localhost:3000/api/v1/addresses', this.inputNewAddress);
                            orderToSend.address_id = newAddrResponse.data.id;
                        }
                    } else  {
                        orderToSend.address_id = null;
                    }

                    console.log(orderToSend);
                    let createOrderResponse = await axios.post('http://localhost:3000/api/v1/orders', orderToSend);
                    console.log(createOrderResponse.data);
                } catch (e) {
                    console.log(e.response);
                }
            },

            updateFoodTotalAmount(foods) {
                this.selectedFoods = [];
                this.orderTotalPrice = 0;
                for(let food of foods) {
                    if(food.amount && food.amount > 0) {
                        this.orderTotalPrice += (food.amount * food.price);
                        this.selectedFoods.push(food);
                    }
                }
            },
        },
        computed: {
        },
        created() {
            this.getFoods();
            this.getUsers();
        }
    }
</script>

<style scoped>

</style>