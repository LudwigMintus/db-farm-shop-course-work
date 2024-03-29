-- Trigger to Update Animal Age
CREATE OR REPLACE FUNCTION check_animal_age()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.age < 0 THEN
    RAISE EXCEPTION 'Animal age must be greater than or equal to zero.';
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER farm_check_animal_age
BEFORE INSERT OR UPDATE ON animals
FOR EACH ROW
EXECUTE FUNCTION check_animal_age();

-- Trigger to Update Goods Count
CREATE OR REPLACE FUNCTION update_goods_count()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE goods
  SET count = count - NEW.quantity
  WHERE id = NEW.goods_id;

  IF (SELECT count FROM goods WHERE id = NEW.goods_id) < 0 THEN
    RAISE EXCEPTION 'Insufficient goods in stock for the deal.';
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER deal_update_goods_count
AFTER INSERT ON deal
FOR EACH ROW
EXECUTE FUNCTION update_goods_count();

-- Trigger to Check Goods Unit Price
CREATE OR REPLACE FUNCTION check_goods_unit_price()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.cost <= 0 THEN
    RAISE EXCEPTION 'Unit price of goods must be greater than zero.';
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER goods_check_unit_price
BEFORE INSERT OR UPDATE ON goods
FOR EACH ROW
EXECUTE FUNCTION check_goods_unit_price();

-- Trigger to Sync Storage Animal on Sale
CREATE OR REPLACE FUNCTION sync_storage_animal_on_sale()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.sales = TRUE THEN
    -- If the animal is being sold, decrease the count in storage
    UPDATE storageAnimal
    SET count = count - 1
    WHERE animals_id = NEW.id;

    IF (SELECT count FROM storageAnimal WHERE animals_id = NEW.id) < 0 THEN
      RAISE EXCEPTION 'Insufficient animals in storage for sale.';
    END IF;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS sync_storage_animal_on_sale ON animals;

CREATE TRIGGER sync_storage_animal_on_sale
AFTER UPDATE ON animals
FOR EACH ROW
EXECUTE FUNCTION sync_storage_animal_on_sale();
