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
                    <th>تاریخ</th>
                    <th>عملیات</th>
                    <th>نام</th>
                    <th>نام خانوادگی</th>
                    <th>کد ملی</th>
                    <th>شماره تماس</th>
                </template>

                <template slot-scope="{row}">
                    <th scope="row">
                        {{row.date}}
                    </th>
                    <td class="budget">
                        {{row.operation}}
                    </td>
                    <td>
                        {{row.courier_first_name}}
                    </td>
                    <td>
                        {{row.courier_last_name}}
                    </td>
                    <td>
                        {{row.courier_identification_number}}
                    </td>
                    <td>
                        {{row.courier_phone_number}}
                    </td>
                </template>

            </base-table>

        </div>

    </div>
</template>
<script>

    export default {
        name: 'CourierLogTable',
        props: {
            type: {
                type: String
            },
            title: String,
            data: {
                type: Array
            }
        },
    }
</script>
<style>
</style>
