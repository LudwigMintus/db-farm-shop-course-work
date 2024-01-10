<template>
    <div>
        <button @click="deleteGoods" class="btn btn-dark btn-lg text-light">Delete</button>
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
        };
    },
    methods: {
        addGoods() {

            this.isModalVisible = true;
        },
        closeModal() {
            this.isModalVisible = false;
        },
        deleteGoods(){
            this.closeModal();
        }
    }
}
</script>

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