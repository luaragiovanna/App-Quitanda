import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:badges/badges.dart';

import 'package:flutter/material.dart' hide Badge;
import 'package:get/get.dart';
import 'package:quitanda/src/config/custom_colors.dart';
import 'package:quitanda/src/pages/base/controller/navigation_controller.dart';
import 'package:quitanda/src/pages/cart/controller/cart_controller.dart';
import 'package:quitanda/src/pages/home/view/components/category_tile.dart';
import 'package:quitanda/src/pages/home/view/components/item_tile.dart';
import 'package:quitanda/src/pages/home/controller/home_controller.dart';
import 'package:quitanda/src/pages/widgets/app_name_widget.dart';
import 'package:quitanda/src/pages/widgets/custom_shimmer.dart';
import 'package:quitanda/src/services/utils_services.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  //String selectedCategory = 'Fruits';

  GlobalKey<CartIconKey> globalKey = GlobalKey<CartIconKey>();
  //bool isLoading = true;
  final searchController = TextEditingController();

  late Function(GlobalKey) runAddToCartAnimation;
  final navigationController = Get.find<NavigationController>();
  void itemSelectedCartAnimations(GlobalKey gkImage) {
    if (mounted) {
      runAddToCartAnimation(gkImage);
    }
  }

  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 232, 232),
      //APP BAR
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const AppNameWidget(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
              right: 15,
            ),
            child: GetBuilder<CartController>(
                //ao chamar o update, getBUilder é triggado
                builder: (controller) {
              return GestureDetector(
                onTap: () {
                  navigationController.navigatePageView(NavigationTabs.cart);
                },
                child: Badge(
                  badgeStyle: BadgeStyle(
                    badgeColor: newCustomColors.customContrastColor,
                  ),
                  badgeContent: Text(
                    controller.cartItems.length.toString(), //as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  child: AddToCartIcon(
                    key: globalKey,
                    icon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.shopping_cart_rounded),
                      color: newCustomColors.customSwatchColor,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),

      //PESQUISA
      body: AddToCartAnimation(
        gkCart: globalKey,
        previewDuration: const Duration(microseconds: 100),
        previewCurve: Curves.ease,
        receiveCreateAddToCardAnimationMethod: (addToCardAnimationMethod) {
          runAddToCartAnimation = addToCardAnimationMethod;
        },
        child: Column(
          ///componentes um em cima do outro
          children: [
            GetX<HomeController>(
              builder: (controller) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    controller: searchController,
                    onChanged: (value) {
                      controller.searchTitle.value = value;
                    },
                    decoration: InputDecoration(
                        filled: true, //campo vai ser preenchido ou n
                        fillColor: Colors.white,
                        isDense: true,
                        hintText: 'Pesquise aqui....',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade300,
                          fontSize: 14,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: newCustomColors.customContrastColor,
                          size: 21,
                        ),
                        suffixIcon: controller.searchTitle.value.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  //controlar campo de text
                                  searchController.clear();
                                  controller.searchTitle.value = '';
                                  FocusScope.of(context).unfocus();
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: newCustomColors.customContrastColor,
                                  size: 21,
                                ))
                            : null,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(60),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ))),
                  ),
                );
              },
            ),

            //CATEGORIAS
            GetBuilder<HomeController>(
              builder: (controller) {
                return Container(
                  padding: const EdgeInsets.only(left: 25),
                  height: 40,
                  child: !controller.isCategoryLoading
                      ? ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            return CategoryTile(
                              onPressed: () {
                                controller.selectCategory(
                                    controller.allCategories[index]);
                                print(controller.allCategories);
                              },
                              category: controller.allCategories[index].title,
                              isSelected: controller.allCategories[index] ==
                                  controller.currentCategory,
                            );
                          },
                          separatorBuilder: (_, index) =>
                              const SizedBox(width: 10),
                          itemCount: controller.allCategories.length,
                        )
                      : ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                            10,
                            (index) => Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(right: 12),
                              child: CustomShimmer(
                                height: 20,
                                width: 80,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                );
              },
            ),

            GetBuilder<HomeController>(
              builder: (controller) {
                return Expanded(
                  child: !controller.isProductLoading
                      ? Visibility(
                          //interruptor
                          visible: (controller.currentCategory?.items ?? [])
                              .isNotEmpty,

                          replacement: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off_outlined,
                                size: 40,
                                color: newCustomColors.customSwatchColor,
                              ),
                              const Text('Não há itens para apresentar'),
                            ],
                          ),
                          child: GridView.builder(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 9 / 11.5,
                            ),
                            itemCount: controller.allProducts.length,
                            itemBuilder: (_, index) {
                              //logica define se ta no ultimo item, busca mais
                              if (index + 1 == controller.allProducts.length) {
                                if (!controller.isLastPage) {
                                  controller.loadMoreProducts();
                                }
                              }
                              return ItemTile(
                                  item: controller.allProducts[index],
                                  cartAnimationMethod:
                                      itemSelectedCartAnimations);
                            },
                          ),
                        )
                      : GridView.count(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          physics: const BouncingScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 9 / 11.5,
                          children: List.generate(
                            10,
                            (index) => CustomShimmer(
                              height: double.infinity,
                              width: double.infinity,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
