import 'package:flutter/material.dart';
import 'package:razco_foods/utils/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ConstValue {
  static indicator({required PageController controller, required int count}) =>
      SmoothPageIndicator(
        controller: controller,
        count: count,
        axisDirection: Axis.horizontal,
        effect: const ExpandingDotsEffect(
          expansionFactor: 2,
          spacing: 8.0,
          //radius: 4.0,
          dotWidth: 16.0,
          dotHeight: 8.0,
          paintStyle: PaintingStyle.fill,
          strokeWidth: 1.5,
          dotColor: AppColors.greenLightactiveGreen3,
          activeDotColor: AppColors.greenNormalGreen4,
        ),
      );
}
