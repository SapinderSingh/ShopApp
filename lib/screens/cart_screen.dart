import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/providers/orders_provider.dart';
import 'package:shop_app/widgets/cart_tile.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart-screen';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: cart.itemQuantity == 0
          ? Center(
              child: const Text('No Products Added. Add Some'),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (_, index) => CartTile(
                      title: cart.items.values.toList()[index].title,
                      productId: cart.items.keys.toList()[index],
                      id: cart.items.values.toList()[index].id,
                      price: cart.items.values.toList()[index].price,
                      imageUrl: cart.items.values.toList()[index].imageUrl,
                      quantity: cart.items.values.toList()[index].quantity,
                    ),
                    itemCount: cart.items.length,
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(15),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const Spacer(),
                        Chip(
                          label: Text(
                            '\$ ${cart.totalAmount.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .headline6
                                  .color,
                            ),
                          ),
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        Consumer<OrdersProvider>(
                          builder: (_, order, ch) => FlatButton(
                            child: Text('Order Now'),
                            onPressed: () {
                              order.addOrders(
                                cart.items.values.toList(),
                                cart.totalAmount,
                              );
                              cart.clearCart();
                            },
                            textColor: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
