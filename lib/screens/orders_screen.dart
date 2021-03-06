import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders_provider.dart';
import 'package:shop_app/widgets/my_drawer.dart';
import 'package:shop_app/widgets/order_tile.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: MyDrawer(),
      body: FutureBuilder(
        future: Provider.of<OrdersProvider>(
          context,
          listen: false,
        ).fetchAndSetOrders(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.error != null) {
              return Center(
                child: Text('Error'),
              );
            } else {
              return Consumer<OrdersProvider>(
                builder: (ctx, orderData, child) => orderData.orders.length == 0
                    ? Center(
                        child: Text('No Orders'),
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
        },
      ),
    );
  }
}
