import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_1/services/products_service.dart';
import 'package:meta/meta.dart';

import '../products/product.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc(ProductsService? productsService) : super(ProductsInitial()) {
    _productsService = productsService ?? ProductsService();
    on<ProductsInitialLoad>(_onProductsInitialLoad);
    on<ProductsSelected>(_onProductsSelect);
    on<SingleProductScreenInitialized>(_onSingleProductScreenInitialized);
  }

  late final ProductsService _productsService;

  Future<void> _onProductsInitialLoad(
    ProductsInitialLoad event,
    Emitter<ProductsState> emit,
  ) async {
    try {
      emit(ProductsLoadInProgress());
      final products = await _productsService.getAllProducts();
      if (products.isEmpty) {
        emit(ProductsLoadFailed());
      } else {
        emit(ProductsLoadSuccess(products));
      }
    } on Exception {
      emit(ProductsLoadFailed());
    } on Error {
      emit(ProductsLoadFailed());
    }
  }

  void _onProductsSelect(
    ProductsSelected event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsCardSelected(event.product));
  }

  void _onSingleProductScreenInitialized(
    SingleProductScreenInitialized event,
    Emitter<ProductsState> emit,
  ) async {
    final product = await _productsService.getProduct(event.productId);

    final newState = SingleProductDetails(
      product: product ??
          const Product(
            id: 0,
            name: '',
            image: '',
            description: '',
            price: 0,
          ),
    );

    emit(newState);
  }
}
