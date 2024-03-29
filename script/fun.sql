-- 1. Add Farmer
CREATE OR REPLACE FUNCTION add_farmer(
    p_name VARCHAR,
    p_surname VARCHAR,
    p_patronymic VARCHAR,
    p_age INT,
    p_authorization_id INT,
    p_farm_id INT,
    p_registration_address VARCHAR,
    p_ekvaer_id INT
) RETURNS VOID AS $$
BEGIN
    INSERT INTO people (name, surname, patronymic, age)
    VALUES (p_name, p_surname, p_patronymic, p_age);

    INSERT INTO farmer (people_id, authorization_id, farm_id, registration_address, ekvaer_id)
    VALUES (currval('people_id_seq'), p_authorization_id, p_farm_id, p_registration_address, p_ekvaer_id);
END;
$$ LANGUAGE plpgsql;

-- 2. Add Buyer
CREATE OR REPLACE FUNCTION add_buyer(
    p_name VARCHAR,
    p_surname VARCHAR,
    p_patronymic VARCHAR,
    p_age INT,
    p_ekvaer_id INT,
    p_authorization_id INT,
    p_address VARCHAR
) RETURNS VOID AS $$
BEGIN
    INSERT INTO people (name, surname, patronymic, age)
    VALUES (p_name, p_surname, p_patronymic, p_age);

    INSERT INTO buyer (people_id, ekvaer_id, authorization_id, address)
    VALUES (currval('people_id_seq'), p_ekvaer_id, p_authorization_id, p_address);
END;
$$ LANGUAGE plpgsql;

-- 3. Add Product
CREATE OR REPLACE FUNCTION add_product(
    p_type_product VARCHAR
) RETURNS VOID AS $$
BEGIN
    INSERT INTO manufactured_products (type_product)
    VALUES (p_type_product);
END;
$$ LANGUAGE plpgsql;

-- 4. Add Animal
CREATE OR REPLACE FUNCTION add_animal(
    p_name VARCHAR,
    p_type_animal_id INT,
    p_health VARCHAR,
    p_age INT,
    p_weight INT,
    p_manufactured_products_id INT,
    p_sales BOOLEAN
) RETURNS VOID AS $$
BEGIN
    INSERT INTO animals (name, type_animals_id, health, age, weight, manufactured_products_id, sales)
    VALUES (p_name, p_type_animal_id, p_health, p_age, p_weight, p_manufactured_products_id, p_sales);
END;
$$ LANGUAGE plpgsql;

-- 5. Add Culture
CREATE OR REPLACE FUNCTION add_culture(
    p_name VARCHAR
) RETURNS VOID AS $$
BEGIN
    INSERT INTO culture (name)
    VALUES (p_name);
END;
$$ LANGUAGE plpgsql;

-- 6. Add Deal
CREATE OR REPLACE FUNCTION add_deal(
    p_goods_id INT,
    p_quantity INT,
    p_buyer_people_id INT,
    p_cost INT
) RETURNS VOID AS $$
BEGIN
    INSERT INTO deal (goods_id, quantity, buyer_people_id, cost)
    VALUES (p_goods_id, p_quantity, p_buyer_people_id, p_cost);
END;
$$ LANGUAGE plpgsql;

-- 7. Update Farmer Info
CREATE OR REPLACE FUNCTION update_farmer_info(
    p_people_id INT,
    p_authorization_id INT,
    p_farm_id INT,
    p_registration_address VARCHAR,
    p_ekvaer_id INT
) RETURNS VOID AS $$
BEGIN
    UPDATE farmer
    SET authorization_id = p_authorization_id,
        farm_id = p_farm_id,
        registration_address = p_registration_address,
        ekvaer_id = p_ekvaer_id
    WHERE people_id = p_people_id;
END;
$$ LANGUAGE plpgsql;

-- 8. Delete Animal
CREATE OR REPLACE FUNCTION delete_animal(
    p_animal_id INT
) RETURNS VOID AS $$
BEGIN
    DELETE FROM animals WHERE id = p_animal_id;
END;
$$ LANGUAGE plpgsql;

-- 9. Get Farmer Products
CREATE OR REPLACE FUNCTION get_farmer_products(
    p_farmer_people_id INT
) RETURNS TABLE (
    id INT,
    name_goods VARCHAR,
    unit_price INT,
    count INT
) AS $$
BEGIN
    RETURN QUERY SELECT id, name_goods, unit_price, count
                 FROM goods
                 WHERE farmer_people_id = p_farmer_people_id;
END;
$$ LANGUAGE plpgsql;

-- 10. Get Farmer Total Income
CREATE OR REPLACE FUNCTION get_farmer_total_income(
    p_farmer_people_id INT
) RETURNS INT AS $$
DECLARE
    total_income INT;
BEGIN
    SELECT SUM(cost) INTO total_income
    FROM deal
    WHERE goods_id IN (SELECT id FROM goods WHERE farmer_people_id = p_farmer_people_id);

    RETURN COALESCE(total_income, 0);
END;
$$ LANGUAGE plpgsql;
