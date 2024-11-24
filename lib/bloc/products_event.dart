part of 'products_bloc.dart';

@immutable
sealed class ProductsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductsSelected extends ProductsEvent {
  ProductsSelected(this.product);
  final Product product;

  @override
  List<Object?> get props => [product.id];
}

class ProductsInitialLoad extends ProductsEvent {
  ProductsInitialLoad();
}

class SingleProductScreenInitialized extends ProductsEvent {
  SingleProductScreenInitialized({required this.productId});
  final int productId;
}
