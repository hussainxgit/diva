import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'services/api_response.dart';
import 'product_view.dart';
import 'Models/product.dart';
import 'Models/categories.dart';

class SelectCategoryItems extends StatelessWidget {
  const SelectCategoryItems({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Categories category = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      //appBar: CustomAppBar(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            backgroundColor: Colors.black45,
            expandedHeight: 400.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Row(
                children: [
                  Expanded(
                    child: Container(
                        child: Text(
                          category.name,
                          style: const TextStyle(
                            fontFamily: 'Droid',
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.end,
                        ),
                        //color: Colors.redAccent,
                        margin: const EdgeInsets.only(right: 10)),
                  )
                ],
              ),
              background: Image.network(
                category.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          FutureBuilder<List<Product>>(
            future: getProductByCatId(category.id),
            builder: (context, AsyncSnapshot<List<Product>> products) {
              var childCount = 0;
              if (products.connectionState != ConnectionState.done ||
                  products.hasData == null) {
                childCount = 1;
              } else {
                childCount = products.data.length;
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate((context, i) {
                  if (products.connectionState != ConnectionState.done) {
                    return const Center(
                        child: Padding(
                      padding: EdgeInsets.all(18.0),
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.grey,
                      ),
                    ));
                  }
                  if (products.hasData == null) {
                    return const Center(
                        child: Text('none'));
                  }
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
                                style: const TextStyle(
                                    fontSize: 14, fontFamily: "Droid")),
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.all(5.0)),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.red),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: const BorderSide(color: Colors.red)))),
                            onPressed: () {
                              Product product = Product(
                                  id: products.data[i].id,
                                  name: products.data[i].name,
                                  description: products.data[i].description,
                                  image: products.data[i].image,
                                  price: products.data[i].price,
                                  addons: products.data[i].addons);

                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ProductSelect(
                                  passedProduct: product,
                                ),
                              ));
                            }),
                        onTap: () {
                          Product product = Product(
                              id: products.data[i].id,
                              name: products.data[i].name,
                              description: products.data[i].description,
                              image: products.data[i].image,
                              price: products.data[i].price,
                              addons: products.data[i].addons);
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProductSelect(
                              passedProduct: product,
                            ),
                          ));
                        },
                      ));
                }, childCount: childCount),
              );
            },
          ),
        ],
      ),
    );
  }
}
