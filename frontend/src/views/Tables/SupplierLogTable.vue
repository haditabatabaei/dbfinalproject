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
                    <th>تاریخ</th>
                    <th>عملیات</th>
                    <th>نام</th>
                    <th>وضعیت</th>
                </template>

                <template slot-scope="{row}">
                    <th scope="row">
                        {{row.date}}
                    </th>
                    <td class="budget">
                        {{row.operation}}
                    </td>
                    <td>
                        {{row.supplier_title}}
                    </td>
                    <td>{{row.supplier_is_available}}</td>
                </template>

            </base-table>
        </div>
    </div>
</template>
<script>
    import axios from 'axios'
    export default {
        name: 'SupplierForOrderTable',
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

        },
    }
</script>
<style>
</style>
