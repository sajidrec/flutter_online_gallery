import 'package:flutter/material.dart';
import 'package:online_gallery_app/presentation/utils/app_color_utils.dart';

Center circularCenterLoader() {
  return Center(
    child: CircularProgressIndicator(
      color: AppColorsUtil.appColor,
    ),
  );
}
