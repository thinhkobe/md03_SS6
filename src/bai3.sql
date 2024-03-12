
create database shoping_management;
use shoping_management;
create table users(
                      id int primary key auto_increment,
                      name varchar(50),
                      address varchar(255),
                      phone varchar(11),
                      dataOfBirth datetime,
                      status bit
);
create table products(
                         id_product int primary key auto_increment,
                         product_name varchar(50),
                         price double,
                         stock int,
                         status bit
);

create table shopping_cart(
                              id_cart int primary key  auto_increment,
                              user_id int,
                              product_id int,
                              foreign key (user_id)references users(id),
                              foreign key (product_id)references products(id_product),
                              quantity int,
                              amount double
);
DELIMITER //
CREATE TRIGGER update_amount_trigger
    AFTER UPDATE ON products
    FOR EACH ROW
BEGIN
    UPDATE shopping_cart
    SET amount = NEW.price * quantity
    WHERE product_id = NEW.id_product;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER delete_from_shopping_cart_trigger
    AFTER DELETE ON products
    FOR EACH ROW
BEGIN
    DELETE FROM shopping_cart
    WHERE product_id = OLD.id_product;
END //
DELIMITER ;
DELIMITER //
CREATE TRIGGER reduce_product_quantity_trigger
    AFTER INSERT ON shopping_cart
    FOR EACH ROW
BEGIN
    UPDATE products
    SET stock = stock - NEW.quantity
    WHERE id_product = NEW.product_id;
END //
DELIMITER ;

drop trigger reduce_pro_QTY;
delimiter //
create trigger reduce_pro_QTY
    after update on shopping_cart
    for each row
    begin
        update products
            set stock=stock+OLD.quantity-NEW.quantity
        where id_product=NEW.product_id;
    end //
delimiter ;


INSERT INTO users (name, address, phone, dataOfBirth, status)
VALUES
    ('John Doe', '123 Main St', '1234567890', '1990-01-15', 1),
    ('Jane Smith', '456 Oak St', '9876543210', '1985-05-20', 1)

;
INSERT INTO products (product_name, price, stock, status)
VALUES
    ('Product A', 29.99, 50, 1),
    ('Product B', 49.99, 30, 1)

;
-- Lấy user_id và product_id từ bảng users và products
INSERT INTO shopping_cart (user_id, product_id, quantity, amount)
VALUES
    (1, 1, 2, 29.99),
    (2, 2, 1, 49.99)

;


