import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:razco_foods/utils/app_colors.dart';


class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return   Center(
      child: SpinKitCircle(
        color: AppColors.blueNormalBleu4,
        size: 60.0,
      ),
    );
  }
}
