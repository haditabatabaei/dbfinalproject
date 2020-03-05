<template>
    <div>
        <base-header class="header pb-8 pt-5 pt-lg-8 d-flex align-items-center"
                     style="min-height: 200px">
            <!-- Mask -->

            <span class="mask bg-gradient-success opacity-8"></span>
            <!-- Header container -->
            <div class="container-fluid" style="direction:rtl">
                <div class="row">
                    <div class="col-lg-7 col-md-10">
                        <h1 class="display-2 text-white text-right">مشتری جدید :</h1>
<!--                        <p class="text-white mt-0 mb-5">This is your profile page. You can see the progress you've made with your work and manage your projects or assigned tasks</p>-->
<!--                        <a href="#!" class="btn btn-info">Edit profile</a>-->
                    </div>
                </div>
            </div>
        </base-header>

        <div class="container-fluid mt--7">
            <div class="row">
<!--                <div class="col-xl-4 order-xl-2 mb-5 mb-xl-0">-->

<!--                    <div class="card card-profile shadow">-->
<!--                        <div class="row justify-content-center">-->
<!--                            <div class="col-lg-3 order-lg-2">-->
<!--                                <div class="card-profile-image">-->
<!--                                    <a href="#">-->
<!--                                        <img src="img/theme/team-4-800x800.jpg" class="rounded-circle">-->
<!--                                    </a>-->
<!--                                </div>-->
<!--                            </div>-->
<!--                        </div>-->
<!--                        <div class="card-header text-center border-0 pt-8 pt-md-4 pb-0 pb-md-4">-->
<!--                            <div class="d-flex justify-content-between">-->
<!--                                <base-button size="sm" type="info" class="mr-4">Connect</base-button>-->
<!--                                <base-button size="sm" type="default" class="float-right">Message</base-button>-->
<!--                            </div>-->
<!--                        </div>-->
<!--                        <div class="card-body pt-0 pt-md-4">-->
<!--                            <div class="row">-->
<!--                                <div class="col">-->
<!--                                    <div class="card-profile-stats d-flex justify-content-center mt-md-5">-->
<!--                                        <div>-->
<!--                                            <span class="heading">22</span>-->
<!--                                            <span class="description">Friends</span>-->
<!--                                        </div>-->
<!--                                        <div>-->
<!--                                            <span class="heading">10</span>-->
<!--                                            <span class="description">Photos</span>-->
<!--                                        </div>-->
<!--                                        <div>-->
<!--                                            <span class="heading">89</span>-->
<!--                                            <span class="description">Comments</span>-->
<!--                                        </div>-->
<!--                                    </div>-->
<!--                                </div>-->
<!--                            </div>-->
<!--                            <div class="text-center">-->
<!--                                <h3>-->
<!--                                    Jessica Jones<span class="font-weight-light">, 27</span>-->
<!--                                </h3>-->
<!--                                <div class="h5 font-weight-300">-->
<!--                                    <i class="ni location_pin mr-2"></i>Bucharest, Romania-->
<!--                                </div>-->
<!--                                <div class="h5 mt-4">-->
<!--                                    <i class="ni business_briefcase-24 mr-2"></i>Solution Manager - Creative Tim Officer-->
<!--                                </div>-->
<!--                                <div>-->
<!--                                    <i class="ni education_hat mr-2"></i>University of Computer Science-->
<!--                                </div>-->
<!--                                <hr class="my-4" />-->
<!--                                <p>Ryan — the name taken by Melbourne-raised, Brooklyn-based Nick Murphy — writes, performs and records all of his own music.</p>-->
<!--                                <a href="#">Show more</a>-->
<!--                            </div>-->
<!--                        </div>-->
<!--                    </div>-->
<!--                </div>-->

                <div class="col-xl-12">
                    <card shadow type="secondary">
                        <div slot="header" class="bg-white border-0">
                            <div class="row align-items-center">
                                <div class="col-8">
<!--                                    <h3 class="mb-0">My account</h3>-->
                                </div>
                                <div class="col-4 text-right">
<!--                                    <a href="#!" class="btn btn-sm btn-primary">Settings</a>-->
                                </div>
                            </div>
                        </div>
                        <template>
                            <form @submit.prevent style="direction:rtl;">
                                <h6 class="heading-small text-muted mb-4">اطلاعات مشتری جدید را وارد کنید</h6>
                                <div class="pl-lg-4">
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <base-input alternative=""
                                                        label="نام :"
                                                        placeholder="نام"
                                                        input-classes="form-control-alternative"
                                                        label-classes="is-rtl"
                                                        v-model="model.first_name"
                                            />
                                        </div>
                                        <div class="col-lg-6">
                                            <base-input alternative=""
                                                        label="نام خانوادگی :"
                                                        placeholder="نام خانوادگی"
                                                        input-classes="form-control-alternative"
                                                        v-model="model.last_name"
                                            />
                                        </div>

                                    </div>
                                    <div class="row">
                                        <div class="col-lg-5">
                                            <base-input alternative=""
                                                        label="کد ملی :"
                                                        placeholder="کد ملی"
                                                        input-classes="form-control-alternative"
                                                        v-model="model.identification_number"
                                            />
                                        </div>
                                        <div class="col-lg-5">
                                            <base-input alternative=""
                                                        label="شماره تماس :"
                                                        placeholder="شماره تماس"
                                                        input-classes="form-control-alternative"
                                                        v-model="model.phone_number"
                                            />
                                        </div>
                                        <div class="col-lg-2">
                                            <base-input
                                                label = "سن :"
                                                placeholder = "سن"
                                                input-classes="form-control-alternative"
                                                v-model="model.age"
                                            />
                                        </div>
                                        <div class="col-md-12">
                                            <base-button type="success" @click="createNewUser()">ایجاد مشتری جدید</base-button>
                                        </div>
                                    </div>
                                </div>
                                <hr class="my-4" />
                                <!-- Address -->
<!--                                <h6 class="heading-small text-muted mb-4">Contact information</h6>-->
<!--                                <div class="pl-lg-4">-->
<!--                                    <div class="row">-->
<!--                                        <div class="col-md-12">-->
<!--                                            <base-input alternative=""-->
<!--                                                        label="Address"-->
<!--                                                        placeholder="Home Address"-->
<!--                                                        input-classes="form-control-alternative"-->
<!--                                                        v-model="model.address"-->
<!--                                            />-->
<!--                                        </div>-->
<!--                                    </div>-->
<!--                                    <div class="row">-->
<!--                                        <div class="col-lg-4">-->
<!--                                            <base-input alternative=""-->
<!--                                                        label="City"-->
<!--                                                        placeholder="City"-->
<!--                                                        input-classes="form-control-alternative"-->
<!--                                                        v-model="model.city"-->
<!--                                            />-->
<!--                                        </div>-->
<!--                                        <div class="col-lg-4">-->
<!--                                            <base-input alternative=""-->
<!--                                                        label="Country"-->
<!--                                                        placeholder="Country"-->
<!--                                                        input-classes="form-control-alternative"-->
<!--                                                        v-model="model.country"-->
<!--                                            />-->
<!--                                        </div>-->
<!--                                        <div class="col-lg-4">-->
<!--                                            <base-input alternative=""-->
<!--                                                        label="Postal code"-->
<!--                                                        placeholder="Postal code"-->
<!--                                                        input-classes="form-control-alternative"-->
<!--                                                        v-model="model.zipCode"-->
<!--                                            />-->
<!--                                        </div>-->
<!--                                    </div>-->
<!--                                </div>-->
<!--                                <hr class="my-4" />-->
<!--                                &lt;!&ndash; Description &ndash;&gt;-->
<!--                                <h6 class="heading-small text-muted mb-4">About me</h6>-->
<!--                                <div class="pl-lg-4">-->
<!--                                    <div class="form-group">-->
<!--                                        <base-input alternative=""-->
<!--                                                    label="About Me">-->
<!--                                            <textarea rows="4" class="form-control form-control-alternative" placeholder="A few words about you ...">A beautiful Dashboard for Bootstrap 4. It is Free and Open Source.</textarea>-->
<!--                                        </base-input>-->
<!--                                    </div>-->
<!--                                </div>-->
                            </form>
                        </template>
                    </card>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    import axios from 'axios';
    export default {
        name: 'user-profile',
        data() {
            return {
                model: {
                }
            }
        },
        methods : {
            async createNewUser() {
                console.log('send create user request');
                try {
                    let result = await axios.post('http://localhost:3000/api/v1/users',this.model);
                    console.log(result);
                }catch (e) {
                    console.log(e.response);
                }

            }
        }
    };
</script>
<style></style>
