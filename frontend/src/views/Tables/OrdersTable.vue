<template>
    <div class="card shadow"
         :class="type === 'dark' ? 'bg-default': ''">
        <div class="card-header border-0"
             :class="type === 'dark' ? 'bg-transparent': ''">
            <div class="row" style="direction:rtl">
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
                    <th>تاریخ صدور</th>
                    <th>با نام</th>
                    <th>بیرون بر</th>
                    <th>عملیات</th>
                </template>

                <template slot-scope="{row}">
                    <th scope="row">
                        {{row.id}}
                    </th>
                    <td class="budget">
                        {{(new Date(row.issue_date)).toUTCString()}}
                    </td>
                    <td v-if="row.hasName">
                        <router-link :to="'/users/' + row.customer_id" class="btn btn-sm btn-outline-primary">مشاهده
                            کاربر
                        </router-link>
                    </td>
                    <td v-else>
                        {{row.hasName}}
                    </td>
                    <td v-if="row.isDelivery">
                        <base-button type="warning" size="sm" outline>ویرایش آدرس</base-button>
                        <!--                        {{row.isDelivery}}-->
                    </td>
                    <td v-else>
                        {{row.isDelivery}}
                    </td>
                    <td class="text-right">
                        <base-dropdown class="dropdown"
                                       position="left">
                            <a slot="title" class="btn btn-sm btn-icon-only text-light" role="button"
                               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-ellipsis-v"></i>
                            </a>
                            <template>
                                <router-link :to="'/orders/' + row.id" class="dropdown-item">مشاهده کامل سفارش
                                </router-link>
                                <button @click="removeOrder(row.id)" class="dropdown-item">حذف سفارش</button>

                            </template>
                        </base-dropdown>
                    </td>

                </template>

            </base-table>

        </div>

    </div>
</template>
<script>
    import axios from 'axios'

    export default {
        name: 'OrdersTable',
        props: {
            type: {
                type: String
            },
            title: String,
            data: {
                type: Array
            }
        },
        methods: {

            async removeOrder(orderId) {
                try {
                    let result = (await axios.delete("http://localhost:3000/api/v1/orders/" + orderId)).data;
                    console.log(result);
                    this.$emit('updateOrdersList');
                } catch (e) {
                    console.log(e.response);
                }
            },

        },
        data() {
            return {
                onEditFood: {},
                showUpdateFoodModal: false
            }
        },
        async created() {

        }
    }
</script>
<style>
</style>
