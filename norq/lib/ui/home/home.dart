import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:norq/ui/common_widget/app_loader.dart';
import 'package:norq/ui/home/home_cubit.dart';
import 'package:norq/utils/colors.dart';
import 'package:norq/utils/validations.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        title: Text(
          "Shop",
          style: TextStyle(color: Appcolors.accentColor),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is HomePageFailure) {
              Appvalidation.showToast(state.error.toString());
            }
          },
          builder: (context, state) {
            if (state is HomePageLoading) {
              return AppLoader();
            }
            if (state is HomePageSuccess) {
              var productData = state.productdata;
              return GridView.extent(
                maxCrossAxisExtent: 200.0, // maximum item width
                mainAxisSpacing: 8.0, // spacing between rows
                crossAxisSpacing: 8.0, // spacing between columns
                padding: EdgeInsets.all(8.0), // padding around the grid
                children: productData.map((item) {
                  return Container(
                    padding: EdgeInsets.all(8),
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
                          child: SizedBox(
                            height: 25.w,
                            width: 25.w,
                            child: Image.network(
                              item.image.toString(),
                              height: 132,
                            ),
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
                              overflow: TextOverflow.ellipsis,
                              "₹" + item.price.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                  color: Appcolors.textColor),
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
