part of '../../address_page.dart';

typedef AddressSelectedCallBack = void Function(PlaceModel);

class _AddressSearchWidget extends StatefulWidget {
  final AddressSelectedCallBack addressSelectedCallBack;
  final PlaceModel? place;
  const _AddressSearchWidget({
    super.key,
    required this.addressSelectedCallBack,
    this.place,
  });

  @override
  State<_AddressSearchWidget> createState() => _AddressSearchWidgetState();
}

class _AddressSearchWidgetState extends State<_AddressSearchWidget> {
  final _searchTextEC = TextEditingController();
  final _searchTextFN = FocusNode();

  final controller = Modular.get<AddressSearchWidgetController>();

  @override
  void initState() {
    super.initState();
    if (widget.place != null) {
      _searchTextEC.text = widget.place?.address ?? "";
      _searchTextFN.requestFocus();
    }
  }

  @override
  void dispose() {
    _searchTextEC.dispose();
    _searchTextFN.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(
        style: BorderStyle.none,
      ),
    );
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(20),
      child: TypeAheadFormField<PlaceModel>(
        textFieldConfiguration: TextFieldConfiguration(
          controller: _searchTextEC,
          focusNode: _searchTextFN,
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.location_on,
              color: Colors.black,
            ),
            hintText: "Insira um endereço",
            border: border,
            disabledBorder: border,
            enabledBorder: border,
          ),
        ),
        onSuggestionSelected: _onSuggestionSelected,
        suggestionsCallback: _suggestionsCallback,
        itemBuilder: (_, item) {
          debugPrint("item : $item");
          return _ItemTile(
            address: item.address,
          );
        },
      ),
    );
  }

  FutureOr<List<PlaceModel>> _suggestionsCallback(String pattern) async {
    if (pattern.isNotEmpty) {
      final places = await controller.searchAddress(pattern);

      return places;
    }
    return <PlaceModel>[];
  }

  void _onSuggestionSelected(PlaceModel suggestion) {
    _searchTextEC.text = suggestion.address;
    widget.addressSelectedCallBack(suggestion);
  }
}

class _ItemTile extends StatelessWidget {
  final String address;
  const _ItemTile({required this.address});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.location_on),
      title: Text(address),
    );
  }
}
