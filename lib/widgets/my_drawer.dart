import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
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
          const Divider(),
          listTileBuilder(
            ctx: context,
            title: 'Orders',
            iconData: Icons.payment,
            routeName: OrdersScreen.routeName,
          ),
          const Divider(),
          listTileBuilder(
            ctx: context,
            title: 'Manage Products',
            iconData: Icons.category,
            routeName: UserProductsScreen.routeName,
          ),
          const Divider(),
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logout();
            },
            child: ListTile(
              leading: Icon(
                Icons.logout,
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InkWell listTileBuilder(
      {BuildContext ctx,
      String title,
      IconData iconData,
      String routeName,
      Function onTap}) {
    return InkWell(
      onTap: () {
        if (routeName != null)
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
