import 'package:flutter/material.dart';
import 'package:shopzilla/components/cards/ordered_product_card.dart';
import 'package:shopzilla/components/models/order_data.dart';
import 'package:shopzilla/components/other_widgets/detail.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key, required this.orderData});
  final OrderData orderData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white,),

          backgroundColor: Colors.black,
          title: Text(
            'Order Details',
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.white,fontSize: 18),
          )),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(1.25),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.cyan, Colors.black, Colors.cyan])),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Colors.black, Colors.black.withOpacity(0.82)])),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Detail(title: 'Date :  ', value: orderData.date),
                    Detail(title: 'Name :  ', value: orderData.name),
                    Detail(title: 'Mobile no. :  ', mobile: true, value: orderData.mobileNo),
                    Detail(title: 'Email id :  ', value: orderData.emailId),
                    Detail(title: 'Address  :  ', value: orderData.address),
                    Detail(title: 'City :  ', value: orderData.city),
                    Detail(title: 'PinCode :  ', value: orderData.pinCode),
                    Detail(title: 'Amount :  ', value: '${orderData.amount}  INR'),
                    const Detail(title: 'Items :  ', value: ''),
                    Column(
                      children: orderData.items.map((item) => OrderedProductCard(item: item)).toList(),
                    )


                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
