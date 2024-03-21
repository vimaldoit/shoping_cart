import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:norq/service/sqlite_service.dart';
import 'package:norq/ui/common_widget/app_loader.dart';
import 'package:norq/ui/screens/cart/cart_cubit.dart';
import 'package:norq/utils/colors.dart';
import 'package:norq/utils/validations.dart';
import 'package:sizer/sizer.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    BlocProvider.of<CartCubit>(context).getCartItemfromLocalDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Appcolors.backgroundColor,
        title: Text("Cart"),
      ),
      body: Container(
        child: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            if (state is Cartfailure) {
              Appvalidation.showToast(state.error.toString());
            }
            if (state is CartDelete) {
              Appvalidation.showToast("Item Removed");
              BlocProvider.of<CartCubit>(context).getCartItemfromLocalDB();
            }
            if (state is CartCountUpadte) {
              BlocProvider.of<CartCubit>(context).getCartItemfromLocalDB();
            }
          },
          builder: (context, state) {
            if (state is CartLoading) {
              return AppLoader();
            }
            if (state is CartSuccess) {
              var totalAMT = 0.0;
              var cartData = state.cartData;
              for (int i = 0; i < cartData.length; i++) {
                totalAMT = totalAMT +
                    (double.parse(cartData[i].price.toString()) *
                        double.parse(cartData[i].itemCount.toString()));
              }

              return cartData.length > 0
                  ? Column(
                      children: [
                        Expanded(
                            child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: cartData.length,
                          itemBuilder: (context, index) {
                            var item = cartData[index];

                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  Card(
                                    elevation: 0,
                                    color: Appcolors.backgroundColor,
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                              width: double.infinity,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      CachedNetworkImage(
                                                          height: 15.w,
                                                          width: 15.w,
                                                          imageUrl: item.image
                                                              .toString(),
                                                          fit: BoxFit.fill,
                                                          placeholder: (context,
                                                                  url) =>
                                                              SizedBox(
                                                                  height: 15.w,
                                                                  width: 15.w,
                                                                  child:
                                                                      AppLoader()),
                                                          errorWidget: (context,
                                                              url, error) {
                                                            return Icon(
                                                              Icons
                                                                  .image_not_supported,
                                                              color: Appcolors
                                                                  .hintColor,
                                                            );
                                                          }),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          item.title.toString(),
                                                          style: TextStyle(
                                                              fontSize: 12.sp,
                                                              color: Appcolors
                                                                  .textColor),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          InkWell(
                                                            onTap:
                                                                item.itemCount! >
                                                                        1
                                                                    ? () {
                                                                        BlocProvider.of<CartCubit>(context).updateItemCount(
                                                                            item
                                                                                .id!,
                                                                            item.itemCount! -
                                                                                1);
                                                                      }
                                                                    : () {},
                                                            child: Container(
                                                              width: 25,
                                                              height: 25,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(2),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50),
                                                                  border: Border.all(
                                                                      color: Appcolors
                                                                          .accentColor)),
                                                              child: Text(
                                                                "-",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        2),
                                                            child: Text(item
                                                                .itemCount
                                                                .toString()),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              BlocProvider.of<
                                                                          CartCubit>(
                                                                      context)
                                                                  .updateItemCount(
                                                                      item.id!,
                                                                      item.itemCount! +
                                                                          1);
                                                            },
                                                            child: Container(
                                                              width: 25,
                                                              height: 25,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(2),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50),
                                                                  border: Border.all(
                                                                      color: Appcolors
                                                                          .accentColor)),
                                                              child: Text(
                                                                "+",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Spacer(),
                                                      Text(
                                                        "₹" +
                                                            (double.parse(item
                                                                        .price
                                                                        .toString()) *
                                                                    double.parse(item
                                                                        .itemCount
                                                                        .toString()))
                                                                .toStringAsFixed(
                                                                    2),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12.sp,
                                                            color: Appcolors
                                                                .textColor),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: InkWell(
                                            onTap: () {
                                              BlocProvider.of<CartCubit>(
                                                      context)
                                                  .deleteItemFromDB(item.id!);
                                            },
                                            child: Icon(
                                              Icons.delete_outline,
                                              color: Appcolors.accentColor,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider()
                                ],
                              ),
                            );
                          },
                        )),
                        Align(
                            alignment: FractionalOffset.bottomCenter,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.green.shade50,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "PRICE DETAILS",
                                    style: TextStyle(
                                        color: Appcolors.accentColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Divider(
                                    color: Appcolors.hintColor,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Total Amount:",
                                        style: TextStyle(
                                            color: Appcolors.hintColor,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      Text(
                                        "₹" + totalAMT.toStringAsFixed(2),
                                        style: TextStyle(
                                            color: Appcolors.textColor,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Appcolors.accentColor),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18.0),
                                                    side: BorderSide(
                                                        color: Appcolors
                                                            .accentColor)))),
                                        onPressed: () {},
                                        child: Text(
                                          "Place order",
                                          style: TextStyle(
                                              color: Appcolors.backgroundColor,
                                              fontSize: 14.sp),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ))
                      ],
                    )
                  : Center(
                      child: Text("No Data",
                          style: TextStyle(
                              color: Appcolors.textColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold)),
                    );
            }
            return Center(
              child: Text("No Data",
                  style: TextStyle(
                      color: Appcolors.textColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold)),
            );
          },
        ),
      ),
    );
  }
}
