-- 1. GetFarmAnimalsByType
CREATE OR REPLACE FUNCTION get_farm_animals_by_type(
  in_farm_id INT,
  in_animal_type VARCHAR
)
RETURNS TABLE (
  animal_name VARCHAR,
  health_status VARCHAR,
  age INT
)
AS $$
BEGIN
  -- Retrieve a list of animals on the farm of the specified type
  RETURN QUERY SELECT animals.name, animals.health, animals.age
               FROM animals
               JOIN farm ON farm.storageAnimal_id = animals.id
               WHERE farm.id = in_farm_id AND animals.type_animals_id = (SELECT id FROM type_animals WHERE type_animal = in_animal_type);
END;
$$ LANGUAGE plpgsql;

-- 2. CalculateTotalDealCost
CREATE OR REPLACE FUNCTION calculate_total_deal_cost(
  in_deal_id INT
)
RETURNS INT
AS $$
DECLARE
  total_cost INT;
BEGIN
  -- Calculate the total cost of the deal
  SELECT SUM(cost) INTO total_cost FROM deal WHERE id = in_deal_id;
  RETURN total_cost;
END;
$$ LANGUAGE plpgsql;

-- 3. GetBuyerDealsByDate
CREATE OR REPLACE FUNCTION get_buyer_deals_by_date(
  in_buyer_people_id INT,
  in_start_date DATE,
  in_end_date DATE
)
RETURNS TABLE (
  deal_id INT,
  deal_date DATE,
  total_cost INT
)
AS $$
BEGIN
  -- Retrieve a list of buyer's deals within the specified period
  RETURN QUERY SELECT deal.id, deal.date, deal.cost
               FROM deal
               JOIN buyer ON deal.buyer_people_id = buyer.people_id
               WHERE buyer.people_id = in_buyer_people_id AND deal.date BETWEEN in_start_date AND in_end_date;
END;
$$ LANGUAGE plpgsql;

-- 4. CountAnimalsByHealthStatus
CREATE OR REPLACE FUNCTION count_animals_by_health_status(
  in_farm_id INT,
  in_health_status VARCHAR
)
RETURNS INT
AS $$
DECLARE
  animal_count INT;
BEGIN
  -- Count the number of animals on the farm with the specified health status
  SELECT COUNT(*) INTO animal_count FROM animals WHERE farm_id = in_farm_id AND health = in_health_status;
  RETURN animal_count;
END;
$$ LANGUAGE plpgsql;

-- 5. AverageAnimalWeightByType
CREATE OR REPLACE FUNCTION average_animal_weight_by_type(
  in_farm_id INT,
  in_animal_type VARCHAR
)
RETURNS DECIMAL
AS $$
DECLARE
  avg_weight DECIMAL;
BEGIN
  -- Calculate the average weight of animals on the farm of the specified type
  SELECT AVG(animals.weight) INTO avg_weight
  FROM animals
  JOIN farm ON farm.storageAnimal_id = animals.id
  WHERE farm.id = in_farm_id AND animals.type_animals_id = (SELECT id FROM type_animals WHERE type_animal = in_animal_type);
  RETURN avg_weight;
END;
$$ LANGUAGE plpgsql;

-- 6. GetTotalAnimalProductCount
CREATE OR REPLACE FUNCTION get_total_animal_product_count()
RETURNS INT
AS $$
DECLARE
  total_count INT;
BEGIN
  -- Retrieve the total count of animal products
  SELECT SUM(count) INTO total_count FROM storageAnimalProduct;
  RETURN total_count;
END;
$$ LANGUAGE plpgsql;
