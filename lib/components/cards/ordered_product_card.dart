import 'package:flutter/material.dart';
import 'package:shopzilla/components/models/order_data.dart';
import 'package:shopzilla/components/other_widgets/detail.dart';

class OrderedProductCard extends StatelessWidget {
  const OrderedProductCard({super.key, required this.item});
  final Map<String, dynamic> item;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 3),
      padding: const EdgeInsets.all(1.25),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Colors.black,
                Colors.white,
              ])),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.black, Colors.black.withOpacity(.85)])),
          child: DefaultTextStyle(
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontWeight: FontWeight.w600, color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Detail(title: 'Product :  ', value: item["product"]),
                Detail(
                    title: 'Quantity :  ', value: item["quantity"].toString()),
                Detail(
                  title: 'Price :  ',
                  value: 'INR  ${item["price"]}',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
