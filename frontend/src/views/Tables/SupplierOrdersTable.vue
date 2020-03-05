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
                    <th>از شرکت</th>
                    <th>عملیات</th>
                </template>

                <template slot-scope="{row}">
                    <th scope="row">
                        {{row.id}}
                    </th>
                    <td class="budget">
                        {{(new Date(row.issue_date)).toUTCString()}}
                    </td>
                    <td>
                        {{row.supplier.title}}
                    </td>
                    <td class="text-right">
                        <base-dropdown class="dropdown"
                                       position="left">
                            <a slot="title" class="btn btn-sm btn-icon-only text-light" role="button"
                               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-ellipsis-v"></i>
                            </a>
                            <template>
                                <router-link :to="'/supplierorders/' + row.id" class="dropdown-item">مشاهده کامل سفارش
                                </router-link>
                                <button @click="removeSupplierOrder(row.id)" class="dropdown-item">حذف سفارش</button>
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

            async removeSupplierOrder(orderId) {
                try {
                    let result = (await axios.delete("http://localhost:3000/api/v1/supplierorders/" + orderId)).data;
                    console.log(result);
                    this.$emit('updateSupplierOrdersList');
                } catch (e) {
                    console.log(e.response);
                }
            },

        },
        data() {
            return {

            }
        },
        async created() {

        }
    }
</script>
<style>
</style>
