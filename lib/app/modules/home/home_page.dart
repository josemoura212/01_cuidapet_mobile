import 'package:cuidapet_mobile/app/core/life_cycle/page_life_cycle_state.dart';
import 'package:cuidapet_mobile/app/modules/home/home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends PageLifeCycleState<HomeController, HomePage> {
  @override
  Map<String, dynamic>? get params => {"teste": "Teste life cycle"};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
          child: const Text("Logout"),
        ),
      ),
    );
  }
}
