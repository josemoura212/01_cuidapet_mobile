part of '../address_page.dart';

class _AddressItem extends StatelessWidget {
  const _AddressItem();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: const ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 30,
          child: Icon(
            Icons.location_on,
            color: Colors.black,
          ),
        ),
        title: Text('Av. Paulista, 10'),
        subtitle: Text("Complemento XX"),
      ),
    );
  }
}
