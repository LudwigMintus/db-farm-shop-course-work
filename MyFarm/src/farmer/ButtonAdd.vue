<template>
    <div>
        <button @click="addGoods" class="btn btn-dark btn-lg text-light">Добавить</button>
        <!-- Модальное окно -->
        <div class="modal" v-show="isModalVisible" @click.self="closeModal">
            <div class="modal-dialog" @click.stop>
                <div class="modal-content">
                    <!-- заголовк -->
                    <div class="modal-header">
                        <slot name="header">
                            <h5 class="modal-title">Добавить товар</h5>
                        </slot>
                        <button type="button" class="close" @click="closeModal">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <!--тело -->
                    <div class="modal-body">
                        <slot name="body">
                            <div class="form-group">
                            </div>
                        </slot>
                    </div>
                    <!--футер -->
                    <div class="modal-footer">
                        <slot name="footer">
                            <button type="button" class="btn btn-secondary" @click="closeModal">Закрыть</button>
                            <button type="button" class="btn btn-primary btn-dark" @click="saveGoods">Сохранить</button>
                        </slot>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            isModalVisible: false,
            selector1: null,
            selector2: null,
            selector3: null,
            input1: '',
            input2: '',
        };
    },
    methods: {
        addGoods() {
            this.isModalVisible = true;
        },
        closeModal() {
            this.isModalVisible = false;
        },
        saveGoods() {
            // Реализуйте логику сохранения товаров здесь
            console.log('Goods saved:', {
                selector1: this.selector1,
                selector2: this.selector2,
                selector3: this.selector3,
                input1: this.input1,
                input2: this.input2,
            });
            this.closeModal();
        },
    },
};
</script>

<style scoped>
/* Стили для модального окна */
.modal {
    display: block;
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 400px; /* Регулируйте ширину модального окна по необходимости */
}

.modal-content {
    background-color: #fff;
    padding: 20px;
}

.modal-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.modal-footer {
    display: flex;
    justify-content: flex-end;
}
</style>

<style scoped>
.btn {
    width: 175px;
    height: 60px;
    border-radius: 5px;
    font-size: 18px;
    border: 2px solid #343a40;
    margin-right: 10px;
}
</style>
<style  scoped>
.btn {
    width: 175px;
    height: 60px;
    border-radius: 5px;
    font-size: 18px;
    border: 2px solid #343a40;
    margin-right: 10px;
}
</style>