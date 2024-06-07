import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:razco_foods/utils/app_colors.dart';
import 'package:razco_foods/utils/app_static_string.dart';
import 'package:razco_foods/view/screens/order_history/order_history_controller/order_history_controller.dart';
import 'package:razco_foods/view/widgets/custom_button/custom_button.dart';
import 'package:razco_foods/view/widgets/custom_text/customtext.dart';
import 'package:razco_foods/view/widgets/nav_bar/nav_bar.dart';

class BarCodeScan extends StatefulWidget {
  BarCodeScan({super.key});

  @override
  State<BarCodeScan> createState() => _BarCodeScanState();
}

class _BarCodeScanState extends State<BarCodeScan> {
  OrderHistoryController orderHistoryController =
      Get.find<OrderHistoryController>();


  MobileScannerController? mobileScannerController;

  initQR() {
    mobileScannerController?.start();
    setState(() {});
    mobileScannerController = MobileScannerController(
      useNewCameraSelector: true,
      autoStart: true,
      facing: CameraFacing.back,
      torchEnabled: false,
      returnImage: true,
    );

    setState(() {});
  }

  @override
  void initState() {
    initQR();

    super.initState();
  }

  @override
  void dispose() {
    mobileScannerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        centerTitle: true,
        title: CustomText(
          text: AppStrings.barCode,
          color: AppColors.greenNormalGreen4,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      bottomNavigationBar: const NavBar(currentIndex: 2),

      body: MobileScanner(
        fit: BoxFit.contain,
        controller: mobileScannerController,
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          // final Uint8List? image = capture.image;
          for (var barcode in barcodes) {
            debugPrint('Barcode found! ${barcode.rawValue}');
          }
          setState(() {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                    elevation: 0,
                    backgroundColor: AppColors.whiteLightactiveWhite3,
                    contentPadding: const EdgeInsets.symmetric(),
                    content: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.h, horizontal: 20.w),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)
                              //color: AppColors.pinkLight
                              ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ///<============= close ===========>
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Align(
                                alignment: Alignment.bottomRight,
                                child: Icon(
                                  Icons.close,
                                  size: 24.h,
                                  color: Colors.black,
                                )),
                          ),

                          SizedBox(
                            height: 16.h,
                          ),
                          Column(
                            children: [
                              Center(
                                  child: Column(
                                children: [
                                  // Text(
                                  //     // ignore: deprecated_member_use
                                  //     'Barcode Type: ${barcodes[0].rawValue}'),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  CustomText(
                                      text:
                                          'QR Number: ${barcodes[0].rawValue}',fontWeight: FontWeight.w500,)
                                ],
                              )),
                            ],
                          ),

                          SizedBox(
                            height: 16.h,
                          ),

                          ///<=========== button =============>
                          CustomButton(
                            onTap: () {
                              orderHistoryController.getScanHistory(
                                  id: barcodes[0].rawValue.toString());
                            },
                            title: 'submit',
                          ),
                        ],
                      ),
                    ));
              },
            );
          });
        },
      ),
    );
  }
}
