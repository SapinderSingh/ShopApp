import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders_provider.dart';
import 'package:shop_app/widgets/my_drawer.dart';
import 'package:shop_app/widgets/order_tile.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders-screen';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: MyDrawer(),
      body: orderData.orders.length == 0
          ? Center(
              child: Text('No Orders to display'),
            )
          : ListView.builder(
              itemCount: orderData.orders.length,
              itemBuilder: (_, index) => OrderTile(
                order: orderData.orders[index],
              ),
            ),
    );
  }
}
