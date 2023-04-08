import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import '../providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  //final String title;
  //ProductDetailScreen(this.title);
  static const routeName = "./product-detail";
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    // .....
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);

    return Scaffold(
        appBar: AppBar(
          title: Text(loadedProduct.title),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Center(
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text('\$${loadedProduct.price}',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                )),
            SizedBox(
              height: 10,
            ),
            Container(
                width: double.infinity,
                child: Text(
                  loadedProduct.description,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ))
          ],
        )));
  }
}
