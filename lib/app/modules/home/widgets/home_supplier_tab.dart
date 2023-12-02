part of '../home_page.dart';

class _HomeSupplierTab extends StatelessWidget {
  final HomeController _controller;

  const _HomeSupplierTab({required HomeController controller})
      : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _HomeTabHeader(controller: _controller),
        Expanded(
          child: Observer(builder: (_) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child:
                  _controller.supplierPageTypeSelected == SupplierPageType.list
                      ? _HomeSupplierList(_controller)
                      : _HomeSupplierGrid(_controller),
            );
          }),
        ),
      ],
    );
  }
}

class _HomeTabHeader extends StatelessWidget {
  final HomeController _controller;
  const _HomeTabHeader({required HomeController controller})
      : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          const Text("Estabelecimentos"),
          const Spacer(),
          Observer(builder: (_) {
            return InkWell(
              onTap: () => _controller.changeTabSupplier(SupplierPageType.list),
              child: Icon(
                Icons.view_headline,
                color: _controller.supplierPageTypeSelected ==
                        SupplierPageType.list
                    ? Colors.black
                    : Colors.grey,
              ),
            );
          }),
          Observer(builder: (_) {
            return InkWell(
              onTap: () => _controller.changeTabSupplier(SupplierPageType.grid),
              child: Icon(
                Icons.view_compact,
                color: _controller.supplierPageTypeSelected ==
                        SupplierPageType.grid
                    ? Colors.black
                    : Colors.grey,
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _HomeSupplierList extends StatelessWidget {
  final HomeController _controller;
  const _HomeSupplierList(this._controller);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        Observer(builder: (_) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final supplier = _controller.listSuppliersByAddres[index];
                return _HomeSupplierListItemWidget(supplier: supplier);
              },
              childCount: _controller.listSuppliersByAddres.length,
            ),
          );
        }),
      ],
    );
  }
}

class _HomeSupplierListItemWidget extends StatelessWidget {
  final SupplierNearbyMeModel supplier;
  const _HomeSupplierListItemWidget({
    required this.supplier,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Modular.to.pushNamed("/supplier/", arguments: supplier.id);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 30),
              width: 1.sw,
              height: 80.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            supplier.name,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 16,
                              ),
                              Text(
                                  "${supplier.distance.toStringAsFixed(2)} km de distância")
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: CircleAvatar(
                      backgroundColor: context.primaryColor,
                      maxRadius: 15,
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.transparent, width: 1),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[100]!, width: 5),
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                    image: NetworkImage(supplier.logo),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeSupplierGrid extends StatelessWidget {
  final HomeController _controller;
  const _HomeSupplierGrid(this._controller);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        Observer(builder: (_) {
          return SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final supplier = _controller.listSuppliersByAddres[index];
                return _HomeSupplierGridItemWidget(supplier);
              },
              childCount: 10,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.1,
            ),
          );
        }),
      ],
    );
  }
}

class _HomeSupplierGridItemWidget extends StatelessWidget {
  final SupplierNearbyMeModel supplier;
  const _HomeSupplierGridItemWidget(this.supplier);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Modular.to.pushNamed("/supplier/", arguments: supplier.id);
      },
      child: Stack(
        children: [
          Card(
            color: Colors.white,
            margin:
                const EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 10),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SizedBox.expand(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 40.0, left: 10, right: 10, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      supplier.name,
                      style: context.textTheme.titleSmall,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "${supplier.distance.toStringAsFixed(2)} km de distância",
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey[300], //200
            ),
          ),
          Positioned(
            top: 5,
            left: 0,
            right: 0,
            child: Center(
              child: CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(supplier.logo),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
