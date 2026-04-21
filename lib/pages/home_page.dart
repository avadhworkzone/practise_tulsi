import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practise/common/common_text_style.dart';
import 'package:practise/config/appColor.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth_scaffold.dart';
import 'search_page.dart';
import 'message_page.dart';
import 'setting_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final AuthController controller = Get.find<AuthController>();

  final List<_HomeAction> actions = [
    _HomeAction('Account and Card', Icons.credit_card),
    _HomeAction('Transfer', Icons.swap_horiz),
    _HomeAction('Withdraw', Icons.attach_money),
    _HomeAction('Mobile prepaid', Icons.phone_android),
    _HomeAction('Pay the bill', Icons.receipt_long),
    _HomeAction('Serve online', Icons.support_agent),
    _HomeAction('Credit card', Icons.credit_card_outlined),
    _HomeAction('Transaction report', Icons.bar_chart),
    _HomeAction('Beneficiary', Icons.person_outline),
  ];

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: controller.currentUserName.value.isEmpty ? 'User' : controller.currentUserName.value,
      appColor: AppColor.primaryColor,
      textColor: AppColor.white,
      showBackButton: false,
      image: 'https://i.pravatar.cc/150?img=32',
      action: Stack(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.white),
          ),
          Positioned(
            right: 10,
            top: 8,
            child: Container(
              height: 18,
              width: 18,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text('3', style: AppTextStyle.whiteTitle.copyWith(fontSize: 10)),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (selectedIndex == 0) ...[
                    _buildCard(),
                    const SizedBox(height: 28),
                    _buildActionGrid(),
                  ] else if (selectedIndex == 1) ...[
                    const SearchPage(),
                  ] else if (selectedIndex == 2) ...[
                    const MessagePage(),
                  ] else ...[
                    const SettingPage(),
                  ],
                ],
              ),
            ),
          ),
          _buildBottomNav(),
        ],
      ),
    );
  }


  Widget _buildCard() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: 16,
          top: 24,
          child: Container(
            height: 190,
            width: MediaQuery.of(context).size.width - 92,
            decoration: BoxDecoration(
              color: const Color(0xFF5152C5),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF27238D), Color(0xFF3B44F0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(54, 41, 183, 0.3),
                  blurRadius: 24,
                  offset: Offset(0, 16),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -20,
                  top: -20,
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF6DB6FF),
                    ),
                  ),
                ),
                Positioned(
                  left: -100,
                  top:-60,
                  child: Container(
                    height: 350,
                    width: 350,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF1C1A6F),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () => Text(
                                    controller.currentUserName.value.isEmpty ? 'Your Card' : controller.currentUserName.value,
                                    style: AppTextStyle.whiteTitle.copyWith(fontSize: 22, fontWeight: FontWeight.w700),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text('Amazon Platinum', style: AppTextStyle.whiteTitle.copyWith(color: Colors.white70, fontSize: 14)),
                              ],
                            ),
                          ),
                          Container(
                            height: 44,
                            width: 44,
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(45),
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),
                      Text('4756  ••••  ••••  9018', style: AppTextStyle.whiteTitle.copyWith(fontSize: 16, letterSpacing: 1.6)),
                      const SizedBox(height: 22),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Balance', style: AppTextStyle.whiteTitle.copyWith(color: Colors.white70, fontSize: 12)),
                              const SizedBox(height: 6),
                              Text('\$3,469.52', style: AppTextStyle.whiteTitle.copyWith(fontSize: 28, fontWeight: FontWeight.w700)),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(45),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Text('VISA', style: AppTextStyle.whiteTitle.copyWith(fontWeight: FontWeight.w700, fontSize: 14)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionGrid() {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: actions.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.95,
      ),
      itemBuilder: (context, index) {
        final item = actions[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(54, 41, 183, 0.08),
                blurRadius: 18,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  color: AppColor.cF2F1F9,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(item.icon, color: AppColor.primaryColor, size: 22),
              ),
              const SizedBox(height: 12),
              Text(
                item.label,
                style: AppTextStyle.body.copyWith(fontSize: 12, color: const Color(0xFF5E5E78)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomNav() {
    final items = [
      _BottomNavItem('Home', Icons.home),
      _BottomNavItem('Search', Icons.search),
      _BottomNavItem('Message', Icons.mail_outline),
      _BottomNavItem('Setting', Icons.settings),
    ];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
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
          return GestureDetector(
            onTap: () => setState(() => selectedIndex = index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(item.icon, color: active ? AppColor.primaryColor : const Color(0xFF9E9EAF)),
                const SizedBox(height: 6),
                Text(
                  item.label,
                  style: AppTextStyle.caption.copyWith(color: active ? AppColor.primaryColor : const Color(0xFF9E9EAF)),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _HomeAction {
  final String label;
  final IconData icon;

  _HomeAction(this.label, this.icon);
}

class _BottomNavItem {
  final String label;
  final IconData icon;

  _BottomNavItem(this.label, this.icon);
}
