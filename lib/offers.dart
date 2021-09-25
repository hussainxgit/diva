import 'package:flutter/material.dart';
import 'api_response.dart';

class OffersPage extends StatelessWidget {
  const OffersPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getBestSalesData(),
      builder: (context, products) {
        if (products.hasData) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 400,
              childAspectRatio: 3 / 3,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1
            ),
            itemCount: products.data.length,
            itemBuilder: (context, i) {
              return Image(
                image: NetworkImage(products.data[i].image),
              );
            },

          );
        } else if (products.hasError) {
          return Text("${products.error}");
        }
        return const SizedBox(
          height: 60.0,
          child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey,
              )),
        );
      },
    );
  }
}

