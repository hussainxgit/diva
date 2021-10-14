import 'package:flutter/material.dart';
import 'services/api_response.dart';
import 'package:diva/Models/categories.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCategoriesData(),
      builder: (context, categories) {
        if (categories.hasData) {
          return SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.data.length, // نحدد العدد للايتم بلدر
                itemBuilder: (context, i) {
                  // ندخلها بالبلدر علشان اللوب
                  return InkWell(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                      padding: const EdgeInsets.all(5.0),
                      alignment: Alignment.center,
                      width: 130,
                      decoration: BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.rectangle,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                            bottomRight: Radius.circular(15.0),
                            bottomLeft: Radius.circular(15.0),
                          ),
                          image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.6),
                                  BlendMode.dstATop),
                              image: NetworkImage(categories.data[i].image),
                              fit: BoxFit.cover)),
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: Text(categories.data[i].name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Droid',
                              fontSize: 18,
                            )),
                      ),
                    ),
                    onTap: () {
                      Categories category = categories.data[i];
                      Navigator.of(context)
                          .pushNamed('selectCategory', arguments: category);
                    },
                  );
                },
              ));
        } else if (categories.hasError) {
          return Text("${categories.error}");
        }

        // By default, show a loading spinner.
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
