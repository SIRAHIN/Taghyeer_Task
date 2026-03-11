import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taghyeer_task/core/router/route_manager.dart';
import 'package:taghyeer_task/presentation/bloc/products_cubit/cubit/products_cubit.dart';

class ProductsFragment extends StatefulWidget {
  const ProductsFragment({super.key});

  @override
  State<ProductsFragment> createState() => _ProductsFragmentState();
}

class _ProductsFragmentState extends State<ProductsFragment> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // initial fetch
    context.read<ProductsCubit>().getAllProducts();

    // fetch more
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<ProductsCubit>().getAllProducts();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          "Products",
          style: TextStyle(color: Colors.white, wordSpacing: 14),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox(),
            loading: () => const Center(child: CircularProgressIndicator()),
            success: (products, isLoadingMore) {
              if (products.isEmpty) {
                return const Center(child: Text("No Products Available"));
              }

              return GridView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.65,
                ),
                itemCount: products.length + (isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == products.length) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final product = products[index];

                  return InkWell(
                      onTap: () {
                        context.pushNamed(productDetailsName, extra: product);
                      },
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Product Image
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                                child: Image.network(
                                  product.thumbnail ?? '',
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      const Icon(Icons.image),
                                ),
                              ),
                            ),

                            /// Title
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 6),
                              child: Text(
                                product.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ),

                            /// Price
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                "\$${product.price}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.green,
                                ),
                              ),
                            ),

                            const SizedBox(height: 6),
                          ],
                        ),
                      ));
                },
              );
            },
            error: (errorResponse) => Center(
              child: Text(errorResponse.message ?? "Something went wrong"),
            ),
          );
        },
      ),
    );
  }
}
