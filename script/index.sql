-- Index to accelerate search by name in the People table
CREATE INDEX idx_people_name ON people (name);

-- Index to accelerate search by surname in the People table
CREATE INDEX idx_people_surname ON people (surname);

-- Index to accelerate search by type of animal in the Animals table
CREATE INDEX idx_animals_type_animals_id ON animals (type_animals_id);

-- Index to accelerate search by goods in the Deal table
CREATE INDEX idx_deal_goods_id ON deal (goods_id);

-- Index to accelerate search by date in the StorageAnimalProduct table
CREATE INDEX idx_storage_animal_product_data ON storageAnimalProduct (data);

-- Index to accelerate search by culture in the StorageCulture table
CREATE INDEX idx_storage_culture_culture_id ON storageCulture (culture_id);

-- Index to accelerate search by name in the Culture table
CREATE INDEX idx_culture_name ON culture (name);

-- Index to accelerate search by name in the TypeTechnique table
CREATE INDEX idx_type_technique_name ON type_technique (name);
