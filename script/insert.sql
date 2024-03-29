-- Фермеры
INSERT INTO people (id, password, phone, name, surname, patronymic, age) VALUES
(1, 123456, '123-456-7890', 'John', 'Doe', 'Smith', 30),
(2, 987654, '987-654-3210', 'Jane', 'Doe', 'Johnson', 25),
(3, 111222, '111-222-3333', 'Bob', 'Smith', 'Johnson', 40),
(4, 555666, '555-666-7777', 'Alice', 'Johnson', 'Doe', 35),
(5, 999888, '999-888-7777', 'Eva', 'Brown', 'Doe', 28);

-- Карты фермеров
INSERT INTO ekvaera (id, number_card, data, CVV, Money) VALUES
(1, 1234567890123456, '2023-12-01', 123, 5000),
(2, 9876543210987654, '2024-05-01', 456, 8000),
(3, 1111222233334444, '2023-11-01', 789, 3000),
(4, 5555666677778888, '2024-02-01', 234, 6000),
(5, 9999888877776666, '2024-08-01', 567, 7500);

-- Фермеры
INSERT INTO farmer (people_id, farm_id, registration_address, ekvaer_id) VALUES
(1, 1, '123 Farm Road', 1),
(2, 2, '456 Harvest Lane', 2),
(3, 3, '789 Crop Street', 3),
(4, 4, '101 Pasture Avenue', 4),
(5, 5, '202 Silo Street', 5);

-- Покупатели
INSERT INTO people (id, password, phone, name, surname, patronymic, age) VALUES
(6, 112233, '111-111-1111', 'Mike', 'Tyson', 'Johnson', 45),
(7, 445566, '222-222-2222', 'Anna', 'Lee', 'Doe', 32),
(8, 778899, '333-333-3333', 'David', 'Brown', 'Johnson', 28),
(9, 101112, '444-444-4444', 'Emily', 'White', 'Doe', 38),
(10, 131415, '555-555-5555', 'Charlie', 'Miller', 'Johnson', 50);

-- Карты покупателей
INSERT INTO ekvaera (id, number_card, data, CVV, Money) VALUES
(6, 1111222233334444, '2025-01-01', 999, 2000),
(7, 4444333322221111, '2024-09-01', 888, 1500),
(8, 7777666655554444, '2023-10-01', 777, 3000),
(9, 1010101010101010, '2025-02-01', 666, 4000),
(10, 1313131313131313, '2024-12-01', 555, 2500);

-- Покупатели
INSERT INTO buyer (people_id, ekvaer_id, address) VALUES
(1, 1, '123 Farm Road'),
(2, 2, '456 Harvest Lane'),
(3, 3, '789 Crop Street'),
(4, 4, '101 Pasture Avenue'),
(5, 5, '202 Silo Street');
(6, 6, '123 Buyer Street'),
(7, 7, '456 Shopper Lane'),
(8, 8, '789 Consumer Avenue'),
(9, 9, '101 Market Road'),
(10, 10, '202 Grocery Lane');


-- Type Technique Table
INSERT INTO type_technique (id, name) VALUES
(1, 'Tractor'),
(2, 'Harvester'),
(3, 'Plow');

-- Technique Table
INSERT INTO technique (id, name, type_technique_id) VALUES
(1, 'John Deere 123', 1),
(2, 'Harvest King 5000', 2),
(3, 'PlowMaster 2000', 3);

-- Type Animals Table
INSERT INTO type_animals (id, type_animal) VALUES
(1, 'Cow'),
(2, 'Chicken'),
(3, 'Pig');

-- Manufactured Products Table
INSERT INTO manufactured_products (id, type_product) VALUES
(1, 'Milk'),
(2, 'Eggs'),
(3, 'Pork');

-- Animals Table
INSERT INTO animals (id, name, type_animals_id, health, age, weight, manufactured_products_id, Sales) VALUES
(1, 'Bessie', 1, 'Good', 4, 500, 1, TRUE),
(2, 'Cluckers', 2, 'Excellent', 1, 2, NULL, TRUE),
(3, 'Porky', 3, 'Fair', 2, 300, 3, FALSE),
(4, 'MooMoo', 1, 'Good', 3, 450, 1, TRUE),
(5, 'Feathers', 2, 'Excellent', 1, 1, NULL, TRUE);

-- Culture Table
INSERT INTO culture (id, name) VALUES
(1, 'Wheat'),
(2, 'Corn'),
(3, 'Potatoes');

-- StorageCulture Table
INSERT INTO storageCulture (id, culture_id, count) VALUES
(1, 1, 1000),
(2, 2, 800),
(3, 3, 1200),
(4, 1, 750),
(5, 2, 600);

-- Field Table
INSERT INTO field (id, size, yield_per_hectare, seeded, culture_id, data) VALUES
(1, 50, 2000.0, TRUE, 1, '2023-03-01'),
(2, 40, 1800.0, TRUE, 2, '2023-04-01'),
(3, 60, 2500.0, FALSE, 3, '2023-02-01'),
(4, 45, 2200.0, TRUE, 1, '2023-05-01'),
(5, 35, 1600.0, TRUE, 2, '2023-06-01');

-- StorageAnimal Table
INSERT INTO storageAnimal (id, animals_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- StorageAnimalProduct Table
INSERT INTO storageAnimalProduct (id, manufactured_products_id, data, count) VALUES
(1, 1, '2023-03-15', 50),
(2, 2, '2023-04-10', 120),
(3, 3, '2023-02-20', 30),
(4, 1, '2023-06-05', 40),
(5, 2, '2023-05-12', 90);

-- StorageTechnique Table
INSERT INTO storageTechnique (id, technique_id) VALUES
(1, 1),
(2, 2),
(3, 3);

-- Farm Table
INSERT INTO farm (id, name, storageTechnique_id, location, field_id, storageAnimalProduct_id, storageCulture_id, storageAnimal_id) VALUES
(1, 'Green Acres', 1, '123 Farm Road', 1, 1, 1, 1),
(2, 'Sunset Farm', 2, '456 Harvest Lane', 2, 2, 2, 2),
(3, 'Golden Fields', 3, '789 Crop Street', 3, 3, 3, 3),
(4, 'Meadow Valley', 1, '101 Pasture Avenue', 4, 4, 4, 4),
(5, 'Harvest Haven', 2, '202 Silo Street', 5, 5, 5, 5);

-- Goods Table
INSERT INTO goods (id, farmer_id, name, count, photo, cost) VALUES
(1, 'Fresh Milk', 50, 'milk.jpg', 32),
(2, 'Organic Eggs', 120, 'eggs.jpg',43),
(3, 'Premium Pork', 30, 'pork.jpg',324),

-- Deal Table
INSERT INTO deal (goods_id, quantity, buyer_people_id, cost, data) VALUES
(1, 10, 7, 100, '2023-03-20'),
(2, 30, 9, 250, '2023-04-15'),
(3, 5, 6, 50, '2023-02-25'),
(1, 8, 8, 80, '2023-06-10'),
(2, 20, 10, 180, '2023-05-15');
