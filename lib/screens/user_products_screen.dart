import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/widgets/my_drawer.dart';
import 'package:shop_app/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products-screen';

  Future<void> _refreshProducts(BuildContext ctx) async {
    await Provider.of<ProductsProvider>(ctx, listen: false)
        .fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Consumer<ProductsProvider>(
          builder: (_, productsData, ch) => ListView.separated(
            itemCount: productsData.items.length,
            separatorBuilder: (_, i) => Divider(),
            itemBuilder: (_, index) => UserProductItem(
              id: productsData.items[index].id,
              title: productsData.items[index].title,
              imageUrl: productsData.items[index].imageUrl,
              deleteProduct: productsData.deleteProduct,
            ),
          ),
        ),
      ),
    );
  }
}
