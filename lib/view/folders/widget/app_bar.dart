
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common_widget/soft_control.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const CircularSoftButton(
              radius: 25,
              icon: Icon(Icons.arrow_back_ios_new_rounded,size: 20,),
            ),
          ),
          const Text('Folders'),
          const CircularSoftButton(
            radius: 25,
            icon: Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}
