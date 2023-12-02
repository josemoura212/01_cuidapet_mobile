import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/models/supplier_model.dart';
import 'package:cuidapet_mobile/app/modules/supplier/supplier_controller.dart';

class SupplierDetail extends StatelessWidget {
  final SupplierController controller;
  final SupplierModel supplierModel;

  const SupplierDetail({
    super.key,
    required this.controller,
    required this.supplierModel,
  });

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
            child: Center(
              child: Text(
                supplierModel.name,
                style: context.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Divider(
            thickness: 1,
            color: context.primaryColor,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Informações do estabelecimento",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ),
          ListTile(
            onTap: controller.goToGeoCopyAddressToClipart,
            leading: const Icon(
              Icons.location_city,
              color: Colors.black,
            ),
            title: Text(supplierModel.address),
          ),
          ListTile(
            onTap: controller.goToPhoneOrCopyPhoneToClipart,
            leading: const Icon(
              Icons.local_phone,
              color: Colors.black,
            ),
            title: Text(supplierModel.phone),
          ),
          Divider(
            thickness: 3,
            color: context.primaryColor,
          ),
        ],
      );
    });
  }
}
