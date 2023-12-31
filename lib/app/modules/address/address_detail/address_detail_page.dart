import 'package:cuidapet_mobile/app/core/ui/extensions/size_screen_extensions.dart';
import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/cuidapet_default_button.dart';
import 'package:cuidapet_mobile/app/models/place_model.dart';
import 'package:cuidapet_mobile/app/modules/address/address_detail/address_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

class AddressDetailPage extends StatefulWidget {
  final PlaceModel place;
  const AddressDetailPage({super.key, required this.place});

  @override
  State<AddressDetailPage> createState() => _AddressDetailPageState();
}

class _AddressDetailPageState extends State<AddressDetailPage> {
  final _additionalEC = TextEditingController();
  final controller = Modular.get<AddressDetailController>();
  late final ReactionDisposer addressEntityDisposer;

  @override
  void initState() {
    super.initState();
    addressEntityDisposer =
        reaction((_) => controller.addressEntity, (addressEntity) {
      if (addressEntity != null) {
        Navigator.pop(context, addressEntity);
      }
    });
  }

  @override
  void dispose() {
    _additionalEC.dispose();
    addressEntityDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final place = widget.place;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: context.primaryColor),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Text(
            "Confirme seu endereço",
            style: context.textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  place.lat,
                  place.lng,
                ),
                zoom: 16,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId("AddressId"),
                  position: LatLng(
                    place.lat,
                    place.lng,
                  ),
                  infoWindow: InfoWindow(
                    title: place.address,
                  ),
                ),
              },
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              readOnly: true,
              initialValue: place.address,
              decoration: InputDecoration(
                labelText: "Endereço",
                suffixIcon: IconButton(
                  onPressed: () {
                    Navigator.pop(context, place);
                  },
                  icon: const Icon(Icons.edit),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _additionalEC,
              decoration: const InputDecoration(
                labelText: "Complemento",
                suffixIcon: Icon(Icons.edit),
              ),
            ),
          ),
          SizedBox(
            width: .9.sw,
            height: 60.h,
            child: CuidapetDefaultButton(
              onPressed: () {
                controller.saveAddress(place, _additionalEC.text);
              },
              label: "Salvar",
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
