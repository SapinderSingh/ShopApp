import 'package:flutter/material.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/product_overview_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Text('Hi'),
          ),
          listTileBuilder(
            ctx: context,
            title: 'Shop',
            iconData: Icons.shop,
            routeName: ProductsOverviewScreen.routeName,
          ),
          Divider(),
          listTileBuilder(
            ctx: context,
            title: 'Orders',
            iconData: Icons.payment,
            routeName: OrdersScreen.routeName,
          ),
          Divider(),
          listTileBuilder(
            ctx: context,
            title: 'Manage Products',
            iconData: Icons.category,
            routeName: UserProductsScreen.routeName,
          ),
        ],
      ),
    );
  }

  InkWell listTileBuilder({
    BuildContext ctx,
    String title,
    IconData iconData,
    String routeName,
  }) {
    return InkWell(
      onTap: () {
        Navigator.of(ctx).pushReplacementNamed(routeName);
      },
      child: ListTile(
        leading: Icon(iconData),
        title: Text(
          title,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
