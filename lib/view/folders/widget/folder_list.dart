import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/res/app_path.dart';
import '../../../view_model/controller/folder_controller.dart';
import '../../audio_list/file_list.dart';
import '../../common_widget/soft_control.dart';

class Folders extends StatefulWidget {
  const Folders({super.key});

  @override
  State<Folders> createState() => _FoldersState();
}

class _FoldersState extends State<Folders> {
  final controller = Get.put(FolderController());
  final GlobalKey<AnimatedListState> _key = GlobalKey();

  int length = 0;
  @override
  void initState() {
    length = controller.folderList.length;
    super.initState();
    Timer(const Duration(milliseconds: 50), () {
      for (int i = 0; i < controller.folderList.length; i++) {
        _insertItemWithDelay(i);
        if (controller.folderList[i] == AppPaths.path) {
          length = length - 1;
        }
      }
    });
    if (length < 0) {
      length = controller.folderList.length;
    }
  }

  void _insertItemWithDelay(int index) {
    if (_key.currentState != null) {
      Timer(Duration(milliseconds: index * 50), () {
        _key.currentState!.insertItem(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.folderList.isEmpty
          ? const Expanded(
              child: Center(
              child: SizedBox(
                height: 15,
                width: 15,
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
            ))
          : Expanded(
              child: AnimatedList(
                key: _key,
                // initialItemCount: length,
                itemBuilder: (context, index, animation) {
                  final path = controller.folderList[index];
                  if (path.toString().length < 50 && path != AppPaths.path) {
                    final slideAnimation = Tween<Offset>(
                      begin: index % 2 == 0
                          ? const Offset(-1.0, 0.0)
                          : const Offset(1.0, 0.0),
                      end: const Offset(0.0, 0.0),
                    ).animate(CurvedAnimation(
                      parent: animation,
                      curve: const Interval(
                        0.0,
                        1.0,
                        curve: Curves
                            .easeOut, // You can change the animation curve here
                      ),
                    ));
                    return SlideTransition(
                      position: slideAnimation,
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => AudioList(
                                path: path,
                              ),);
                        },
                        child: Container(
                          height: 75,
                          width: MediaQuery.sizeOf(context).width,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              const CircularSoftButton(
                                radius: 25,
                                icon: Icon(
                                  Icons.folder,
                                  color: Colors.orangeAccent,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                path.toString().substring(
                                      path.toString().indexOf('0') + 2,
                                    ),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
    );
  }
}
