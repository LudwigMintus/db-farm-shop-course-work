<template>
    <div>
        <h2 class="text-center mb-4"><strong></strong></h2>

        <div class="table-controls d-flex">
            <ButtonAdd></ButtonAdd>
            <ButtonRemove></ButtonRemove>
            <div class="me-3">
                <input type="text" v-model="searchTerm" class="form-control" id="search" placeholder="Search" />
            </div>
        </div>
        <h2 class="text-center mb-4"><strong>Displayed goods</strong></h2>

        <table class="goods-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Photo</th>
                <th>Name</th>
                <th>Unit Price</th>
                <th>Count</th>
                <th></th> <!-- Checkbox column hАхываeader -->

            </tr>
            </thead>
            <tbody>
            <tr v-for="good in filteredGoods" :key="good.id">
                <td>{{ good.id }}</td>
                <td><img :src="'../../public/img/' + good.photo" alt="Good Photo" style="max-width: 200px; max-height: 150px;" /></td>
                <td>{{ good.name }}</td>
                <td>{{ good.cost }}</td>
                <td>{{ good.count }}</td>
                <td><input type="checkbox" v-model="good.selected" /></td>
            </tr>
            </tbody>
        </table>

        <h2 class="text-center mb-4"><strong>Dils (Deliver within 3 days) </strong></h2>

        <table class="goods-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Count</th>
                <th>Cost</th>
                <th>Name Products</th>
                <th>Name</th>
                <th>Phone</th>
                <th>Adress</th>

            </tr>
            </thead>
            <tbody>
            <tr v-for="deal in this.deal" :key="deal.id">
                <td>{{ deal.id }}</td>
                <td>{{ deal.quantity}}</td>
                <td>{{ deal.cost }}</td>
                <td>{{ deal.product_name }}</td>
                <td>{{ deal.buyer_name }}</td>
                <td>{{ deal.buyer_phone }}</td>
                <td>{{ deal.buyer_address }}</td>
            </tr>
            </tbody>
        </table>



    </div>
</template>

<script>
import ButtonAdd from './ButtonAdd.vue';
import ButtonRemove from './ButtonRemove.vue';
const id = localStorage.getItem('Id');

export default {
    components:{ButtonAdd,ButtonRemove},
    data() {
        return {
            goods: [],
            deal:[],
            searchTerm: '',
        };
    },
    methods: {
        async getDataId() {
            try {
                const response = await fetch('http://localhost:8080/api/goodsId', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'Accept': 'application/json',
                    },
                    body: JSON.stringify({
                        id: id,
                    }),
                });

                if (response.ok) {
                    const responseData = await response.json();
                    const goods = responseData;
                    console.log(goods);
                    this.goods = goods;
                } else {
                    console.error('Error fetching data:', response.statusText);
                }
            } catch (error) {
                console.error('Error fetching data:', error);
            }
        },
        async getDataDealId() {
            try {
                const response = await fetch('http://localhost:8080/api/dealId', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'Accept': 'application/json',
                    },
                    body: JSON.stringify({
                        id: id,
                    }),
                });

                if (response.ok) {
                    const responseData = await response.json();
                    const deal = responseData;
                    this.deal = deal;
                } else {
                    console.error('Error fetching data:', response.statusText);
                }
            } catch (error) {
                console.error('Error fetching data:', error);
            }
        }
    },
    computed: {
        filteredGoods() {
            // Filter goods based on the search term
            const regex = new RegExp(this.searchTerm, 'i');
            return this.goods.filter(good => regex.test(good.name_goods));
        },
        filteredDeal() {
            // Filter goods based on the search term
            const regex = new RegExp(this.searchTerm, 'i');
            return this.goods.filter(good => regex.test(deal.name));
        },
    },
    mounted() {
        const id = localStorage.getItem('Id');
        this.getDataId();
        this.getDataDealId();
    },
};
</script>

<style scoped>
.text-center {
    text-align: center;
}

.table-controls {
    display: flex;
    justify-content: flex-start;
    margin-bottom: 20px;
}

.btn-dark {
    background-color: #343a40;
}

.goods-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

.goods-table th,
.goods-table td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
}

.goods-table th {
    background-color: #f2f2f2;
}

/* Additional styling for the search input */
.form-control {
    width: 100%;
    height: 60px;
    padding: 10px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}
</style>
