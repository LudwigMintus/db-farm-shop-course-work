CREATE TABLE people (
  id INT PRIMARY KEY,
  password INT,
  phone VARCHAR,
  name VARCHAR,
  surname VARCHAR,
  patronymic VARCHAR,
  age INT
);

CREATE TABLE ekvaera (
  id INT PRIMARY KEY,
  number_card BIGINT,
  data DATE,
  CVV INT,
  Money INT
);

CREATE TABLE type_technique (
  id INT PRIMARY KEY,
  name VARCHAR
);

CREATE TABLE type_animals (
  id INT PRIMARY KEY,
  type_animal VARCHAR
);

CREATE TABLE technique (
  id INT PRIMARY KEY,
  name VARCHAR,
  type_technique_id INT,
  FOREIGN KEY (type_technique_id) REFERENCES type_technique(id)
);

CREATE TABLE manufactured_products (
  id INT PRIMARY KEY,
  type_product VARCHAR
);

CREATE TABLE animals (
  id INT PRIMARY KEY,
  name VARCHAR,
  type_animals_id INT,
  health VARCHAR,
  age INT,
  weight INT,
  manufactured_products_id INT,
  Sales BOOLEAN,
  FOREIGN KEY (type_animals_id) REFERENCES type_animals(id),
  FOREIGN KEY (manufactured_products_id) REFERENCES manufactured_products(id)
);

CREATE TABLE culture (
  id INT PRIMARY KEY,
  name VARCHAR
);

CREATE TABLE storageCulture (
  id INT PRIMARY KEY,
  culture_id INT,
  count INT,
  FOREIGN KEY (culture_id) REFERENCES culture(id)
);

CREATE TABLE field (
  id INT PRIMARY KEY,
  size INT,
  yield_per_hectare DOUBLE PRECISION,
  seeded BOOLEAN,
  culture_id INT,
  data DATE,
  FOREIGN KEY (culture_id) REFERENCES culture(id)
);

CREATE TABLE storageAnimal (
  id INT PRIMARY KEY,
  animals_id INT,
  FOREIGN KEY (animals_id) REFERENCES animals(id)
);

CREATE TABLE storageAnimalProduct (
  id INT PRIMARY KEY,
  manufactured_products_id INT,
  data DATE,
  count INT,
  FOREIGN KEY (manufactured_products_id) REFERENCES manufactured_products(id)
);

CREATE TABLE storageTechnique (
  id INT PRIMARY KEY,
  technique_id INT,
  FOREIGN KEY (technique_id) REFERENCES technique(id)
);

CREATE TABLE farm (
  id INT PRIMARY KEY,
  name VARCHAR,
  storageTechnique_id INT,
  location VARCHAR,
  field_id INT,
  storageAnimalProduct_id INT,
  storageCulture_id INT,
  storageAnimal_id INT,
  FOREIGN KEY (storageTechnique_id) REFERENCES storageTechnique(id),
  FOREIGN KEY (field_id) REFERENCES field(id),
  FOREIGN KEY (storageAnimalProduct_id) REFERENCES storageAnimalProduct(id),
  FOREIGN KEY (storageCulture_id) REFERENCES storageCulture(id),
  FOREIGN KEY (storageAnimal_id) REFERENCES storageAnimal(id)
);

CREATE TABLE goods (
  id SERIAL PRIMARY KEY,
  farmer_id INT,
  name VARCHAR,
  count INT,
  photo VARCHAR,
  FOREIGN KEY (farmer_id) REFERENCES farm(id),
  cost INT
);

CREATE TABLE farmer (
  people_id INT PRIMARY KEY,
  farm_id INT,
  registration_address VARCHAR,
  ekvaer_id INT,
  FOREIGN KEY (people_id) REFERENCES people(id),
  FOREIGN KEY (ekvaer_id) REFERENCES ekvaera(id)
);

CREATE TABLE deal (
  id SERIAL PRIMARY KEY,
  goods_id INT,
  quantity INT,
  buyer_people_id INT,
  cost INT,
  data DATE,
  FOREIGN KEY (goods_id) REFERENCES goods(id),
  FOREIGN KEY (buyer_people_id) REFERENCES people(id)
);

CREATE TABLE buyer (
  people_id INT PRIMARY KEY,
  ekvaer_id INT,
  address VARCHAR,
  FOREIGN KEY (people_id) REFERENCES people(id),
  FOREIGN KEY (ekvaer_id) REFERENCES ekvaera(id)
);
