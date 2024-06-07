import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:razco_foods/helper/network_image.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_icon.dart';
import 'package:razco_foods/view/widgets/custom_image/custom_image.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
      {super.key,
      required this.image,
      required this.title,
      required this.price,
      required  this.oldPrice,
      required this.quantity,
      this.paddingRight = 10,
      this.showOffer = false,
      required this.bookMark,
        this.onTapCard,
      this.percentagePrice = 10});

  final String image;
  final String title;
  final int price;
  final Widget oldPrice;
  final String quantity;
  final int percentagePrice;

  final double paddingRight;

  final bool showOffer;
  final Widget bookMark;
  final VoidCallback? onTapCard;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: paddingRight.w),
       width: MediaQuery.of(context).size.width *.43,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppColors.whiteNormalWhite4),
      child: Column(

        children: [
          ///==================================Top Section image, Favourite=============================

          Stack(
            children: [
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.all(5.r),
               
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.r),
                    color: AppColors.blueLighthoverBleu2),

                ///======================= Product Image =====================

                child: CustomNetworkImage(
                  borderRadius: BorderRadius.circular(8),
                    imageUrl: image, height: 120.w, width: MediaQuery.of(context).size.width),
              ),

              ///======================= Favourite Icon =====================

              Positioned(right: 0, child: bookMark),
              // IconButton(
              //   onPressed: () {},
              //   icon: const Icon(Icons.favorite_outline),
              //   color: AppColors.greenNormalGreen4,
              // )

              if (showOffer)
                Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: EdgeInsets.all(2.r),
                      decoration: const BoxDecoration(
                          color: AppColors.redNormalactiveRed6),
                      child: CustomText(
                        text: '${percentagePrice.toString()}% off',
                        color: AppColors.whiteLightWhite1,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///====================Product Name====================

                Expanded(
                  child: CustomText(
                    textAlign: TextAlign.start,
                    text: title,
                    fontWeight: FontWeight.w400,
                    fontSize: 15.h,

                  ),
                ),

                ///====================Product Quantity====================

                CustomText(text: quantity),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 8,right: 8,bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ///====================Product Price====================

                    CustomText(
                      text: "\$ $price",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.greenNormalGreen4,
                      right: 8.w,
                    ),

                    ///====================Product Old Price====================

                    // CustomText(
                    //   decoration: TextDecoration.lineThrough,
                    //   text: "\$$oldPrice",
                    //   fontWeight: FontWeight.w400,
                    //   color: AppColors.redDarkRed7,
                    // ),
                    oldPrice
                  ],
                ),

              /*  ///====================Add to card====================
                IconButton(
                    onPressed: onTapCard,
                    icon: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          color: AppColors.whiteLightWhite1),
                      child: const CustomImage(imageSrc: AppIcons.cart),
                    ))*/
              ],
            ),
          )
        ],
      ),
    );
  }
}
