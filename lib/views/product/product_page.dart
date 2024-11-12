import 'package:ecommerce_shop/controllers/product/product_controller.dart';
import 'package:ecommerce_shop/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class ProductPage extends GetView<ProductController> {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(child: Obx(
          () {
            final product = controller.product.value;
            return CustomScrollView(
              slivers: [
                SliverList(
                    delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(
                          tag: product.id.toString(),
                          child: Image.network(product.image.toString(),
                              height: MediaQuery.of(context).size.height * 0.4,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Center(
                                    child: Icon(
                                      Icons.error_outline,
                                      size: 300,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                              loadingBuilder:
                                  (context, child, loadingProgress) =>
                                      loadingProgress != null
                                          ? const Center(
                                              child: SpinKitWave(
                                              color: Colors.orangeAccent,
                                              size: 50.0,
                                            ))
                                          : child),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    product.title.toString(),
                                    maxLines: 3,
                                    style: theme.textTheme.titleLarge,
                                  ),
                                ),
                              ),
                              Text(
                                "\$${product.price}",
                                style: theme.textTheme.titleLarge,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RatingBarIndicator(
                                rating: product.rating?.rate ?? 1,
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 24.0,
                                direction: Axis.horizontal,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                    '${product.rating?.rate} (${product.rating?.count})'),
                              )
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  product.category.toString().toUpperCase(),
                                  style: theme.textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w400),
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        controller.changeQuantity(
                                            controller.productQuantity.value -
                                                1);
                                      },
                                      icon: const Icon(
                                        Icons.remove_circle,
                                        color: Colors.orange,
                                        size: 32.0,
                                      ),
                                    ),
                                    Obx(() => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                              '${controller.productQuantity.value}',
                                              style: theme.textTheme.bodyLarge),
                                        )),
                                    IconButton(
                                      onPressed: () {
                                        controller.changeQuantity(
                                            controller.productQuantity.value +
                                                1);
                                      },
                                      icon: const Icon(
                                        Icons.add_circle,
                                        color: Colors.orange,
                                        size: 32.0,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              product.description.toString(),
                              textAlign: TextAlign.justify,
                              style: theme.textTheme.bodyLarge,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Obx(() => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                        '\$${(product.price! * controller.productQuantity.value).toStringAsFixed(2)}',
                                        style: theme.textTheme.titleLarge),
                                  )),
                              const Spacer(),
                              InkWell(
                                  onTap: () {
                                    CommonWidgets.showSuccessToast(
                                        'Order Confirmation',
                                        'Successfully Confirm your order');
                                  },
                                  child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24.0, vertical: 16.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          gradient: const LinearGradient(
                                              colors: [
                                                Colors.deepPurpleAccent,
                                                Colors.indigoAccent,
                                                Colors.indigo
                                              ])),
                                      child: const Center(
                                        child: Text(
                                          'Buy Now',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ]))
              ],
            );
          },
        )),
      ),
    );
  }
}
