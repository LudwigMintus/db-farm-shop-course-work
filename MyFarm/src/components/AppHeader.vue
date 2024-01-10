<template>
    <header>
        <div class="navbar navbar-dark bg-dark shadow-sm">
            <div class="container">
                <!-- Show only if route is not /authorization -->
                <router-link
                        v-if="$route.name !== 'Authorization'"
                        :to="{ name: 'Home' }"
                        class="navbar-brand d-flex align-items-center"
                >
                    <i class="bi bi-box2-heart h1 me-1"></i>
                    <strong>Farmer store</strong>
                </router-link>

                <!-- Show only if route is /authorization -->
                <div v-if="$route.name === 'Authorization'" class="navbar-brand d-flex align-items-center">
                    <i class="bi bi-box2-heart h1 me-1"></i>
                    <strong>Farmer store</strong>
                </div>

                <router-link
                        v-if="$route.name !== 'Authorization' && isTokenValid()"
                        :to="{ name: 'Farm' }"
                        class="ms-auto mb-2 mb-lg-0 me-3 farm-icon-link"
                >
                    <i class="bi bi-house-door h2 text-muted"></i>
                </router-link>

                <!-- Only show if route is not /authorization -->
                <ul v-if="$route.name !== 'Authorization'" class="navbar-nav ms-auto mb-2 mb-lg-0">

                    <li class="nav-item me-3">
                        <router-link
                                class="nav-link"
                                :class="$route.name == 'Cart' ? 'active' : ''"
                                aria-current="page"
                                :to="{ name: 'Cart' }"
                        >
                            <i class="bi bi-cart3 h4"></i>
                            <span v-if="$store.state.cart !== null && $store.state.cart.length > 0"
                                  class="align-items-center justify-content-center translate-middle badge rounded-pill bg-secondary">
                {{ $store.state.cart.length }}
            </span>
                        </router-link>
                    </li>
                </ul>
                ц

                <!-- Only show if route is not /authorization -->
                <button v-if="$route.name !== 'Authorization'" class="navbar-toggler" type="button"
                        data-bs-toggle="collapse" data-bs-target="#navbarHeader" aria-controls="navbarHeader"
                        aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <!-- Show the icon linking to /farm -->

            </div>
        </div>
        <div class="collapse bg-dark" id="navbarHeader">
            <div class="container">
                <div class="row">
                    <div class="col-sm-12 text-center py-4" v-if="people" >
                        <h4 class="text-white">
                            Вы авторизировались как: {{ people.name }} {{ people.surname }}
                        </h4>
                        <h4 class="text-white" >
                            У вас на счету: {{people.ecvaer_money}}
                        </h4>
                    </div>
                </div>
            </div>
        </div>
    </header>
</template>

<style scoped>
.farm-icon {
    font-size: 2rem; /* Adjust the size of the farm icon */
}

.text-center {
    text-align: center;
}
</style>

<script>

const IDE = localStorage.getItem('Id');
export default {

    data() {
        return {
            people: [],
        };
    },
    methods: {
        isTokenValid() {
            const token = localStorage.getItem('Token');
            return token === 'authenticateFarmer' && token !== null && token !== undefined;
        },
        async getPersonId() {
            try {
                const response = await fetch('http://localhost:8080/api/peopleId', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'Accept': 'application/json',
                    },
                    body: JSON.stringify({
                        id: IDE,
                    }),
                });

                if (response.ok) {
                    const responseData = await response.json();
                    console.log(responseData[0].name)
                    this.people = {
                        name: responseData[0].name,
                        surname: responseData[0].surname,
                        ecvaer_money: responseData[0].ecvaer_money
                    }
                } else {
                    console.error('Error fetching data:', response.statusText);
                }
            } catch (error) {
                console.error('Error fetching data:', error);
            }
        },
    },
    mounted() {
        this.getPersonId();
    },
}


</script>
