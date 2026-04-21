import 'package:flutter/material.dart';
import 'package:practise/common/common_text_style.dart';
import 'package:practise/common/responsive.dart';
import 'package:practise/config/appColor.dart';

class AppBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      const _BottomNavItem('Home', Icons.home),
      const _BottomNavItem('Search', Icons.search),
      const _BottomNavItem('Message', Icons.mail_outline),
      const _BottomNavItem('Setting', Icons.settings),
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(54, 41, 183, 0.08),
            blurRadius: 20,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final active = index == selectedIndex;

          return InkWell(
            borderRadius: BorderRadius.circular(28),
            onTap: () => onTap(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              padding: EdgeInsets.symmetric(
                horizontal: active ? 16 : 10,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: active ? AppColor.primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    item.icon,
                    color: active ? Colors.white : const Color(0xFF8F8F9F),
                    size: 22,
                  ),
                  if (active) ...[
                    const SizedBox(width: 8),
                    Text(
                      item.label,
                      style: AppTextStyle.caption
                          .responsive(context)
                          .copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _BottomNavItem {
  final String label;
  final IconData icon;

  const _BottomNavItem(this.label, this.icon);
}
