import 'package:cuidapet_mobile/app/core/ui/extensions/size_screen_extensions.dart';
import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends SliverAppBar {
  HomeAppBar(
    HomeController controller, {
    super.key,
  }) : super(
          expandedHeight: 100,
          collapsedHeight: 100,
          pinned: true,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          flexibleSpace: _CuidapetAppBar(controller: controller),
        );
}

class _CuidapetAppBar extends StatelessWidget {
  final HomeController controller;
  const _CuidapetAppBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    final outLineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: Colors.grey[200]!),
    );

    return AppBar(
      backgroundColor: Colors.grey[100],
      centerTitle: true,
      title: const Padding(
        padding: EdgeInsets.only(bottom: 20.0),
        child: Text("Cuidapet"),
      ),
      actions: [
        IconButton(
          onPressed: () {
            controller.goToAddressPage();
          },
          icon: const Icon(
            Icons.location_on,
            size: 30,
          ),
        ),
      ],
      elevation: 0,
      flexibleSpace: Stack(
        children: [
          Container(
            height: 110.h,
            color: context.primaryColor,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: .9.sw,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(30),
                child: TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon:
                        const Icon(Icons.search, size: 25, color: Colors.grey),
                    border: outLineInputBorder,
                    enabledBorder: outLineInputBorder,
                    focusedBorder: outLineInputBorder,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
