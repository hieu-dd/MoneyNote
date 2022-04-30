import 'package:money_note/ui/chart/chart_screen.dart';
import 'package:money_note/ui/home/home.dart';
import 'package:money_note/ui/transactions/transactions_screen.dart';
import 'package:flutter/material.dart';

class BottomBarScreen extends StatefulWidget {
  static const routeName = "/main_screen";

  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  late List<Map<String, Object>> _pages;
  var _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index == 1
          ? _selectedPageIndex
          : index > 1
              ? index - 1
              : index;
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
          onTap: _selectPage,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined),
              label: 'Transaction',
            ),
            BottomNavigationBarItem(
              activeIcon: null,
              icon: Icon(null),
              tooltip: "",
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_outlined),
              label: 'Report',
            ),
          ],
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
