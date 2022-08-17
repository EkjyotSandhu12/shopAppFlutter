import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';

import '../models/product.dart';
import '../random_data_generator.dart';

class AddOrEditProductPage extends StatefulWidget {
  const AddOrEditProductPage({Key? key}) : super(key: key);

  static String routeName = "/edit-product-page";

  @override
  State<AddOrEditProductPage> createState() => _AddOrEditProductPageState();
}

class _AddOrEditProductPageState extends State<AddOrEditProductPage> {
  bool valueSet = false;
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController imageController = TextEditingController();
  late ProductsProvider productProvider;
  late Product _editedProduct;

  Future<void> _saveForm() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        if (!productProvider.contains(_editedProduct)) {
          await productProvider.addProduct(_editedProduct);
        } else {
          await productProvider.updateProduct(_editedProduct);
        }

      } catch (e) {
        await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text("Error Occured"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("ok"))
            ],
          ),
        );
      }
      Navigator.of(context).pop();
    }
  }

  @override
  void didChangeDependencies() {
    if (!valueSet) {
      if (ModalRoute.of(context)?.settings.arguments == null) {
        _editedProduct =
            Product(id: "", title: "", description: "", imageUrl: "", price: 0);
      } else {
        _editedProduct = ModalRoute.of(context)?.settings.arguments as Product;
      }

      imageController.text = _editedProduct.imageUrl;
      valueSet = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductsProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: ModalRoute.of(context)?.settings.arguments == null
            ? Text("Add product")
            : Text("Edit Product"),
        actions: [
          IconButton(
            onPressed: () {
              _saveForm();
            },
            icon: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(Icons.save),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextFormField(
                        initialValue: _editedProduct.title,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Product Name!";
                          }
                        },
                        onSaved: (value) {
                          _editedProduct.title = value!;
                        },
                        decoration:
                            InputDecoration(label: Text("Product Name")),
                        textInputAction: TextInputAction.next,
                      ),
                      TextFormField(
                        initialValue: _editedProduct.price.toString(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Product Price!";
                          }
                          if (!value.contains(
                              RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$'))) {
                            return "Only Numbers!";
                          }
                          if (double.parse(value) <= 0) {
                            return "Enter Number greater than 0";
                          }
                        },
                        onSaved: (value) {
                          _editedProduct.price = double.parse(value!);
                        },
                        decoration: InputDecoration(label: Text("Price")),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                      ),
                      TextFormField(
                        initialValue: _editedProduct.description,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Product Description!";
                          }
                        },
                        onSaved: (value) {
                          _editedProduct.description = value!;
                        },
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
                              imageController.text,
                              fit: BoxFit.cover,
                              errorBuilder: (context, object, stackTrace) {
                                return const Center(
                                  child: Text("Enter Url"),
                                );
                              },
                            ),
                          ),
                          Flexible(
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter url";
                                }
                              },
                              onSaved: (value) {
                                _editedProduct.imageUrl = value!;
                              },
                              decoration: InputDecoration(
                                  label: Text("Enter Image Url")),
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.multiline,
                              controller: imageController,
                              onChanged: (_) {
                                setState(() {});
                              },
                              onFieldSubmitted: (_) {
                                _saveForm();
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: ElevatedButton(
                              onPressed: () {
                                imageController.text = RandomData.randomUrl();
                                setState(() {});
                              },
                              child: Text("Generate Random",
                                  textAlign: TextAlign.center),
                              style: ElevatedButton.styleFrom(
                                maximumSize: Size.fromWidth(80),
                                padding: EdgeInsets.all(2),
                              ),
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
