import 'package:flutter/material.dart';

import 'package:cuidapet_mobile/app/core/helpers/text_formatter.dart';
import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/models/supplier_services_model.dart';
import 'package:cuidapet_mobile/app/modules/supplier/supplier_controller.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SupplierServiceWidget extends StatelessWidget {
  final SupplierServicesModel service;
  final SupplierController supplierController;
  const SupplierServiceWidget({
    super.key,
    required this.service,
    required this.supplierController,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.pets),
      ),
      title: Text(service.name),
      subtitle: Text(
        TextFormatter.formateReal(service.price),
      ),
      trailing: Observer(
        builder: (_) {
          return IconButton(
            onPressed: () {
              supplierController.addOrRemoveService(service);
            },
            icon: supplierController.isServiceSelected(service)
                ? const Icon(
                    Icons.remove_circle,
                    size: 30,
                    color: Colors.red,
                  )
                : Icon(
                    Icons.add_circle,
                    size: 30,
                    color: context.primaryColor,
                  ),
          );
        },
      ),
    );
  }
}
