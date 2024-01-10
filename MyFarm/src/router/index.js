import { createRouter, createWebHistory } from 'vue-router';
import Home from '/src/views/Home.vue';
import About from '/src/views/About.vue';
import Cart from '/src/views/Cart.vue';
import Farm from '/src/farmer/Farm.vue'
import AuthorizationPage from '/src/authorization/Authorization.vue'; // New component
import DefaultLayout from '/src/layouts/DefaultLayout.vue';

const routes = [
    {
        path: '/',
        name: 'Public',
        component: DefaultLayout,
        redirect: '/',
        children: [
            {
                path: '/',
                name: 'Home',
                component: Home,
                meta: { requiresAuth: true },

            },
            {
                path: '/about',
                name: 'About',
                component: About,
                meta: { requiresAuth: true },
            },
            {
                path: '/cart',
                name: 'Cart',
                component: Cart,
                meta: { requiresAuth: true },

            },
            {
                path: '/authorization',
                name: 'Authorization',
                component: AuthorizationPage,
                meta: { requiresAuth: false },
            },
            {

                path: '/farm',
                name: 'Farm',
                component: Farm,
                meta: { requiresAuth: true },
            },
        ],
    },
    // Authorization route outside of Public layout

];

const router = createRouter({
    history: createWebHistory(),
    routes,
});

router.beforeEach((to, from, next) => {
    // Проверяем наличие токена в локальном хранилище
    const token = localStorage.getItem('Token');
    // Если токен не найден и маршрут требует аутентификации, перенаправляем на страницу авторизации
    if (to.meta.requiresAuth && !(token === 'authenticateFarmer' || token === 'authenticateUser')) {
        next({ path: '/authorization' }); // Используйте объект вместо строки
    } else {
        next();
    }
});
export default router;
