import 'package:flutter/material.dart';
import 'package:login/models/models.dart';
import 'package:login/screens/loading_screen.dart';
import 'package:login/services/services.dart';
import 'package:login/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);

    if (productsService.isLoading) return const LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Producto'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              productsService.selectedProduct =
                  productsService.products[index].copy();
              Navigator.pushNamed(context, 'product');
            },
            child: ProductCard(product: productsService.products[index])),
        itemCount: productsService.products.length,
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            productsService.selectedProduct =
                Product(available: false, name: '', price: 0);
            Navigator.pushNamed(context, 'product');
          }),
    );
  }
}
