const Router = require ('express')
const router = new Router()
const userController = require('../controller/controller')

router.post('/authorization', userController.checkUser);
router.post('/goods', userController.getGoods);
router.post('/peopleId', userController.getPeopleId);
router.post('/goodsId', userController.getGoodsId);
router.post('/buy', userController.buyItem);
router.post('/dealId', userController.getDealId);

module.exports = router