<template>
    <div>
        <base-header type="gradient-success" class="pb-6 pb-8 pt-5 pt-md-8">
            <!-- Card stats -->
            <div class="row">
                <div class="col-xl-3 col-lg-6">
                    <stats-card title="کل غذاهای فعال منو"
                                type="gradient-red"
                                :sub-title="foodsLength"
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
                    <foods-table @updateFoodsList="getFoods()" title="منوی غذای رستوران" :data="foods"></foods-table>
                </div>
                <base-button type="success" @click="showNewFoodModal = true" >ایجاد غذای جدید</base-button>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <modal :show.sync="showNewFoodModal"
                           body-classes="p-0"
                           modal-classes="modal-dialog-centered modal-lg">
                        <div class="p-4">
                            <h6 class="heading-small text-muted text-sm text-right" style="direction: rtl">غذای جدید :</h6>
                            <div class="row" style="direction: rtl">
                                <div class="col-lg-6">
                                    <base-input alternative=""
                                                label="نام غذا :"
                                                placeholder="نام غذا"
                                                input-classes="form-control-alternative"
                                                v-model="newFood.name"
                                    />
                                </div>
                                <div class="col-lg-6">
                                    <base-input alternative=""
                                                label="قیمت غذا :"
                                                placeholder="قیمت غذا"
                                                input-classes="form-control-alternative"
                                                v-model="newFood.price"
                                    />
                                </div>
                            </div>
                        </div>
                        <template slot="footer">
                            <base-button outline type="success" @click="createNewFood()">ثبت غذای جدید</base-button>
                            <base-button type="link-seocndary" class="ml-auto" @click="showNewFoodModal = false">
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
    import FoodsTable from "@/views/Tables/FoodsTable";
    export default {
        name: 'Foods',
        components: {
            "foods-table" : FoodsTable
        },
        data() {
            return {
                foods : [],
                newFood : {},
                showNewFoodModal : false,
            }
        },
        computed : {
            foodsLength : function() {
                if(this.foods === undefined) {
                    return "0"
                } else return this.foods.length + ""
            }
        },
        methods : {
            async getFoods() {
                this.foods = (await axios.get('http://localhost:3000/api/v1/foods')).data;
                console.log('foods',this.foods);
            },
            async createNewFood() {
                try {
                    let result = (await axios.post('http://localhost:3000/api/v1/foods', this.newFood)).data;
                    console.log(result);
                    await this.getFoods();
                    this.showNewFoodModal = false;
                }catch (e) {
                    console.log(e.response);
                }
            },


        },
        created() {
            this.getFoods();
        },
    };
</script>
<style scoped/>
