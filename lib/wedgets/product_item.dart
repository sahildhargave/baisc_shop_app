// ignore_for_file: unused_local_variable

import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../screens/product_detail_screen.dart';

import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  //final String id;
  //final String title;
  //final String imageUrl;
  //ProductItem(this.id, this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    print("product rebuild");
    return Consumer<Product>(
        builder: (ctx, product, child) => ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GridTile(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    ProductDetailScreen.routeName,
                    arguments: product.id,
                  );
                },
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              footer: GridTileBar(
                backgroundColor: Colors.black.withOpacity(0.3),
                leading: Consumer<Product>(
                  builder: (ctx, product, _) => IconButton(
                    icon: Icon(product.isFavourite
                        ? Icons.favorite
                        : Icons.favorite_border),
                    color: Theme.of(context).hintColor,
                    onPressed: () {
                      product.toggleFavouriteStatus();
                    },
                  ),
                  child: const Text("Never changes!"),
                ),
                title: Text(
                  product.title,
                  textAlign: TextAlign.center,
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    cart.addItem(product.id!, product.price, product.title);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text(
                          "Added item to cart",
                          textAlign: TextAlign.center,
                        ),
                        duration: const Duration(seconds: 1),
                        action: SnackBarAction(
                            label: 'UNDO',
                            onPressed: () {
                              cart.removeSingleItem(product.id!);
                            })));
                  },
                  color: Theme.of(context).hintColor,
                ),
              ),
            )));
  }
}
