import 'package:quitanda/src/models/cart_item_model.dart';
import 'package:quitanda/src/models/item_model.dart';
import 'package:quitanda/src/models/order_model.dart';
import 'package:quitanda/src/models/user_model.dart';

ItemModel apple = ItemModel(
  description: "Apple from Brazil.",
  imgUrl: 'assets/fruits/img2.png',
  itemName: 'Apple',
  price: 9.0,
  unit: 'kg',
);
ItemModel kiwi = ItemModel(
  description: "This is a Kiwi. Buy it!",
  imgUrl: 'assets/fruits/kiwi.jpeg',
  itemName: 'Kiwi',
  price: 4.0,
  unit: 'un',
);
ItemModel mango = ItemModel(
  description: "Sweet Mango, buy it!",
  imgUrl: 'assets/fruits/mango.jpeg',
  itemName: 'Mango',
  price: 14.0,
  unit: 'kg',
);
ItemModel grape = ItemModel(
  description: "Green Grape from Brazil",
  imgUrl: 'assets/fruits/greenGrapes.jpeg',
  itemName: 'Grape',
  price: 12.0,
  unit: 'kg',
);

List<ItemModel> items = [
  apple,
  kiwi,
  mango,
  grape,
];

List<String> categories = ['Fruits', 'Vegetables', 'Cereais', 'Meat'];

//lsitas itens do carrinho
List<CartItemModel> cartItems = [
  CartItemModel(item: mango, quantity: 2, id: ''),
  CartItemModel(item: kiwi, quantity: 1, id: '')
];

UserModel user = UserModel(
    //   name: 'John Doe',
    email: 'john.doe@hotmail.com',
    phone: '55 11 9 9999-1111',
    cpf: '100.123.456-99',
    password: 'password',
    id: '1',
    token: '123token');

List<OrderModel> orders = [];
