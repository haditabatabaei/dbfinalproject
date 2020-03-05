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
                        {{row.food_id}}
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
                                <button @click="handleUpdateFoodModal(row)" :to="'/foods/' + row.id" class="dropdown-item" >ویرایش غذا</button>
                                <button @click="removeFood(row.food_id)" class="dropdown-item">حذف غذا از منو</button>
                            </template>
                        </base-dropdown>
                    </td>

                </template>

            </base-table>
            <div class="row">
                <div class="col-md-12">
                    <modal :show.sync="showUpdateFoodModal"
                           body-classes="p-0"
                           modal-classes="modal-dialog-centered modal-lg">
                        <div class="p-4">
                            <h6 class="heading-small text-muted text-sm text-right" style="direction: rtl">ویرایش غذا :</h6>
                            <div class="row" style="direction: rtl">
                                <div class="col-lg-6">
                                    <base-input alternative=""
                                                label="نام غذا :"
                                                placeholder="نام غذا"
                                                input-classes="form-control-alternative"
                                                v-model="onEditFood.name"
                                    />
                                </div>
                                <div class="col-lg-6">
                                    <base-input alternative=""
                                                label="قیمت غذا :"
                                                placeholder="قیمت غذا"
                                                input-classes="form-control-alternative"
                                                v-model="onEditFood.price"
                                    />
                                </div>
                            </div>
                        </div>
                        <template slot="footer">
                            <base-button outline type="success" @click="updateOnEditFood()">ویرایش غذا</base-button>
                            <base-button type="link-seocndary" class="ml-auto" @click="showUpdateFoodModal = false">
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
        name: 'FoodsTable',
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
            async removeFood(foodId) {
                try {
                    let result = (await axios.delete("http://localhost:3000/api/v1/foods/" + foodId)).data;
                    console.log(result);
                    this.$emit('updateFoodsList');
                } catch (e) {
                    console.log(e.response);
                }
            },
            async updateOnEditFood() {
                try {
                    let result = (await axios.patch('http://localhost:3000/api/v1/foods/' + this.onEditFood.food_id, this.onEditFood)).data;
                    console.log(result);
                    this.showUpdateFoodModal = false;
                    await this.$emit('updateFoodsList');
                }catch (e) {
                    console.log(e.response);
                }
            },
            handleUpdateFoodModal(inputFood) {
                this.showUpdateFoodModal = true;
                this.onEditFood = inputFood;
            }
        },
        data() {
            return {
                onEditFood : {},
                showUpdateFoodModal : false
            }
        }
    }
</script>
<style>
</style>
