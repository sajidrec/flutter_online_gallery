import 'package:flutter/material.dart';
import 'package:online_gallery_app/presentation/utils/app_color_utils.dart';

AppBar appBar({required String pageName}) {
  return AppBar(
    title: Text(pageName),
    backgroundColor: AppColorsUtil.appColor,
    foregroundColor: AppColorsUtil.appTextColor,
  );
}
