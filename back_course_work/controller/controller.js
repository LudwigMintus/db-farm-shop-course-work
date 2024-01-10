const db = require('../db')
class UserController {
    async checkUser (req, res) {
        const {phone, password} = req.body
        const checkUser = await db.query(
            'SELECT * FROM people WHERE phone = $1 AND password = $2',
            [phone, password]
        );
        if( checkUser.length !== 0)
        if (phone === checkUser.rows[0].phone || password === checkUser.rows[0].password){
            const farmerId = checkUser.rows[0].id;
            const checkFarmerQuery = await db.query(
                'SELECT EXISTS (SELECT 1 FROM farmer WHERE people_id = $1) AS is_farmer',
                [farmerId]
            );
            const isFarmer = checkFarmerQuery.rows[0].is_farmer;
            const result = Object.assign({}, checkUser.rows[0], { isFarmer });
            res.json(result)
        }
    }
    async getGoods(req, res) {
        const getGoods = await db.query('select * from goods'
    );
        res.json(getGoods.rows)
    }
    async getPeopleId(req, res) {
        const {id} = req.body
        const getGoodsId = await db.query(
            'SELECT p.name, p.surname, e.Money AS ecvaer_money FROM people p JOIN ekvaera e ON p.id = e.id LEFT JOIN deal d ON p.id = d.buyer_people_id WHERE p.id = $1;', [id]
        );
        res.json(getGoodsId.rows)
    }
    async getGoodsId(req, res) {
        const {id} = req.body
        const getGoodsId = await db.query(
            'select * from goods where farmer_id = $1;',[id]);
        res.json(getGoodsId.rows)
    }
    async buyItem(req, res) {
        const { cart, cartTotal, myId } = req.body;

        for (const item of cart) {
            console.log(item.qty)
            // Получаем информацию о товаре
            const goods = await db.query('SELECT * FROM goods WHERE id = $1', [item.id]);
            console.log(goods.rows[0].count)
            // Проверяем, есть ли достаточное количество товара
            if (goods.rows[0].count >= item.qty) {

                // Уменьшаем средства у покупателя в таблице ekvaera
                await db.query('UPDATE ekvaera SET money = money - $1 WHERE id = (SELECT ekvaer_id FROM buyer WHERE people_id = $2)',
                    [cartTotal, myId]);

                // Уменьшаем количество товара в таблице goods
                await db.query('UPDATE goods SET count = count - $1 WHERE id = $2', [item.qty, item.id]);

                // Создаем новую сделку в таблице deal
                await db.query('INSERT INTO deal (goods_id, quantity, buyer_people_id, cost, data) VALUES ($1, $2, $3, $4, CURRENT_DATE)',
                    [item.id, item.qty, myId, cartTotal]);

                // Увеличиваем средства у фермера в таблице ekvaera
                await db.query('UPDATE ekvaera SET money = money + $1 WHERE id = (SELECT ekvaer_id FROM farmer WHERE people_id = $2)',
                    [cartTotal, goods.rows[0].farmer_id]);
            } else {
                // Обработка случая, когда товара недостаточно
                throw new Error(`Not enough quantity for product ${goods.name}`);
            }
        }
        res.json(true)
    }

    async getDealId(req, res) {
        const {id} = req.body
        const getDealId = await db.query(`
            SELECT
                deal.*,
                goods.name AS product_name,
                goods.count AS ordered_quantity,
                people.name AS buyer_name,
                people.phone AS buyer_phone,
                buyer.address AS buyer_address
            FROM
                deal
                    JOIN
                goods ON deal.goods_id = goods.id
                    JOIN
                people ON deal.buyer_people_id = people.id
                    JOIN
                buyer ON people.id = buyer.people_id
            WHERE
                goods.farmer_id = $1 AND deal.data >= CURRENT_DATE - INTERVAL '3 days'`, [id]);
        res.json(getDealId.rows)
        console.log(getDealId)
    }
}
module.exports = new UserController()