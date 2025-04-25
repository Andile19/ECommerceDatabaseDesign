-- Base SQL script for the e-commerce database schema
-- Brand Table 
CREATE TABLE `brand` (
  `brand_id` integer PRIMARY KEY,
  `name` varchar(255) NOT NULL,
  `logo_url` varchar(255),
  `description` text
);

-- Product Category Table
CREATE TABLE `product_category` (
  `category_id` integer PRIMARY KEY,
  `name` varchar(255) NOT NULL,
  `description` text,
  `parent_category_id` integer
);

-- Color Table
CREATE TABLE `color` (
  `color_id` integer PRIMARY KEY,
  `name` varchar(255) NOT NULL,
  `hex_code` varchar(255) NOT NULL
);

-- Size Category Table
-- This table defines the size options for products (e.g., clothing, shoes)
CREATE TABLE `size_category` (
  `size_category_id` integer PRIMARY KEY,
  `name` varchar(255) NOT NULL,
  `description` varchar(255)
);

-- Size Option Table
-- such as "Small", "Medium", "Large", etc.
CREATE TABLE `size_option` (
  `size_id` integer PRIMARY KEY,
  `size_category_id` integer NOT NULL,
  `name` varchar(255) NOT NULL,
  `measurement` varchar(255)
);

-- Attribute Category Table
-- such as "Material", "Warranty", etc.
CREATE TABLE `attribute_category` (
  `attribute_category_id` integer PRIMARY KEY,
  `name` varchar(255) NOT NULL,
  `description` varchar(255)
);

-- Attribute Type Table
-- This table defines the type of attributes (e.g., text, number, date)
CREATE TABLE `attribute_type` (
  `attribute_type_id` integer PRIMARY KEY,
  `name` varchar(255) NOT NULL,
  `data_type` varchar(255) NOT NULL
);

-- Product Table
CREATE TABLE `product` (
  `product_id` integer PRIMARY KEY,
  `category_id` integer NOT NULL,
  `brand_id` integer NOT NULL,
  `name` varchar(255) NOT NULL,
  `base_price` decimal NOT NULL,
  `description` text,
  `created_at` timestamp,
  `updated_at` timestamp
);

-- Product Item Table
-- This table stores individual items of a product, including SKU and stock quantity
CREATE TABLE `product_item` (
  `item_id` integer PRIMARY KEY,
  `product_id` integer NOT NULL,
  `price` decimal NOT NULL,
  `SKU` varchar(255) UNIQUE NOT NULL,
  `quantity_in_stock` integer NOT NULL DEFAULT 0
);

-- Product Attribute Table
-- This table stores additional attributes for products, such as "Material", "Warranty", etc.
CREATE TABLE `product_attribute` (
  `attribute_id` integer PRIMARY KEY,
  `product_id` integer NOT NULL,
  `attribute_category_id` integer NOT NULL,
  `attribute_type_id` integer NOT NULL,
  `attribute_value` text NOT NULL
);

-- Product Variation Table
-- This table stores variations of a product, such as different sizes and colors
CREATE TABLE `product_variation` (
  `variation_id` integer PRIMARY KEY,
  `product_id` integer NOT NULL,
  `item_id` integer NOT NULL,
  `size_id` integer,
  `color_id` integer
);

-- Product Image Table
-- This table stores images for products and their variations
CREATE TABLE `product_image` (
  `image_id` integer PRIMARY KEY,
  `product_id` integer,
  `item_id` integer,
  `url` varchar(255) NOT NULL,
  `alt_text` varchar(255),
  `display_order` integer DEFAULT 0
);

ALTER TABLE `product_category` ADD FOREIGN KEY (`parent_category_id`) REFERENCES `product_category` (`category_id`);

ALTER TABLE `product` ADD FOREIGN KEY (`category_id`) REFERENCES `product_category` (`category_id`);

ALTER TABLE `product` ADD FOREIGN KEY (`brand_id`) REFERENCES `brand` (`brand_id`);

ALTER TABLE `product_item` ADD FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

ALTER TABLE `size_option` ADD FOREIGN KEY (`size_category_id`) REFERENCES `size_category` (`size_category_id`);

ALTER TABLE `product_attribute` ADD FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

ALTER TABLE `product_attribute` ADD FOREIGN KEY (`attribute_category_id`) REFERENCES `attribute_category` (`attribute_category_id`);

ALTER TABLE `product_attribute` ADD FOREIGN KEY (`attribute_type_id`) REFERENCES `attribute_type` (`attribute_type_id`);

ALTER TABLE `product_variation` ADD FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

ALTER TABLE `product_variation` ADD FOREIGN KEY (`item_id`) REFERENCES `product_item` (`item_id`);

ALTER TABLE `product_variation` ADD FOREIGN KEY (`size_id`) REFERENCES `size_option` (`size_id`);

ALTER TABLE `product_variation` ADD FOREIGN KEY (`color_id`) REFERENCES `color` (`color_id`);

ALTER TABLE `product_image` ADD FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

ALTER TABLE `product_image` ADD FOREIGN KEY (`item_id`) REFERENCES `product_item` (`item_id`);
