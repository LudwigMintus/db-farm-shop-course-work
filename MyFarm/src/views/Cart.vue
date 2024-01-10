<template>
    <section class="h-100 h-custom min-h-content">
        <div class="container py-5 h-100">
            <div class="row d-flex justify-content-center align-items-center h-100">
                <div class="col">
                    <div class="card border-0">
                        <div class="card-body p-4">

                            <div class="row">
                                <div class="col-lg-7">
                                    <h5 class="mb-3">
                                        <router-link :to="{name:'Home'}" class="text-body"><i
                                                class="fas fa-long-arrow-alt-left me-2"></i>Continue shopping
                                        </router-link>
                                    </h5>
                                    <hr>

                                    <div class="d-flex justify-content-between align-items-center mb-4">
                                        <div>
                                            <p class="mb-0">You have {{ $store.state.cart.length }} items in your
                                                cart</p>
                                        </div>
                                    </div>

                                    <div v-for="item in $store.state.cart" class="card mb-3 shadow-sm border-0"
                                         :key="item.id">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between">
                                                <div class="d-flex flex-row align-items-center">
                                                    <div>
                                                        <img
                                                                :src="'../../public/img/' + item.photo"
                                                                class="img-fluid rounded-3" alt="Shopping item"
                                                                style="width: 65px;">
                                                    </div>
                                                    <div class="ms-3">
                                                        <p>{{ item.name }}</p>
                                                    </div>
                                                </div>
                                                <div class="d-flex flex-row align-items-center">
                                                    <div>
                                                        <CartAddRemove :product="item"/>
                                                    </div>
                                                </div>
                                                <div class="d-flex flex-row align-items-center">
                                                    <div>
                                                        <h5 class="mb-0"><i class="bi bi-currency-dollar"></i>{{
                                                            item.cost * item.qty
                                                            }}</h5>
                                                        <small v-if="item.hasDiscount"
                                                               class="text-muted text-decoration-line-through"><i
                                                                class="bi bi-currency-dollar"></i>{{
                                                            item.cost
                                                            }}</small>
                                                    </div>
                                                    <a role="button" @click="removeItem(item)" class="ms-4"
                                                       style="color: #cecece;"><i class="bi bi-trash3 h4"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-5">

                                    <div class="card bg-dark text-white rounded-0 border-0">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-center mb-4">
                                                <h5 class="mb-0 ">Cart details</h5>
                                                <i class="bi bi-cart3 h1"></i>
                                            </div>
                                            <hr class="my-4">
                                            <div class="d-flex justify-content-between">
                                                <p class="mb-2">Subtotal</p>
                                                <p class="mb-2"><i
                                                        class="bi bi-currency-dollar"></i>{{ $store.state.cartTotal }}
                                                </p>
                                            </div>
                                            <div class="d-flex justify-content-between mb-4">
                                                <p class="mb-2">Total</p>
                                                <p class="mb-2"><i
                                                        class="bi bi-currency-dollar"></i>{{ $store.state.cartTotal }}
                                                </p>
                                            </div>
                                            <button type="button" class="btn btn-light btn-block btn-lg text-dark" @click="Buy">
                                                Buy
                                            </button>
                                        </div>
                                    </div>

                                </div>

                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</template>
<script>
import CartAddRemove from '../components/CartAddRemove.vue';
import { toast } from 'vue3-toastify';
export default {

    components: {CartAddRemove},
    data() {
        return {
            cart: [],
            cartTotal: 0,
            id: null,
        };
    },
    methods: {
        removeItem(item) {
            this.$store.commit('addRemoveCart', {product: item, toAdd: false})
        },
        async Buy() {
            if (this.cart !== null && this.cart !== undefined){
                const result = this.cart.map(item => ({ id: item.id, qty: item.qty }));
            try {
                const response = await fetch('http://localhost:8080/api/buy', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                            'Accept': 'application/json',
                        },
                        body: JSON.stringify({
                            cart: result,
                            cartTotal: this.cartTotal,
                            myId: this.id,
                        })
                    });
                if (response.ok) {
                    localStorage.removeItem("cart");
                    localStorage.removeItem("cartTotal");
                    this.$store.commit('clearCartData');
                    this.cart = [];
                    this.cartTotal = 0;
                    this.$router.push('/');
                    setTimeout(() => {
                        toast.success('Your order has been accepted and will be shipped within 3 days')
                        toast.success('You will be contacted upon delivery')
                    }, 2000);
                } else {
                    console.error('Error fetching data:', response.statusText);
                }
            } catch (error) {
                console.error('Error fetching data:', error);
            }
            }
        },
    },
    mounted() {
        this.cart = JSON.parse(localStorage.getItem('cart'));
        this.cartTotal = localStorage.getItem('cartTotal');
        this.id = localStorage.getItem('Id');
    },

}
</script>