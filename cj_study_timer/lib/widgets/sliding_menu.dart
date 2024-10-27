import 'package:flutter/material.dart';

class SlidingMenu extends StatelessWidget {
  final AnimationController menuController;
  final VoidCallback closeMenu;

  const SlidingMenu({
    required this.menuController,
    required this.closeMenu,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(menuController),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: [Colors.white, Colors.grey],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  _menuButton("Button 1"),
                  _menuButton("Store"),
                  _menuButton("Achievements"),
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: closeMenu,
              child: Container(color: Colors.black.withOpacity(0.5)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuButton(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ElevatedButton(
        onPressed: () {
          // Add actions for buttons here
        },
        child: Text(text),
      ),
    );
  }
}
