part of 'products_bloc.dart';

@immutable
sealed class ProductsState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class ProductsInitial extends ProductsState {}

final class ProductsLoadFailed extends ProductsState {}

final class ProductsLoadInProgress extends ProductsState {}

final class ProductsLoadSuccess extends ProductsState {
  ProductsLoadSuccess(this.products);

  final List<Product> products;

  @override
  List<Object?> get props => [products];
}

final class ProductsCardSelected extends ProductsState {
  ProductsCardSelected(
    this.product,
  );

  final Product product;

  @override
  List<Object?> get props => [product.id];
}

final class SingleProductDetails extends ProductsState {
  SingleProductDetails({
    required this.product,
  });

  final Product product;

  @override
  List<Object?> get props => [product.id];
}
