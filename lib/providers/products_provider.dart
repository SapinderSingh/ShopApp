import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shop_app/models/http_exception.dart';

class ProductModel with ChangeNotifier {
  final String id, title, description, imageUrl;
  final double price;
  bool isFavorite;

  ProductModel({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    @required this.price,
    this.isFavorite = false,
  });

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}

class ProductsProvider with ChangeNotifier {
  List<ProductModel> _items = [
    // ProductModel(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://images-na.ssl-images-amazon.com/images/I/61FFyFD1coL._UL1440_.jpg',
    // ),
    // ProductModel(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYlJajFcf662hF4mbCZkS8YK08MnVPp_yyrA&usqp=CAU',
    // ),
    // ProductModel(
    //   id: 'p3',
    //   title: 'Range Rover Autobiography',
    //   description: 'My Favorite car',
    //   price: 200000,
    //   imageUrl: 'https://i.ytimg.com/vi/5GMNPaZbgaU/maxresdefault.jpg',
    // ),
    // ProductModel(
    //   id: 'p4',
    //   title: 'Intex Speakers',
    //   price: 100,
    //   description: 'Intex Tower Speakers',
    //   imageUrl:
    //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRXhsST_Of2YI8pErwI0mEiEe04piYwn8HuQ&usqp=CAU',
    // ),
    // ProductModel(
    //   id: 'p5',
    //   title: 'Royal Enfield Bullet',
    //   price: 1500,
    //   description: 'Best Bike Ever',
    //   imageUrl:
    //       'https://imgd.aeplcdn.com/476x268/bw/models/royal-enfield-bullet-350-ks--x--efi-bs-vi20200401130113.jpg',
    // ),
    // ProductModel(
    //   id: 'p6',
    //   title: 'Pistol',
    //   price: 1000,
    //   description: 'Pistol',
    //   imageUrl:
    //       'https://images-na.ssl-images-amazon.com/images/I/51NqKMBzYpL._AC_SL1000_.jpg',
    // ),
    // ProductModel(
    //   id: 'p7',
    //   title: 'Fifty Shades Of Grey',
    //   price: 20,
    //   description:
    //       'Fifty Shades of Grey is a 2011 erotic romance novel by British author E. L. James. It became the first instalment in the Fifty Shades novel series that follows the deepening relationship between a college graduate, Anastasia Steele, and a young business magnate, Christian Grey.',
    //   imageUrl:
    //       'https://images-na.ssl-images-amazon.com/images/I/810BkqRP+iL.jpg',
    // ),
    // ProductModel(
    //   id: 'p8',
    //   title: 'Bahubali 2',
    //   price: 10,
    //   description: 'A South Indian Superhit movie',
    //   imageUrl:
    //       'https://www.filmibeat.com/ph-big/2017/05/baahubali-2-the-conclusion_149577721630.jpg',
    // ),
    // ProductModel(
    //   id: 'p9',
    //   title: 'Gaming PC',
    //   price: 10000,
    //   description: 'One of the best gaming pc in the world',
    //   imageUrl:
    //       'https://thumbor.forbes.com/thumbor/711x711/https://blogs-images.forbes.com/antonyleather/files/2017/01/OrionX_Side_open-1200x1200.jpg?width=960',
    // ),
    // ProductModel(
    //   id: 'p10',
    //   title: 'A big House',
    //   price: 1000000,
    //   description: 'A very big house',
    //   imageUrl:
    //       'https://loveincorporated.blob.core.windows.net/contentimages/gallery/8f84c0b0-5d58-45f7-9276-593c88ea6f13-million-dollar-homes-around-world.jpg',
    // ),
    // ProductModel(
    //   id: 'p11',
    //   title: 'Private Jet',
    //   price: 200000,
    //   description: 'Embraer Phenom 100',
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/f/f1/Embraer_EMB-500_Phenom_100_AN1695056.jpg',
    // ),
    // ProductModel(
    //   id: 'p12',
    //   title: 'Golden Chain',
    //   price: 5500,
    //   description: 'A golden chain',
    //   imageUrl:
    //       'https://i.pinimg.com/originals/4e/7e/ca/4e7eca618e1ca016a5c7d94fae4ac4f7.jpg',
    // ),
    // ProductModel(
    //   id: 'p13',
    //   title: 'Restaurant',
    //   price: 450000,
    //   description: 'A 5 Star Hotel',
    //   imageUrl:
    //       'https://d4t7t8y8xqo0t.cloudfront.net/resized/750X436/eazytrendz%2F2142%2Ftrend20181215042700.jpg',
    // ),
    // ProductModel(
    //   id: 'p14',
    //   price: 250000,
    //   title: 'Yacht',
    //   description: 'My Yacht',
    //   imageUrl:
    //       'https://static01.nyt.com/images/2020/03/07/business/07wealth-01/06wealth-01-mediumSquareAt3X.jpg',
    // ),
    // ProductModel(
    //   id: 'p15',
    //   price: 1500000,
    //   title: 'Private Island',
    //   description: 'A Private Island',
    //   imageUrl:
    //       'https://cdn-image.departures.com/sites/default/files/1586391555/header-song-saa-resort-cambodia-LA20ISLANDS0420.jpg',
    // ),
  ];

  List<ProductModel> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  List<ProductModel> get items {
    return [..._items];
  }

  ProductModel findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  Future<void> fetchAndSetProducts() async {
    const url =
        'https://shop-app-8b3b1-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<ProductModel> loadedProducts = [];
      extractedData.forEach(
        (prodId, prodData) {
          loadedProducts.add(
            ProductModel(
              id: prodId,
              description: prodData['description'],
              title: prodData['title'],
              price: prodData['price'],
              isFavorite: prodData['isFavorite'],
              imageUrl: prodData['imageUrl'],
            ),
          );
        },
      );
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(ProductModel product) async {
    const url =
        'https://shop-app-8b3b1-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFavorite': product.isFavorite,
          },
        ),
      );
      final newProduct = ProductModel(
        title: product.title,
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, ProductModel newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://shop-app-8b3b1-default-rtdb.firebaseio.com/products/$id.json';
      await http.patch(
        url,
        body: json.encode(
          {
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
          },
        ),
      );
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://shop-app-8b3b1-default-rtdb.firebaseio.com/products/$id.json';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete products');
    }
    existingProduct = null;
  }
}
