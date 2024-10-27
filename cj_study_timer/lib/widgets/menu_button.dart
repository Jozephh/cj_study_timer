import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final bool showMenu;
  final AnimationController menuController;
  final VoidCallback toggleMenu;

  const MenuButton({
    required this.showMenu,
    required this.menuController,
    required this.toggleMenu,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      left: 20,
      child: SizedBox(
        width: 80,
        height: 80,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: Colors.white,
          ),
          onPressed: toggleMenu,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _menuLine(),
              _menuLine(),
              _menuLine(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuLine() {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      width: 40,
      height: 6,
      color: Colors.black,
    );
  }
}
