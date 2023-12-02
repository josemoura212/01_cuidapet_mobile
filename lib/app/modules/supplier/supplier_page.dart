import 'package:cuidapet_mobile/app/core/life_cycle/page_life_cycle_state.dart';
import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/modules/supplier/supplier_controller.dart';
import 'package:cuidapet_mobile/app/modules/supplier/widgets/supplier_detail.dart';
import 'package:cuidapet_mobile/app/modules/supplier/widgets/supplier_service_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SupplierPage extends StatefulWidget {
  final int _supplierId;
  const SupplierPage({
    super.key,
    required int supplierId,
  }) : _supplierId = supplierId;

  @override
  State<SupplierPage> createState() => _SupplierPageState();
}

class _SupplierPageState
    extends PageLifeCycleState<SupplierController, SupplierPage> {
  late ScrollController _scrollController;
  final sliverCollapedVN = ValueNotifier(false);

  @override
  Map<String, dynamic>? get params => {"supplierId": widget._supplierId};

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset > 180 &&
          !_scrollController.position.outOfRange) {
        sliverCollapedVN.value = true;
      } else if (_scrollController.offset <= 180 &&
          !_scrollController.position.outOfRange) {
        sliverCollapedVN.value = false;
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Observer(
        builder: (_) {
          return AnimatedOpacity(
            opacity: controller.totalServicesSelected > 0 ? 1 : 0,
            duration: const Duration(milliseconds: 500),
            child: FloatingActionButton.extended(
              onPressed: controller.goToSchedule,
              label: const Text("Fazer agendamento"),
              icon: const Icon(Icons.schedule),
              backgroundColor: context.primaryColor,
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Observer(
        builder: (_) {
          final supplierModel = controller.supplierModel;
          if (supplierModel == null) {
            return Center(
              child: CircularProgressIndicator(
                color: context.primaryColor,
              ),
            );
          }
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                title: ValueListenableBuilder<bool>(
                    valueListenable: sliverCollapedVN,
                    builder: (context, sliverCollapVNValue, child) {
                      return Visibility(
                        visible: sliverCollapVNValue,
                        child: Text(
                          supplierModel.name,
                        ),
                      );
                    }),
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [
                    StretchMode.blurBackground,
                    StretchMode.fadeTitle,
                  ],
                  background: Image.network(
                    supplierModel.logo,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox.shrink(),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SupplierDetail(
                  supplierModel: supplierModel,
                  controller: controller,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Serviços (${controller.totalServicesSelected} Selecionado${controller.totalServicesSelected > 1 ? "s" : ""})",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final service = controller.supplierServices[index];
                    return SupplierServiceWidget(
                      service: service,
                      supplierController: controller,
                    );
                  },
                  childCount: controller.supplierServices.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
