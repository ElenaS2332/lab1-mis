import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_1/bloc/products_bloc.dart';
import 'package:lab_1/products/product_list_tile.dart';
import 'package:lab_1/products/single_product_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<ProductsBloc>(context).add(
      ProductsInitialLoad(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            '211180',
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: BlocConsumer<ProductsBloc, ProductsState>(
        listener: (BuildContext context, ProductsState state) {
          if (state is ProductsCardSelected) {
            BlocProvider.of<ProductsBloc>(context).add(
              ProductsSelected(state.product),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SingleProductScreen(
                  product: state.product,
                ),
              ),
            );
          }
        },
        buildWhen: (previous, current) => previous is! ProductsLoadSuccess,
        builder: (BuildContext context, ProductsState state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Column(
                  children: [
                    Text(
                      "Online Shopping for the Latest Clothes & Fashion",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    if (state is ProductsLoadSuccess)
                      Column(
                        children: state.products.map(
                          (product) {
                            return ProductListTile(
                              onSelectTap: () {
                                BlocProvider.of<ProductsBloc>(context).add(
                                  ProductsSelected(product),
                                );
                              },
                              name: product.name,
                            );
                          },
                        ).toList(),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
