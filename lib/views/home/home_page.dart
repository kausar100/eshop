import 'package:ecommerce_shop/controllers/home/home_controller.dart';
import 'package:ecommerce_shop/models/product_response.dart';
import 'package:ecommerce_shop/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
        child: Scaffold(
      body: Obx(
        () => controller.products.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomScrollView(
                  slivers: [
                    const SliverAppBar(
                        surfaceTintColor: Colors.transparent,
                        floating: true,
                        pinned: true,
                        leading: FlutterLogo(
                          size: 24.0,
                        ),
                        title: TextField(
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          decoration: InputDecoration(
                              isCollapsed: true,
                              contentPadding: EdgeInsets.all(12.0),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                                size: 24.0,
                              ),
                              filled: true,
                              fillColor: Colors.white60,
                              hintText: 'Search...',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                              )),
                        )),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      const SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Categories',
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: controller.categories
                              .map((element) => Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        controller
                                            .changeSelectedProduct(element);
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: controller
                                                          .selectedType.value ==
                                                      element
                                                  ? Colors.blue
                                                  : Colors.white,
                                              border: Border.all(
                                                  color: Colors.black12),
                                              borderRadius:
                                                  BorderRadius.circular(8.0)),
                                          padding: const EdgeInsets.all(12),
                                          child: Text(
                                            element,
                                            style: TextStyle(
                                                color: controller.selectedType
                                                            .value ==
                                                        element
                                                    ? Colors.white
                                                    : Colors.black),
                                          )),
                                    ),
                                  ))
                              .toList()
                              .reversed
                              .toList(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Products',
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                      if (controller.selectedProducts.isNotEmpty)
                        ...controller.selectedProducts
                            .map((product) => ProductListItem(product: product))
                            .toList(),
                      if (controller.selectedType.value == 'ALL')
                        ...controller.products
                            .map((product) => ProductListItem(product: product))
                            .toList(),
                    ]))
                  ],
                ),
              )
            : const Center(
                child: SpinKitWave(
                color: Colors.orangeAccent,
                size: 50.0,
              )),
      ),
    ));
  }
}

class ProductListItem extends StatelessWidget {
  const ProductListItem({super.key, required this.product});

  final Product product;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.PRODUCT, arguments: product.toJson());
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(bottom: 8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12.0)),
        child: Row(
          children: [
            Hero(
              tag: product.id.toString(),
              child: Image.network(
                product.image.toString(),
                height: 100,
                width: 100,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title.toString(),
                      style: theme.textTheme.titleSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Rating: ${product.rating?.rate} (${product.rating?.count})",
                      style: theme.textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                "\$${product.price}",
                style: theme.textTheme.titleSmall,
              ),
            )
          ],
        ),
      ),
    );
  }
}
