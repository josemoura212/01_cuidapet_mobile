// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddressController on AddressControllerBase, Store {
  late final _$_addressAtom =
      Atom(name: 'AddressControllerBase._address', context: context);

  List<AddressEntity> get address {
    _$_addressAtom.reportRead();
    return super._address;
  }

  @override
  List<AddressEntity> get _address => address;

  @override
  set _address(List<AddressEntity> value) {
    _$_addressAtom.reportWrite(value, super._address, () {
      super._address = value;
    });
  }

  late final _$getAddressesAsyncAction =
      AsyncAction('AddressControllerBase.getAddresses', context: context);

  @override
  Future<void> getAddresses() {
    return _$getAddressesAsyncAction.run(() => super.getAddresses());
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
