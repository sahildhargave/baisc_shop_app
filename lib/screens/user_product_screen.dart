import 'package:flutter/material.dart';
import 'package:shop/screens/edit_product_screen.dart';
import "../providers/products.dart";
import 'package:provider/provider.dart';
import '../wedgets/app_drawer.dart';
import "../wedgets/user_product_item.dart";

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-products';
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Products",
            style: TextStyle(
              fontSize: 21,
            )),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsData.items.length,
          itemBuilder: (_, i) => Column(
            children: [
              UserProductItem(
                productsData.items[i].title,
                productsData.items[i].imageUrl,
                productsData.items[i].id!,
              ),
              const Divider(),
              //const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
