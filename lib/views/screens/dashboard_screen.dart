import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_web_ptb/constants/dimens.dart';
import 'package:flutter_web_ptb/theme/theme_extensions/app_button_theme.dart';
import 'package:flutter_web_ptb/theme/theme_extensions/app_color_scheme.dart';
import 'package:flutter_web_ptb/theme/theme_extensions/app_data_table_theme.dart';
import 'package:flutter_web_ptb/views/widgets/card_elements.dart';
import 'package:flutter_web_ptb/views/widgets/portal_master_layout/portal_master_layout.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _dataTableHorizontalScrollController = ScrollController();

  @override
  void dispose() {
    _dataTableHorizontalScrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final lang = Lang.of(context);
    final themeData = Theme.of(context);
    final appColorScheme = Theme.of(context).extension<AppColorScheme>()!;
    final appDataTableTheme = Theme.of(context).extension<AppDataTableTheme>()!;
    final size = MediaQuery.of(context).size;

    final summaryCardCrossAxisCount = (size.width >= kScreenWidthLg ? 4 : 2);

    return PortalMasterLayout(
      body: ListView(
        padding: const EdgeInsets.all(kDefaultPadding),
        children: [
          Card(
            child: Row(
              children: [
                Text(
                  'Dashboard',
                  style: themeData.textTheme.headlineMedium,
                ),
                Text(
                  'Akun',
                  style: themeData.textTheme.headlineMedium,
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final summaryCardWidth = ((constraints.maxWidth -
                        (kDefaultPadding * (summaryCardCrossAxisCount - 1))) /
                    summaryCardCrossAxisCount);

                return Wrap(
                  direction: Axis.horizontal,
                  spacing: kDefaultPadding,
                  runSpacing: kDefaultPadding,
                  children: [
                    SummaryCard(
                      title: 'New Order',
                      value: '150',
                      icon: Icons.shopping_cart_rounded,
                      backgroundColor: appColorScheme.info,
                      textColor: themeData.colorScheme.onPrimary,
                      iconColor: Colors.black12,
                      width: summaryCardWidth,
                    ),
                    SummaryCard(
                      title: 'Today Sales',
                      value: '+12%',
                      icon: Icons.ssid_chart_rounded,
                      backgroundColor: appColorScheme.success,
                      textColor: themeData.colorScheme.onPrimary,
                      iconColor: Colors.black12,
                      width: summaryCardWidth,
                    ),
                    SummaryCard(
                      title: 'New Users',
                      value: '44',
                      icon: Icons.group_add_rounded,
                      backgroundColor: appColorScheme.warning,
                      textColor: appColorScheme.buttonTextBlack,
                      iconColor: Colors.black12,
                      width: summaryCardWidth,
                    ),
                    SummaryCard(
                      title: 'Pending Issue',
                      value: '0',
                      icon: Icons.report_gmailerrorred_rounded,
                      backgroundColor: appColorScheme.error,
                      textColor: themeData.colorScheme.onPrimary,
                      iconColor: Colors.black12,
                      width: summaryCardWidth,
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: kDefaultPadding),
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CardHeader(
                    title: 'Recent Orders',
                    showDivider: false,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final double dataTableWidth =
                            max(kScreenWidthMd, constraints.maxWidth);

                        return Scrollbar(
                          controller: _dataTableHorizontalScrollController,
                          thumbVisibility: true,
                          trackVisibility: true,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            controller: _dataTableHorizontalScrollController,
                            child: SizedBox(
                              width: dataTableWidth,
                              child: Theme(
                                data: themeData.copyWith(
                                  cardTheme: appDataTableTheme.cardTheme,
                                  dataTableTheme:
                                      appDataTableTheme.dataTableThemeData,
                                ),
                                child: DataTable(
                                  showCheckboxColumn: false,
                                  showBottomBorder: true,
                                  columns: const [
                                    DataColumn(
                                        label: Text('No.'), numeric: true),
                                    DataColumn(label: Text('Date')),
                                    DataColumn(label: Text('Item')),
                                    DataColumn(
                                        label: Text('Price'), numeric: true),
                                  ],
                                  rows: List.generate(5, (index) {
                                    return DataRow.byIndex(
                                      index: index,
                                      cells: [
                                        DataCell(Text('#${index + 1}')),
                                        const DataCell(Text('2022-06-30')),
                                        DataCell(Text('Item ${index + 1}')),
                                        DataCell(
                                            Text('${Random().nextInt(10000)}')),
                                      ],
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      child: SizedBox(
                        height: 40.0,
                        width: 120.0,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: themeData
                              .extension<AppButtonTheme>()!
                              .infoElevated,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: kDefaultPadding * 0.5),
                                child: Icon(
                                  Icons.visibility_rounded,
                                  size: (themeData
                                          .textTheme.labelLarge!.fontSize! +
                                      4.0),
                                ),
                              ),
                              const Text('View All'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final double width;

  const SummaryCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.backgroundColor,
    required this.textColor,
    required this.iconColor,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 120.0,
      width: width,
      child: Card(
        clipBehavior: Clip.antiAlias,
        color: backgroundColor,
        child: Stack(
          children: [
            Positioned(
              top: kDefaultPadding * 0.5,
              right: kDefaultPadding * 0.5,
              child: Icon(
                icon,
                size: 80.0,
                color: iconColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: kDefaultPadding * 0.5),
                    child: Text(
                      value,
                      style: textTheme.headlineMedium!.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    title,
                    style: textTheme.labelLarge!.copyWith(
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
