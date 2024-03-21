import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:norq/data/models/cart_model.dart';
import 'package:norq/data/models/product_model.dart';
import 'package:norq/data/repositories/user_repository.dart';
import 'package:norq/ui/common_widget/app_loader.dart';
import 'package:norq/ui/screens/cart/cart.dart';
import 'package:norq/ui/screens/cart/cart_cubit.dart';
import 'package:norq/ui/screens/home/home_cubit.dart';
import 'package:norq/ui/screens/home/item_details.dart';
import 'package:norq/ui/screens/login/login.dart';
import 'package:norq/ui/screens/login/login_cubit.dart';
import 'package:norq/utils/colors.dart';
import 'package:norq/utils/validations.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  handleClick(item) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => LoginCubit(UserRespository()),
            child: const LoginPage(),
          ),
        ),
        (route) => false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<HomeCubit>(context).getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Appcolors.backgroundColor,
        title: const Text(
          "Shop",
          style: TextStyle(color: Appcolors.textColor),
        ),
        actions: [
          InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => CartCubit(),
                    child: const CartPage(),
                  ),
                )),
            child: const Icon(
              Icons.shopping_cart,
              color: Appcolors.accentColor,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          PopupMenuButton<int>(
            onSelected: (item) => handleClick(item),
            color: Appcolors.backgroundColor,
            itemBuilder: (context) => [
              const PopupMenuItem<int>(value: 0, child: Text('Logout')),
            ],
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is HomePageFailure) {
              Appvalidation.showToast(state.error.toString());
            }
          },
          builder: (context, state) {
            if (state is HomePageLoading) {
              return const AppLoader();
            }
            if (state is HomePageSuccess) {
              var productData = state.productdata;
              return GridView.extent(
                childAspectRatio: (1 / 1.2),
                maxCrossAxisExtent: 200.0, // maximum item width
                mainAxisSpacing: 8.0, // spacing between rows
                crossAxisSpacing: 8.0, // spacing between columns
                //   padding: EdgeInsets.all(8.0), // padding around the grid
                children: productData.map((item) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Appcolors.hintColor, width: 0.5),
                        borderRadius: BorderRadius.circular(4)),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              //color: secondaryColorlight,

                              borderRadius: BorderRadius.circular(4)),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                      create: (context) =>
                                          HomeCubit(UserRespository()),
                                      child: ItemDetailsPage(productItem: item),
                                    ),
                                  ));
                            },
                            child: CachedNetworkImage(
                                height: 25.w,
                                width: 25.w,
                                imageUrl: item.image.toString(),
                                fit: BoxFit.fill,
                                placeholder: (context, url) => SizedBox(
                                    height: 25.w,
                                    width: 25.w,
                                    child: const AppLoader()),
                                errorWidget: (context, url, error) {
                                  return const Icon(
                                    Icons.image_not_supported,
                                    color: Appcolors.hintColor,
                                  );
                                }),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              overflow: TextOverflow.ellipsis,
                              item.title.toString(),
                              style: TextStyle(
                                  fontSize: 12.sp, color: Appcolors.textColor),
                            ),
                            Text(
                              "₹" + item.price.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                  color: Appcolors.textColor),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 30,
                              // width: double.infinity,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Appcolors.accentColor),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              side: const BorderSide(
                                                  color:
                                                      Appcolors.accentColor)))),
                                  onPressed: () {
                                    BlocProvider.of<HomeCubit>(context)
                                        .addtoCartItemToLocalDB(CartItem(
                                            id: item.id,
                                            title: item.title,
                                            category: item.category,
                                            description: item.description,
                                            image: item.image,
                                            price: item.price,
                                            itemCount: 1));
                                    Appvalidation.showToast("Cart Added");
                                  },
                                  child: Text(
                                    "Add to cart",
                                    style: TextStyle(
                                        color: Appcolors.backgroundColor,
                                        fontSize: 10.sp),
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                }).toList(),
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
