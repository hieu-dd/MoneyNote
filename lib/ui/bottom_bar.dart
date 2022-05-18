import 'package:money_note/ui/account/account.dart';
import 'package:money_note/ui/add/add_transaction.dart';
import 'package:money_note/ui/chart/chart_screen.dart';
import 'package:money_note/ui/notification/notification.dart';
import 'package:money_note/ui/setting/setting.dart';
import 'package:money_note/ui/transactions/transactions_screen.dart';
import 'package:flutter/material.dart';
import 'package:money_note/utils/routes/routes.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  late List<Map<String, Object>> _pages;
  var _selectedPageIndex = 1;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index == 2 ? _selectedPageIndex : index;
    });
  }

  @override
  void initState() {
    _pages = [
      {
        "page": TransactionsScreen(),
        "key": "Transaction",
      },
      {
        "page": ChartScreen(),
        "key": "Report",
      },
      {},
      {
        "page": NotificationScreen(),
        "key": "Notifications",
      },
      {
        "page": AccountScreen(),
        "key": "Setting",
      }
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final page = _pages[_selectedPageIndex];
    return Scaffold(
      body: SafeArea(child: page["page"] as Widget),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 4,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          backgroundColor: Theme.of(context).backgroundColor,
          selectedItemColor: Theme.of(context).colorScheme.primaryVariant,
          unselectedItemColor: Colors.grey,
          onTap: _selectPage,
          currentIndex: _selectedPageIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined),
              label: 'Transaction',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_outlined),
              label: 'Report',
            ),
            BottomNavigationBarItem(
              activeIcon: null,
              icon: Icon(null),
              tooltip: "",
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active_outlined),
              label: 'Notification',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: 'Setting',
            ),
          ],
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.addTransaction);
        },
      ),
    );
  }
}
