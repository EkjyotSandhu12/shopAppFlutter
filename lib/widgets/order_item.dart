import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/order.dart';

class OrderItem extends StatefulWidget {
  Order orderItem;

  OrderItem({required this.orderItem});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      color: Theme
          .of(context)
          .colorScheme
          .secondary,
      child: Column(
        children: [
          ListTile(
            title: Text("₹ ${widget.orderItem.totalAmount}"),
            leading: Column(
              children: [
                Icon(Icons.shopping_cart_outlined),
                Expanded(
                    child: Text(
                        DateFormat.yMEd().format(widget.orderItem.dateTime))),
                Expanded(
                    child: Text(
                        DateFormat.jm().format(widget.orderItem.dateTime))),
              ],
            ),
            subtitle: Text("Total Products: ${widget.orderItem.items.length}"),
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: () {
                setState(
                      () {
                    _expanded = !_expanded;
                  },
                );
              },
            ),
          ),
          Divider(),
          if (_expanded)
            Container(
                padding: const EdgeInsets.all(15.0),
                height: min(widget.orderItem.items.length * 35, 200),
                child: ListView.builder(
                  itemCount: widget.orderItem.items.length,
                  itemBuilder: (_, index) =>
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text(widget.orderItem.items[index]
                                  .title,),
                            ),
                            Spacer(),
                            Text("x${widget.orderItem.items[index].quantity}"),
                            Spacer(
                              flex: 10,
                            ),
                            Text("₹ ${widget.orderItem.items[index].price.toString()}"),
                          ],
                        ),
                      ),
                )),
        ],
      ),
    );
  }
}
