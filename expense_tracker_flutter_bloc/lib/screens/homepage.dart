import 'package:expense_tracker_flutter_bloc/model/ExpenseModel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/expense_tracker_bloc.dart';
import '../controller/expense_tracker_state.dart';
import '../pagecontroller/navigationcontroller_cubit.dart';
import 'addexpensepage.dart';

class Expensehome extends StatefulWidget {
  const Expensehome({super.key});

  @override
  State<Expensehome> createState() => _ExpensehomeState();
}

class _ExpensehomeState extends State<Expensehome> {
  final List<Widget> _pages = [const HomeContent(), const AddExpenseWidget()];

  @override
  Widget build(BuildContext context) {
    final pageprovider = context.read<NavigationcontrollerCubit>();
    int _selectedIndex =
        context.watch<NavigationcontrollerCubit>().state.pageNumber;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(27, 35, 57, 1),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(27, 35, 57, 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline),
                activeIcon: Icon(Icons.add_circle),
                label: 'Add',
              ),
            ],
            onTap: pageprovider.changePageNumber,
            currentIndex: _selectedIndex,
            selectedItemColor: const Color.fromRGBO(75, 218, 249, 1),
            unselectedItemColor: Colors.grey,
            backgroundColor: const Color.fromRGBO(27, 35, 57, 1),
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseTrackerBloc, ExpenseTrackerState>(
      builder: (context, state) {
        if (state is ExpenseTrackerUpdate) {
          return Container(
            padding: EdgeInsets.only(top: 50),
            color: Color.fromRGBO(27, 35, 57, 1),
            child: ListView(
              children: [
                const AspectRatio(aspectRatio: 1.8, child: _BarChart()),
                ...state.oldExpenseList
                    .map(
                      (expense) => Card(
                        color: Color.fromRGBO(27, 35, 57, 1),
                        margin: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ListTile(
                          title: Text(
                            expense.title,
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            '${expense.category} - ${expense.date}',
                            style: TextStyle(color: Colors.grey),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '\$${expense.amount.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: Color.fromRGBO(75, 218, 249, 1),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: Colors.red[300],
                                ),
                                onPressed: () {
                                  context.read<ExpenseTrackerBloc>().add(
                                    ExpenseRemove(expense.id),
                                  );
                                },
                              ),
                            ],
                          ),
                          leading: Icon(
                            Icons.category,
                            color: Color.fromRGBO(75, 218, 249, 1),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ],
            ),
          );
        } else if (state is ExpenseTrackerErrMsg) {
          return Center(
            child: Text(state.errMsg, style: TextStyle(color: Colors.red)),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _BarChart extends StatelessWidget {
  const _BarChart();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseTrackerBloc, ExpenseTrackerState>(
      builder: (context, state) {
        if (state is ExpenseTrackerUpdate) {
          // Create a map to store category totals
          final Map<Category, double> expenseAmounts = {};

          // Initialize all categories with 0
          for (var category in Category.values) {
            expenseAmounts[category] = 0;
          }

          // Sum up amounts for each category
          for (var expense in state.oldExpenseList) {
            expenseAmounts[expense.category] =
                (expenseAmounts[expense.category] ?? 0) + expense.amount;
          }

          return BarChart(
            BarChartData(
              barTouchData: barTouchData,
              titlesData: titlesData,
              borderData: borderData,
              barGroups: _createBarGroups(expenseAmounts),
              gridData: const FlGridData(show: false),
              alignment: BarChartAlignment.spaceAround,
              backgroundColor: Color.fromRGBO(27, 35, 57, 1),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  List<BarChartGroupData> _createBarGroups(
    Map<Category, double> expenseAmounts,
  ) {
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            toY: expenseAmounts[Category.food] ?? 0,
            gradient: _barsGradient,
            width: 25,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            toY: expenseAmounts[Category.shopping] ?? 0,
            gradient: _barsGradient,
            width: 25,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
            toY: expenseAmounts[Category.transport] ?? 0,
            gradient: _barsGradient,
            width: 25,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
            toY: expenseAmounts[Category.other] ?? 0,
            gradient: _barsGradient,
            width: 25,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
        showingTooltipIndicators: [0],
      ),
    ];
  }

  BarTouchData get barTouchData => BarTouchData(
    enabled: true,
    touchTooltipData: BarTouchTooltipData(
      getTooltipColor: (group) => Colors.transparent,
      tooltipPadding: EdgeInsets.zero,
      tooltipMargin: 8,
      getTooltipItem: (
        BarChartGroupData group,
        int groupIndex,
        BarChartRodData rod,
        int rodIndex,
      ) {
        return BarTooltipItem(
          '\$${rod.toY.toStringAsFixed(2)}',
          const TextStyle(
            color: Color.fromRGBO(75, 218, 249, 1),
            fontWeight: FontWeight.bold,
          ),
        );
      },
    ),
  );

  Widget getTitles(double value, TitleMeta meta) {
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Column(
          children: [
            Icon(
              Icons.restaurant,
              color: Color.fromRGBO(75, 218, 249, 1),
              size: 30,
            ),
          ],
        );
        break;
      case 1:
        text = Column(
          children: [
            Icon(
              Icons.shopping_bag,
              color: Color.fromRGBO(75, 218, 249, 1),
              size: 30,
            ),
          ],
        );
        break;
      case 2:
        text = Column(
          children: [
            Icon(
              Icons.directions_bus,
              color: Color.fromRGBO(75, 218, 249, 1),
              size: 30,
            ),
          ],
        );
        break;
      case 3:
        text = Column(
          children: [
            Icon(
              Icons.more_horiz,
              color: Color.fromRGBO(75, 218, 249, 1),
              size: 30,
            ),
          ],
        );
        break;
      default:
        text = const Text('');
        break;
    }
    return SideTitleWidget(meta: meta, space: 4, child: text);
  }

  FlTitlesData get titlesData => FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 40,
        getTitlesWidget: getTitles,
      ),
    ),
    leftTitles: AxisTitles(
      axisNameSize: 30,
      sideTitles: SideTitles(
        showTitles: false,
        getTitlesWidget: (double value, TitleMeta meta) {
          return Align(
            alignment: Alignment.center,
            child: Text(
              meta.formattedValue,
              style: TextStyle(
                color: Color.fromRGBO(75, 218, 249, 1),
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    ),
    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
  );

  FlBorderData get borderData => FlBorderData(show: false);

  LinearGradient get _barsGradient => LinearGradient(
    colors: [
      Color.fromRGBO(75, 218, 249, 0.4),
      Color.fromRGBO(75, 218, 249, 1),
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );
}
