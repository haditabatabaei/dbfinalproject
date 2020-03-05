<template>
    <div>
        <base-header type="gradient-success" class="pb-6 pb-8 pt-5 pt-md-8">
            <!-- Card stats -->
            <div class="row">
                <div class="col-xl-3 col-lg-6">
                    <stats-card title="کل درآمد خام"
                                type="gradient-red"
                                :sub-title="total_gain + ''"
                                icon="ni ni-active-40"
                                class="mb-4 mb-xl-0">

                        <template slot="footer">
                        </template>
                    </stats-card>
                </div>
                <div class="col-xl-3 col-lg-6">
                    <stats-card title="کل مخارج"
                                type="gradient-red"
                                :sub-title="total_consume + ''"
                                icon="ni ni-active-40"
                                class="mb-4 mb-xl-0">

                        <template slot="footer">
                        </template>
                    </stats-card>
                </div>
                <div class="col-xl-3 col-lg-6">
                    <stats-card title="کل سود"
                                type="gradient-red"
                                :sub-title="total_profit + ''"
                                icon="ni ni-active-40"
                                class="mb-4 mb-xl-0">

                        <template slot="footer">
                        </template>
                    </stats-card>
                </div>
            </div>
        </base-header>

        <div class="container-fluid mt--7">
            <div class="row mt-2">
                <div class="col-md-12">
                    <card header-classes="bg-transparent">
                        <div slot="header" class="row align-items-center">
                            <div class="col">
                                <h6 class="text-uppercase text-muted ls-1 mb-1">غذا های محبوب</h6>
                                <h5 class="h3 mb-0">بیشترین دفعات سفارش</h5>
                            </div>
                        </div>

                        <bar-chart
                                :height="350"
                                ref="barChart"
                                :chart-data="mostFavFoods.chartData">
                        </bar-chart>
                    </card>
                </div>
            </div>
            <div class="row mt-5">
                <div class="col-md-12">
                    <card type="default" header-classes="bg-transparent">
                        <div slot="header" class="row align-items-center">
                            <div class="col">
                                <h6 class="text-light text-uppercase ls-1 mb-1">گزارش</h6>
                                <h5 class="h3 text-white mb-0">گزارش خرید و فروش</h5>
                            </div>
                            <div class="col">
                            </div>
                        </div>
                        <line-chart
                                :height="350"
                                ref="bigChart"
                                :chart-data="bigLineChart.chartData"
                        >
                        </line-chart>
                    </card>

                </div>
            </div>
        </div>

    </div>
</template>
<script>
    import axios from 'axios';
    import * as chartConfigs from '@/components/Charts/config';
    import LineChart from '@/components/Charts/LineChart';
    import BarChart from '@/components/Charts/BarChart';

    export default {
        name: 'Reports',
        components: {
            LineChart,
            BarChart
        },
        data() {
            return {
                total_gain: '',
                total_consume: '',
                total_profit: '',
                mostFavFoods: {
                    chartData: {
                        labels: [],
                        datasets: [{
                            label: 'تعداد غذا ها',
                            data: []
                        }]
                    }
                },
                bigLineChart: {
                    chartData: {
                        datasets: [
                            {
                                label : 'فروش',
                                data: []
                            },
                            {
                                label : 'خرید',
                                data : []
                            }
                        ],
                        labels: [],
                    },
                }
            }
        },
        computed: {},
        methods: {
            async getTotalGain() {
                this.total_gain = (await axios.get('http://localhost:3000/api/v1/reports/totalordersprice')).data.total_price_of_all;
            },
            async getTotalConsume() {
                this.total_consume = (await axios.get('http://localhost:3000/api/v1/reports/totalsuppliersordersprice')).data.total_price_of_all;
            },
            async getTotalProfit() {
                this.total_profit = (await axios.get('http://localhost:3000/api/v1/reports/profitofalltime')).data.profit;
            },
            async getMostFavFoods() {
                try {
                    let result = await axios.get("http://localhost:3000/api/v1/reports/foods/mostfavfoods");
                    console.log(result.data);
                    for (let item of result.data) {
                        this.mostFavFoods.chartData.labels.push(item.food_name);
                        this.mostFavFoods.chartData.datasets[0].data.push(item.total_picks)
                    }

                } catch (e) {
                    console.log(e.response);
                }
            },
            async getConsumeGainTimeLine() {
                let gainResult = await axios.get("http://localhost:3000/api/v1/reports/totalorderspricesdata");
                let consumeResult = await axios.get("http://localhost:3000/api/v1/reports/totalsupplierorderspricesdata");
                for(let item of gainResult.data) {
                    this.bigLineChart.chartData.datasets[0].data.push(item.total_gain);
                    this.bigLineChart.chartData.labels.push(item.just_date);
                }
                for(let item of consumeResult.data) {
                    this.bigLineChart.chartData.datasets[1].data.push(item.total_gain);
                }

            }
        },
        created() {

        },
        mounted() {
            this.getTotalGain();
            this.getTotalConsume();
            this.getTotalProfit();
            this.getMostFavFoods();
            this.getConsumeGainTimeLine();
        }
    };
</script>
<style scoped/>
