import 'package:flutter/material.dart';
import '../../../../models/company/financial_data_model.dart';

class FinancialTableWidget extends StatefulWidget {
  final String title;
  final FinancialDataModel data;

  const FinancialTableWidget({
    super.key,
    required this.title,
    required this.data,
  });

  @override
  State<FinancialTableWidget> createState() => _FinancialTableWidgetState();
}

class _FinancialTableWidgetState extends State<FinancialTableWidget> {
  final ScrollController _horizontalController = ScrollController();

  @override
  Widget build(BuildContext context) {
    if (widget.data.headers.isEmpty || widget.data.body.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('No data available'),
        ),
      );
    }

    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Table Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.table_chart,
                  color: Theme.of(context).primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                ),
              ],
            ),
          ),

          // Scrollable Table
          Scrollbar(
            controller: _horizontalController,
            child: SingleChildScrollView(
              controller: _horizontalController,
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 20,
                horizontalMargin: 16,
                headingRowHeight: 50,
                dataRowHeight: 45,
                headingTextStyle:
                    Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                columns: [
                  const DataColumn(
                    label: Text('Description'),
                  ),
                  ...widget.data.headers.map((header) => DataColumn(
                        label: Container(
                          constraints: const BoxConstraints(minWidth: 80),
                          child: Text(
                            header,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )),
                ],
                rows: widget.data.body.map((row) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Container(
                          constraints: const BoxConstraints(minWidth: 150),
                          child: Text(
                            row.description,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ),
                      ),
                      ...row.values.map((value) => DataCell(
                            Container(
                              constraints: const BoxConstraints(minWidth: 80),
                              child: Text(
                                value,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: _getValueColor(value),
                                    ),
                              ),
                            ),
                          )),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color? _getValueColor(String value) {
    if (value.startsWith('-')) {
      return Colors.red[600];
    } else if (value.contains('%') && value.startsWith('+')) {
      return Colors.green[600];
    }
    return null;
  }

  @override
  void dispose() {
    _horizontalController.dispose();
    super.dispose();
  }
}
