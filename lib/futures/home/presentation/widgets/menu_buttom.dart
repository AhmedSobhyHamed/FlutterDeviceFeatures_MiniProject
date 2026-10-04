import 'package:flutter/material.dart';

class MenuButtom extends StatelessWidget {
  const MenuButtom({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildMenuButtom(context);
  }

  Widget _buildMenuButtom(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return InkWell(
          onTap: () => Scaffold.of(context).openDrawer(),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.settings, color: Colors.blue), 
          ),
        );
      },
    );
  }
}