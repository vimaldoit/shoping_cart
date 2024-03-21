import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:norq/data/models/cart_model.dart';
import 'package:norq/data/models/product_model.dart';
import 'package:norq/ui/common_widget/app_loader.dart';
import 'package:norq/ui/screens/home/home_cubit.dart';
import 'package:norq/utils/colors.dart';
import 'package:norq/utils/validations.dart';
import 'package:sizer/sizer.dart';

class ItemDetailsPage extends StatefulWidget {
  final Product productItem;
  const ItemDetailsPage({super.key, required this.productItem});

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Appcolors.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: CachedNetworkImage(
                          height: 75.w,
                          width: 75.w,
                          imageUrl: widget.productItem.image.toString(),
                          fit: BoxFit.fill,
                          placeholder: (context, url) => SizedBox(
                              height: 40, width: 35, child: AppLoader()),
                          errorWidget: (context, url, error) {
                            return Icon(
                              Icons.image_not_supported,
                              color: Appcolors.hintColor,
                            );
                          }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.productItem.title.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                          color: Appcolors.textColor),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.productItem.description.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 12.sp,
                          color: Appcolors.hintColor),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "₹ " + widget.productItem.price!.toStringAsFixed(2),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                              color: Appcolors.accentColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        RatingBar.builder(
                          itemSize: 25,
                          ignoreGestures: false,
                          initialRating: double.parse(
                              widget.productItem.rating!.rate.toString()),
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Appcolors.accentColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                        color: Appcolors.accentColor)))),
                    onPressed: () {
                      BlocProvider.of<HomeCubit>(context)
                          .addtoCartItemToLocalDB(CartItem(
                              id: widget.productItem.id,
                              title: widget.productItem.title,
                              category: widget.productItem.category,
                              description: widget.productItem.description,
                              image: widget.productItem.image,
                              price: widget.productItem.price,
                              itemCount: 1));
                      Appvalidation.showToast("Cart Added");
                    },
                    child: Text(
                      "Add to cart",
                      style: TextStyle(
                          color: Appcolors.backgroundColor, fontSize: 14.sp),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
