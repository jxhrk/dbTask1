CREATE DATABASE lab_equipment;
GO

USE lab_equipment;
GO

CREATE TABLE disciplines (
    discipline_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL
);
GO

--категория согласно приказу
CREATE TABLE equipment_categories (
    category_id INT IDENTITY(1,1) PRIMARY KEY,
    code NVARCHAR(20) NOT NULL, --номер категории согласно приказу
    name NVARCHAR(100) NOT NULL --название категории согласно приказу
);
GO

--подкатегория, указывающая, является ли оборудование основным или дополнительным
CREATE TABLE equipment_subcategories (
    subcategory_id INT IDENTITY(1,1) PRIMARY KEY,
    category_id INT,
    is_mandatory BIT DEFAULT 1, --1 - основное; 0 - дополнительное
    FOREIGN KEY (category_id) REFERENCES equipment_categories(category_id) ON DELETE NO ACTION
);
GO

CREATE TABLE manufacturers (
    manufacturer_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL UNIQUE,
    website NVARCHAR(200)
);
GO

CREATE TABLE equipments (
    equipment_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(200) NOT NULL,
    model NVARCHAR(100),
    subcategory_id INT NOT NULL,
    manufacturer_id INT NOT NULL,
    discipline_id INT NOT NULL,
    serial_number NVARCHAR(100) UNIQUE,
    inventory_number NVARCHAR(50) UNIQUE,
    cost DECIMAL(12,2),
    currency NVARCHAR(3),
    warranty_months INT,
    info_url NVARCHAR(MAX),
    FOREIGN KEY (subcategory_id) REFERENCES equipment_subcategories(subcategory_id) ON DELETE NO ACTION,
    FOREIGN KEY (manufacturer_id) REFERENCES manufacturers(manufacturer_id) ON DELETE NO ACTION,
    FOREIGN KEY (discipline_id) REFERENCES disciplines(discipline_id) ON DELETE NO ACTION
);
GO

CREATE TABLE infrastructure_requirements (
    infrastructure_requirement_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    description NVARCHAR(100),
    equipment_id INT NOT NULL,
    FOREIGN KEY (equipment_id) REFERENCES equipments(equipment_id) ON DELETE NO ACTION
);
GO

CREATE TABLE safety_requirements (
    safety_requirement_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    description NVARCHAR(100),
    equipment_id INT NOT NULL,
    FOREIGN KEY (equipment_id) REFERENCES equipments(equipment_id) ON DELETE NO ACTION
);
GO

CREATE TABLE tech_specs (
    tech_spec_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    description NVARCHAR(100),
    equipment_id INT NOT NULL,
    FOREIGN KEY (equipment_id) REFERENCES equipments(equipment_id) ON DELETE NO ACTION
);

GO

