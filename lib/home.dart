import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopp_design/helpers/utils.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var dropDownValue = 'Select Category';
  double size = 100;
  TextStyle txtStyle = const TextStyle(
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    var categories = ['Select Category'];
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          padding: const EdgeInsets.all(50),
          width: double.infinity,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              'Products List',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'caveat',
              ),
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder(
        future: fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            categories = ['Select Category'];
            List data = jsonDecode(snapshot.data.toString());
            data.forEach((element) {
              if (element['p_category'] != null) {
                categories.add(element['p_category']);
              }
            });
            if (dropDownValue != 'Select Category') {
              data = data
                  .where((element) => element['p_category'] == dropDownValue)
                  .toList();
            }
            categories = categories.toSet().toList();
            print('called');
            print(categories);
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.shopping_cart)),
                    const Spacer(),
                    const Icon(Icons.list),
                    const SizedBox(
                      width: 10,
                    ),
                    DropdownButton(
                        elevation: 10,
                        value: dropDownValue == null ? null : dropDownValue,
                        items: categories.map((e) {
                          return DropdownMenuItem(value: e, child: Text(e));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            if (value!.isNotEmpty) {
                              dropDownValue = value;
                            }
                          });
                          print(value);
                        }),
                  ]),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (ctx, index) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        child: Card(
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Container(
                                  width: size,
                                  height: size,
                                  child: Image.network(
                                    data[index]['p_image'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  width: 130,
                                  height: size,
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    //mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Spacer(),
                                      Text(
                                        data[index]['p_details'].toString() ==
                                                'null'
                                            ? (data[index]['p_name'].toString())
                                            : (data[index]['p_name'] +
                                                " " +
                                                data[index]['p_details']),
                                      ),
                                      const Spacer(),
                                      Text(
                                        data[index]['p_availability']
                                                .toString() +
                                            ' available',
                                        style: txtStyle,
                                      ),
                                      const Spacer(),
                                      Text('₹ ' +
                                          data[index]['p_cost'].toString() +
                                          " / item"),
                                      const Spacer()
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                    padding: EdgeInsets.all(10),
                                    child: IconButton(
                                        icon: const Icon(
                                            Icons.add_shopping_cart_outlined),
                                        onPressed:
                                            data[index]['p_availability'] == 0
                                                ? null
                                                : () {}))
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
