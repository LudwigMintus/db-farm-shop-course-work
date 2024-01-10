<template>
    <div class="container min-h-content py-5 text-center">
        <div class="row py-lg-1">
            <input v-model="searchQuery" placeholder="search name" class="form-control mb-1" />
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                <div class="col" v-for="product in filteredProducts" :key="product.id">
                    <div class="card shadow-sm">
                        <img class="bd-placeholder-img card-img-top" width="100%" :src="'../../public/img/' + product.photo" alt="" />
                        <div class="card-body">
                            <p class="card-text">{{ product.name }}</p>
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="btn-group">
                                    <CartBTN :product="product" />
                                </div>
                                <small class="text-muted"><i class="bi "></i>Available {{ product.count }}</small>
                                <small class="text-muted"><i class="bi bi-currency-dollar"></i>{{ product.cost }}</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import CartBTN from '../components/CartBTN.vue';

export default {
    components: { CartBTN },
    data() {
        return {
            searchQuery: '', // Добавлено свойство для хранения запроса поиска
            products: [],
        };

    },
    methods: {
        async getData() {
            try {
                const response = await fetch('http://localhost:8080/api/goods', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'Accept': 'application/json',
                    },
                    body: JSON.stringify({}),
                });

                if (response.ok) {
                    const responseData = await response.json();
                    const products = responseData;
                    this.products = products;
                    console.log(responseData);
                } else {
                    console.error('Error fetching data:', response.statusText);
                }
            } catch (error) {
                console.error('Error fetching data:', error);
            }
        },
    },
    computed: {
        // Фильтруем список товаров в соответствии с запросом поиска
        filteredProducts() {
           return this.products.filter(product => product.name.toLowerCase().includes(this.searchQuery.toLowerCase()));
        },
    },
    mounted() {
        this.getData();
    },
};
</script>
