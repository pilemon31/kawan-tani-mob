import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/controllers/navbar/navbar_controller.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    final NavbarController controller = Get.put(NavbarController());

    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 70,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF78D14D),
                Color(0xFF349107),
              ],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  controller.changePage(0);
                  Get.toNamed("/home");
                },
                icon: Obx(
                  () => PhosphorIcon(
                      controller.currentIndex.value == 0
                          ? PhosphorIconsFill.house
                          : PhosphorIconsRegular.house,
                      size: 29.0,
                      color: Colors.white),
                ),
              ),
              IconButton(
                onPressed: () {
                  controller.changePage(1);
                  Get.toNamed("/plants");
                },
                icon: Obx(() => PhosphorIcon(
                      controller.currentIndex.value == 1
                          ? PhosphorIconsFill.tree
                          : PhosphorIconsRegular.tree,
                      size: 29.0,
                      color: Colors.white,
                    )),
              ),
              SizedBox(width: 70),
              IconButton(
                onPressed: () {
                  controller.changePage(2);
                  Get.toNamed("/articles");
                },
                icon: Obx(() => PhosphorIcon(
                      controller.currentIndex.value == 2
                          ? PhosphorIconsFill.articleMedium
                          : PhosphorIconsRegular.articleMedium,
                      size: 29.0,
                      color: Colors.white,
                    )),
              ),
              IconButton(
                onPressed: () {
                  controller.changePage(3);
                  Get.toNamed("/workshops");
                },
                icon: Obx(() => PhosphorIcon(
                      controller.currentIndex.value == 3
                          ? PhosphorIconsFill.microphoneStage
                          : PhosphorIconsRegular.microphoneStage,
                      size: 29.0,
                      color: Colors.white,
                    )),
              ),
            ],
          ),
        ),
        Positioned(
          top: -25,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF78D14D),
                  Color(0xFF349107),
                ],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () {
                controller.changePage(4);
                Get.toNamed("/add");
              },
              icon: Icon(
                Icons.add,
                color: whiteColor,
                size: 32,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
