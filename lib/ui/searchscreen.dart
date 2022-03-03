import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const String id = 'searchscreen';
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? inputText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              onChanged: (val) {
                setState(() {
                  inputText = val;
                  print(inputText);
                });
              },
              decoration: InputDecoration(
                hintText: 'Search Product Here',
              ),
            ),
            Expanded(
              child: Container(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('products')
                        .where('product-name', isEqualTo: inputText)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Something is worng'),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Text('Loading'),
                        );
                      }
                      return ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          return Card(
                            child: ListTile(
                              title: Text(data['product-name']),
                              leading: Image.network(data['product-img'][0]),
                            ),
                          );
                        }).toList(),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
