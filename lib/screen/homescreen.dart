import 'package:firebase3/Auth/Firebase_services/Authetntication_services.dart';
import 'package:firebase3/Utility/uitils.dart';
import 'package:firebase3/screen/add_post_page.dart';
import 'package:firebase3/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  AuthServices authServices = AuthServices();
  final databaseRef = FirebaseDatabase.instance.ref("User");

  var searchController = TextEditingController();

  var updateTitle =TextEditingController();
  var updateDescription=TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("AppBar"),
        actions: [
          IconButton(
              onPressed: () {
                authServices.signOut().then((value) {
                  Utils.successToast("Logout Success");
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false);
                }).onError((error, e) {
                  Utils.successToast(error.toString());
                });
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                onChanged: (value) {
                  setState(() {});
                },
                controller: searchController,
                decoration: InputDecoration(
                    hintText: 'Searching',
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 30,
                    ),
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
              Expanded(
                child: FirebaseAnimatedList(
                    query: databaseRef,
                    defaultChild: const Center(
                      child: Text("Loading"),
                    ),
                    itemBuilder: (context, snapshot, animation, index) {
                      var title = snapshot.child("title").value.toString();

                      if (searchController.text.isEmpty) {
                        return Card(
                          child: ListTile(
                            onLongPress: (){

                              var userId=snapshot.child("id").toString();
                              updateTitle.text=snapshot.child("title").value.toString();
                              updateDescription.text=snapshot.child("description").value.toString();
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context){
                                    return Container(
                                      width: double.infinity,
                                      height: 400,
                                      decoration: BoxDecoration(
                                         color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                           topRight: Radius.circular(50),
                                           topLeft: Radius.circular(50),
                                        )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
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
                                              controller: updateTitle,
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
                                              controller: updateDescription,
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
                                                databaseRef.child(userId).update({
                                                 "title":updateTitle.text,
                                                  "description":updateDescription.text,
                                                }).then((value){
                                                      Utils.successToast("Update Success");
                                                      Navigator.pop(context);
                                                }).onError((e, error){
                                                       Utils.failToast(e.toString());
                                                  });

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
                                                    "Update",
                                                    style: TextStyle(
                                                      fontSize: 25,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    );
                                  });
                            },


                            leading: CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                            title:
                                Text(snapshot.child("title").value.toString()),
                            subtitle: Text(
                                snapshot.child("description").value.toString()),
                            trailing: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        );
                      } else if (title.toLowerCase().contains(
                          searchController.text.toLowerCase().toString())) {
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                            title:
                                Text(snapshot.child("title").value.toString()),
                            subtitle: Text(
                                snapshot.child("description").value.toString()),

                            trailing: IconButton(onPressed: (){
                              var userId=snapshot.child("id").value.toString();
                              databaseRef.child("UserId").remove().then((value){
                                Utils.successToast("Delete Success");
                              }).onError((error,e){
                                Utils.failToast("Delete Not Success");
                              });
                            },
                                icon: Icon(Icons.delete)),


                          ),
                        );
                      } else {
                        return Container();
                      }
                    }),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => AddPostPage()));
        },
        child: Icon(
          Icons.add,
          size: 30,
          color: Colors.red,
        ),
      ),
    );
  }
}
