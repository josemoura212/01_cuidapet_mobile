import 'package:cuidapet_mobile/app/core/entities/address_entity.dart';
import 'package:cuidapet_mobile/app/core/life_cycle/page_life_cycle_state.dart';
import 'package:cuidapet_mobile/app/core/rest_client/rest_client.dart';
import 'package:cuidapet_mobile/app/modules/home/home_controller.dart';
import 'package:cuidapet_mobile/app/services/address/address_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends PageLifeCycleState<HomeController, HomePage> {
  AddressEntity? addressEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Row(
            children: [],
          ),
          TextButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            child: const Text("Logout"),
          ),
          TextButton(
            onPressed: () async {
              final categoriesResponse =
                  await Modular.get<RestClient>().auth().get("/categories/");
              debugPrint('categoriesResponse: $categoriesResponse');
            },
            child: const Text("Teste Refresh Token"),
          ),
          TextButton(
            onPressed: () async {
              controller.goToAddressPage();
            },
            child: const Text("Ir para endereço"),
          ),
          TextButton(
            onPressed: () async {
              final address =
                  await Modular.get<AddressService>().getAddressSelected();
              setState(() {
                addressEntity = address;
              });
            },
            child: const Text("Buscar Endereço"),
          ),
          Observer(builder: (_) {
            return Text(controller.addressEntity?.address ??
                "Nenhum endereço encontrado");
          }),
          Observer(builder: (_) {
            return Text(controller.addressEntity?.additional ??
                "Nenhum complemento selecionado");
          }),
        ],
      ),
    );
  }
}
