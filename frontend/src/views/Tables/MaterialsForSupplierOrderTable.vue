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
                    <th>مقدار</th>
                </template>

                <template slot-scope="{row}">
                    <th scope="row">
                        {{row.material_id}}
                    </th>
                    <td class="budget">
                        {{row.name}}
                    </td>
                    <td>
                        {{row.price}}
                    </td>

                    <td>
                        <base-input type="number" min="0" @input="handleMaterialAmountEdit()" v-model="row.amount"></base-input>
                    </td>
                </template>

            </base-table>
        </div>
    </div>
</template>
<script>
    import axios from 'axios'
    export default {
        name: 'MaterialsForOrderTable',
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
            handleMaterialAmountEdit() {
                this.$emit('materialAmountChanged',this.data);
            },
        },
        data() {
            return {
                onEditMaterial : {},
                showUpdateMaterialModal : false
            }
        }
    }
</script>
<style>
</style>
