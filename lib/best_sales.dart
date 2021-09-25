import 'package:flutter/material.dart';
import 'apiResponse.dart';
import 'productView.dart';

class BestSales extends StatelessWidget {
  const BestSales({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getBestSalesData(),
      builder: (context, products) {
        if (products.hasData) {
          return ListView.separated(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: products.data.length,
            itemBuilder: (context, i) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: ListTile(
                  leading: Image.network(products.data[i].image),
                  title: Text(
                    products.data[i].name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Droid',
                    ),
                  ),
                  subtitle: Text(products.data[i].description,
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'Droid',
                      )),
                  trailing: TextButton(
                      child: Text("طلب".toUpperCase(),
                          style: const TextStyle(fontSize: 14, fontFamily: "Droid")),
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(5.0)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(color: Colors.red)))),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          fullscreenDialog: false,
                          builder: (context) => ProductSelect(
                            passedProduct: products.data[i],
                          ),
                        ));
                      }),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      fullscreenDialog: false,
                      builder: (context) => ProductSelect(
                        passedProduct: products.data[i],
                      ),
                    ));
                  },
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
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
