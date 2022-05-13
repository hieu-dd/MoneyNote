import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:money_note/providers/category/categories.dart';
import '../../utils/ext/list_ext.dart';
import '../../models/transaction/transaction.dart';
import 'package:provider/provider.dart';

class TransactionsPieChart extends StatefulWidget {
  final List<TransactionPieCharItem> items;

  TransactionsPieChart({required this.items});

  @override
  State<TransactionsPieChart> createState() => _TransactionsPieChartState();
}

class _TransactionsPieChartState extends State<TransactionsPieChart> {
  int touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final categoriesProvider = context.watch<CategoriesProvider>();

    final sections = widget.items.mapIndexed((e, i) {
      final isTouched = false;
      // final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 55.0 : 40.0;
      final category = categoriesProvider.findById(e.categoryId);
      return PieChartSectionData(
        color: category.color,
        value: e.value.toDouble(),
        title: "${e.value} %",
        radius: radius,
        titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white),
        badgeWidget: _Badge(
          category.icon,
          size: widgetSize,
          borderColor: category.color ?? theme.primaryColorDark,
        ),
        badgePositionPercentageOffset: .98,
      );
    }).toList();
    return PieChart(
      PieChartData(
          pieTouchData: PieTouchData(
              touchCallback: (FlTouchEvent event, pieTouchResponse) {
            setState(() {
              if (!event.isInterestedForInteractions ||
                  pieTouchResponse == null ||
                  pieTouchResponse.touchedSection == null) {
                touchedIndex = -1;
                return;
              }
              touchedIndex =
                  pieTouchResponse.touchedSection!.touchedSectionIndex;
            });
          }),
          borderData: FlBorderData(
            show: false,
          ),
          sectionsSpace: 0,
          centerSpaceRadius: 0,
          sections: sections),
    );
  }
}

class _Badge extends StatelessWidget {
  final IconData? iconData;
  final double size;
  final Color borderColor;

  const _Badge(
    this.iconData, {
    Key? key,
    required this.size,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: Icon(
          iconData,
          color: borderColor,
        ),
      ),
    );
  }
}

class TransactionPieCharItem {
  int value;
  String categoryId;

  TransactionPieCharItem({required this.value, required this.categoryId});
}
