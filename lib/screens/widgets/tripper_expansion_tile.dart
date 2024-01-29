import 'package:flutter/material.dart';
import 'package:tripper/screens/utils/exports.dart';

class TripperExpansionTile extends StatelessWidget {
  const TripperExpansionTile({
    required this.controller,
    required this.title,
    required this.icon,
    required this.children,
    this.onExpansionChanged,
    super.key,
  });

  final ExpansionTileController controller;
  final Widget title;
  final IconData icon;
  final List<Widget> children;
  final void Function(bool)? onExpansionChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ExpansionTile(
          controller: controller,
          onExpansionChanged: (expanded) {
            onExpansionChanged?.call(expanded);
            FocusScope.of(context).unfocus();
          },
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          collapsedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          title: title,
          trailing: IconButton(
            icon: Icon(icon),
            color: Theme.of(context).primaryIconTheme.color?.withOpacity(.8),
            onPressed: () {},
          ),
          tilePadding: const EdgeInsets.only(
            left: Dimensions.m,
          ),
          children: children,
        ),
      ),
    );
  }
}
