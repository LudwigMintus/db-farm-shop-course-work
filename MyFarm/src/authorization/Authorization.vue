<template>
    <div class="container min-h-content py-5 text-center ">
        <div class="row py-lg-5">
            <div class="col-lg-6 col-md-8 mx-auto">
                <div class="login-form bg-dark">
                    <h2 class="mb-4 text-bg-white">Login</h2>
                    <div class="form-group">
                        <label for="username">Phone "***-***-****":</label>
                        <input type="email" v-model="phone" placeholder="Enter your Phone" />
                    </div>
                    <div class="form-group">
                        <label for="password">Password:</label>
                        <input type="password" v-model="password" placeholder="Enter your password" />
                    </div>
                    <div class="form-group ">
                        <button @click="login">Login</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import AppHeader from "../components/AppHeader.vue";

export default {
    components: {AppHeader},
    data() {
        return {
            phone: '',
            password: '',
        };
    },
    methods: {
        async login() {
            try {
                // Perform authentication, get token from server
                const response = await this.authenticateUser();
                if (response.ok) {
                    const responseData = await response.json();
                    localStorage.setItem('Id', responseData.id); // Изменение здесь
                    if (responseData.isFarmer === true) {
                        localStorage.setItem('Token', 'authenticateFarmer'); // Изменение здесь
                        // Redirect to home
                        this.$router.push('/');
                    } else {
                        localStorage.setItem('Token', 'authenticateUser');
                        this.$router.push('/');
                    }
                } else {
                    console.error('Login failed');
                }
            } catch (error) {
                console.error('Error during login:', error);
            }
        },
        async authenticateUser() {
            return fetch('http://localhost:8080/api/authorization', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                },
                body: JSON.stringify({
                    phone: this.phone,
                    password: this.password,
                }),
            });
        },
    },
};
</script>

<style scoped>
    .login-form {
        background-color: #ffffff;
        border: 1px solid #e6e6e6;
        border-radius: 8px;
        padding: 30px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    h2 {
        color: #f1f1f1;
    }

    label {
        display: block;
        font-weight: bold;
        margin-bottom: 8px;
        color: #757272;
    }

    input {
        width: 100%;
        padding: 12px;
        font-size: 16px;
        border: 1px solid #ccc;
        border-radius: 4px;
        margin-bottom: 15px;
        box-sizing: border-box;
    }

    button {
        background-color: #ffffff;
        color: #000000;
        border: 1px;
        padding: 12px 20px;
        font-size: 16px;
        border-radius: 4px;
        cursor: pointer;
    }

    button:hover {
        background-color: #ffffff;
    }

    p {
        margin-top: 15px;
        font-size: 14px;
        color: #666;
    }

    a {
        color: #007bff;
        text-decoration: none;
        font-weight: bold;
    }

    a:hover {
        text-decoration: underline;
    }
</style>
