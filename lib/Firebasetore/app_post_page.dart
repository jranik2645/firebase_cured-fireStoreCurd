import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../Utility/uitils.dart';

class AppPostPageFirestore extends StatefulWidget {
  const AppPostPageFirestore({super.key});

  @override
  State<AppPostPageFirestore> createState() => _AppPostPageFirestoreState();
}

class _AppPostPageFirestoreState extends State<AppPostPageFirestore> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    title.dispose();
    description.dispose();
  }

  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  final fireStore = FirebaseFirestore.instance.collection("User");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Data"),
        centerTitle: false,
      ),
      body: Form(
        key: _form,
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your title";
                    }

                    return null;
                  },
                  controller: title,
                  decoration: InputDecoration(
                      labelText: "title",
                      hintText: 'Enter Your title',
                      prefixIcon: Icon(Icons.title),
                      prefixIconColor: Colors.greenAccent,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(width: 1),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  maxLength: 200,
                  maxLines: 5,
                  controller: description,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your description";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Description",
                      hintText: 'Enter Your Description',
                      prefixIcon: Icon(Icons.description),
                      prefixIconColor: Colors.greenAccent,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    if (_form.currentState!.validate()) {
                      var userId =
                          DateTime.now().microsecondsSinceEpoch.toString();

                      fireStore.doc().set({
                        "id": userId.toString(),
                        "title": title.text,
                        "description": description.text,
                      }).then((value) {
                        Utils.successToast("Data Insert Success");
                        Navigator.pop(context);
                      }).onError((error, e) {
                        Utils.failToast(error.toString());
                      });
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        "Continue",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
