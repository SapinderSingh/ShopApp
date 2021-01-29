import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';

class CartTile extends StatelessWidget {
  final String id, imageUrl, title, productId;
  final double price;
  final int quantity;

  const CartTile({
    this.productId,
    this.id,
    this.imageUrl,
    this.title,
    this.price,
    this.quantity,
  });
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (direction) => showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          content: Text(
            'Do you want to remove the item from the cart ?',
          ),
          title: Text('Are you sure ?'),
          actions: [
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(ctx).pop(false);
              },
            ),
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(ctx).pop(true);
              },
            ),
          ],
        ),
      ),
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          size: 40,
          color: Colors.white,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        Provider.of<CartProvider>(context, listen: false).deleteItem(productId);
      },
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: 200,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Price: \$${price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, fontFamily: 'Anton'),
                  ),
                  Text(quantity == 1 ? '' : 'Total Price: ${quantity * price}')
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Qty: $quantity',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
