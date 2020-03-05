<template>
    <div>
        <base-header type="gradient-success" class="pb-6 pb-8 pt-5 pt-md-8">
            <!-- Card stats -->
            <div class="row">
                <div class="col-xl-3 col-lg-6">
                    <stats-card title="کل کاربران"
                                type="gradient-red"
                                :sub-title="usersLength"
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
                    <users-table title="لیست مشتریان رستوران" :data="users"></users-table>
                </div>
            </div>
            <div class="row mt-5">
                <div class="col">
                </div>
            </div>
        </div>

    </div>
</template>
<script>
    import UsersTable from './Tables/UsersTable'
    import axios from 'axios';
    export default {
        name: 'Users',
        components: {
            "users-table" : UsersTable
        },
        data() {
            return {
                users : []
            }
        },
        computed : {
          usersLength : function() {
              if(this.users === undefined) {
                  return "0"
              } else return this.users.length + ""
          }
        },
        methods : {
            async getUsers() {
                this.users = (await axios.get('http://localhost:3000/api/v1/users')).data;
                console.log('users',this.users);
            }
        },
        created() {
            this.getUsers();
        },
    };
</script>
<style scoped/>
