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
                    <base-button @click="$router.push('/new/user')" outline type="info">+ مشتری جدید</base-button>
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
                    <th>نام خانوادگی</th>
                    <th>کد ملی</th>
                    <th>شماره تماس</th>
                    <th>سن</th>
                    <th>عملیات</th>
                </template>

                <template slot-scope="{row}">
                    <th scope="row">
<!--                        <div class="media align-items-center">-->
<!--                            <a href="#" class="avatar rounded-circle mr-3">-->
<!--                                <img alt="Image placeholder" :src="row.img">-->
<!--                            </a>-->
<!--                            <div class="media-body">-->
<!--                                <span class="name mb-0 text-sm">{{row.title}}</span>-->
<!--                            </div>-->
<!--                        </div>-->
                        {{row.id}}
                    </th>
                    <td class="budget">
                        {{row.first_name}}
                    </td>
                    <td>
                        {{row.last_name}}
                    </td>
                    <td>
                        {{row.identification_number}}
                    </td>
                    <td>
                        {{row.phone_number}}
                    </td>
                    <td>
                        {{row.age}}
                    </td>

                    <td class="text-right">
                        <base-dropdown class="dropdown"
                                       position="left">
                            <a slot="title" class="btn btn-sm btn-icon-only text-light" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-ellipsis-v"></i>
                            </a>
                            <template>
<!--                                <a class="dropdown-item" href="#">Action</a>-->
                                <router-link :to="'/users/' + row.id" class="dropdown-item" >ویرایش کاربر</router-link>
                                <button @click="removeUser(row.id)" class="dropdown-item">حذف کاربر</button>
                            </template>
                        </base-dropdown>
                    </td>

                </template>

            </base-table>
        </div>

<!--        <div class="card-footer d-flex justify-content-end"-->
<!--             :class="type === 'dark' ? 'bg-transparent': ''">-->
<!--            <base-pagination total="30"></base-pagination>-->
<!--        </div>-->

    </div>
</template>
<script>
    import axios from 'axios'
    export default {
        name: 'UsersTable',
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
            async removeUser(userId) {
                await axios.delete('http://localhost:3000/api/v1/users/' + userId);
            }
        },
        data() {
            return {

            }
        }
    }
</script>
<style>
</style>
