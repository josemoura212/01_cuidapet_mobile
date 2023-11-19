part of '../address_page.dart';

class _AddressItem extends StatelessWidget {
  final AddressEntity addressEntity;
  const _AddressItem({
    required this.addressEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.white,
          radius: 30,
          child: Icon(
            Icons.location_on,
            color: Colors.black,
          ),
        ),
        title: Text(addressEntity.address),
        subtitle: Text(addressEntity.additional),
      ),
    );
  }
}
