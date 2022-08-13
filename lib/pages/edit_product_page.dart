import 'package:flutter/material.dart';

import '../models/product.dart';

class EditProductPage extends StatefulWidget {
  const EditProductPage({Key? key}) : super(key: key);

  static String routeName = "/edit-product-page";

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {

  TextEditingController imageController = TextEditingController();

  Product _editedProduct = Product(id: "", title: "", description: "", imageUrl: "", price: 0);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.done)),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextFormField(
                  decoration: InputDecoration(label: Text("Product Name")),
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  decoration: InputDecoration(label: Text("Price")),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  decoration: InputDecoration(label: Text("Description")),
                  textInputAction: TextInputAction.next,
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                        color: Colors.black,
                          width: 2,
                        ),
                      ),
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.width * 0.3,
                      child: Image.network(
                          imageController.text, fit: BoxFit.cover,
                      errorBuilder: (context, object, stackTrace){
                           return Text("Enter Url");
                       },
                      ),
                    ),
                    Flexible(
                      child: TextFormField(
                        decoration: InputDecoration(label: Text("Image")),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.multiline,
                        controller: imageController,
                        onChanged: (_){
                          print("done");
                          setState(() {
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
