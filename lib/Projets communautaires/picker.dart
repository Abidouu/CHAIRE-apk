import 'package:flutter/cupertino.dart';
import 'package:cci_app/config.dart';
import 'package:get/get.dart';

class MyPickerWidget extends StatelessWidget {
  final List<String> options;
  final ValueChanged<String>? onItemSelected;

  MyPickerWidget({required this.options, this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
    width: Get.size.width,
    height: getProportionateScreenHeight(200),
    child: CupertinoPicker(
      itemExtent: 30,
      onSelectedItemChanged: (index) {
        if (onItemSelected != null) {
          onItemSelected!(options[index]);
        }
      },
      children: options.map((item) => Text(item)).toList(),
    ));
  }
}
