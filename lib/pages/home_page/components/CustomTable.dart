import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../config/api_routes.dart';
import '../../../models/get_open_trades_response_model.dart';
import '../../../services/network/http_requests.dart';


class CustomTable extends StatefulWidget {
  const CustomTable({Key? key}) : super(key: key);

  @override
  State<CustomTable> createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  List<GetOpenTradesResponseModel> openTrades = [];
  late Timer timer;
  double totalProfit = 0.0;

  Future<void> getOpenTrades() async {
    var openTradesResult = await HttpRequests.postJson(ApiRoutes.getOpenTrades);

    setState(() {
      openTrades = (openTradesResult as List<dynamic>)
          .map((trade) => GetOpenTradesResponseModel.fromMap(trade))
          .toList();
      totalProfit = openTrades.fold(0.0, (sum, trade) => sum + (trade.profit ?? 0.0));
    });

    print("openTrades: $openTrades");
  }


  @override
  void initState() {
    super.initState();
    getOpenTrades();

    // Setup a periodic timer to refresh data every 5 minutes (adjust as needed)
    timer = Timer.periodic(Duration(minutes: 5), (Timer t) {
      getOpenTrades();
    });
  }

  @override
  void dispose() {
    timer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
            ),
            child: DataTable(
              headingRowColor: MaterialStateColor.resolveWith((states) => Color(0xff15212D)),
              columns: [
                DataColumn(
                  label: Text(
                    'Date',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Time',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Ticket',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Volume',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Open Price',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Profit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Comment',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
              rows: openTrades.map((trade) {
                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        '${trade.openTime?.toLocal().toString().split(' ')[0]}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DataCell(
                      Text(
                        '${trade.openTime?.toLocal().toString().split(' ')[1]}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DataCell(
                      Text(
                        '${trade.ticket}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DataCell(
                      Text(
                        '${trade.volume}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DataCell(
                      Text(
                        '\$ ${trade.openPrice}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DataCell(
                      Text(
                        '\$ ${trade.profit}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DataCell(
                      Text(
                        '${trade.comment ?? ""}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),

        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
            ),
          ),
          child: Text(
            'Total Profit: \$ ${totalProfit.toStringAsFixed(2)}',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
