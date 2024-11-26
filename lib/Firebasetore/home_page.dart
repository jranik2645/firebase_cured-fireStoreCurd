import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase3/Firebasetore/app_post_page.dart';
import 'package:firebase3/Utility/uitils.dart';
import 'package:flutter/material.dart';

class HomePageFireStore extends StatefulWidget {
  const HomePageFireStore({super.key});

  @override
  State<HomePageFireStore> createState() => _HomePageFireStoreState();
}

class _HomePageFireStoreState extends State<HomePageFireStore> {
  final fireStoreDataFetch =
      FirebaseFirestore.instance.collection("User").snapshots();

  final fireStore = FirebaseFirestore.instance.collection("User");
  TextEditingController updateTitle = TextEditingController();
  TextEditingController updateDescription = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    updateTitle.dispose();
    updateDescription.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Note"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: fireStoreDataFetch,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Some Error!, Please try aging"),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Card(
                            shadowColor: Colors.blue,
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Icon(Icons.person),
                              ),
                              title: Text(snapshot.data!.docs[index]['title']
                                  .toString()),
                              subtitle: Text(snapshot
                                  .data!.docs[index]['description']
                                  .toString()),
                              trailing: PopupMenuButton(
                                icon: Icon(Icons.more_vert),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: 1,
                                    child: ListTile(
                                      onTap: () async {
                                        Navigator.pop(context);
                                        showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            builder: (context) {
                                              var userId = snapshot
                                                  .data!.docs[index].id
                                                  .toString();
                                              var title = snapshot
                                                  .data!.docs[index]["title"];
                                              updateTitle.text = snapshot
                                                  .data!.docs[index]["title"]
                                                  .toString();
                                              updateDescription.text = snapshot
                                                  .data!
                                                  .docs[index]["description"]
                                                  .toString();

                                              return Container(
                                                  width: double.infinity,
                                                  height: 400,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(50),
                                                        topLeft:
                                                            Radius.circular(50),
                                                      )),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        TextFormField(
                                                          controller:
                                                              updateTitle,
                                                          decoration:
                                                              InputDecoration(
                                                                  labelText:
                                                                      "title",
                                                                  hintText:
                                                                      'Enter Your title',
                                                                  prefixIcon:
                                                                      Icon(Icons
                                                                          .title),
                                                                  prefixIconColor: Colors
                                                                      .greenAccent,
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15),
                                                                    borderSide:
                                                                        BorderSide(
                                                                            width:
                                                                                1),
                                                                  ),
                                                                  errorBorder:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15),
                                                                    borderSide:
                                                                        BorderSide(
                                                                            width:
                                                                                1),
                                                                  ),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15),
                                                                  )),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        TextFormField(
                                                          maxLength: 200,
                                                          maxLines: 5,
                                                          controller:
                                                              updateDescription,
                                                          decoration:
                                                              InputDecoration(
                                                                  labelText:
                                                                      "Description",
                                                                  hintText:
                                                                      'Enter Your Description',
                                                                  prefixIcon:
                                                                      Icon(Icons
                                                                          .description),
                                                                  prefixIconColor:
                                                                      Colors
                                                                          .greenAccent,
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    borderSide:
                                                                        BorderSide(
                                                                            width:
                                                                                1),
                                                                  ),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  )),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            fireStore
                                                                .doc(userId)
                                                                .update({
                                                              'title':
                                                                  updateTitle
                                                                      .text,
                                                              "description":
                                                                  updateDescription
                                                                      .text,
                                                            }).then((value) {
                                                              Utils.successToast(
                                                                  "Data is update");
                                                              Navigator.pop(
                                                                  context);
                                                            }).onError(
                                                                    (error, e) {
                                                              Utils.failToast(
                                                                  'data not updated');
                                                              Navigator.pop(
                                                                  context);
                                                            });
                                                          },
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.blue,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                            child: const Center(
                                                              child: Text(
                                                                "Update",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 25,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ));
                                            });
                                      },
                                      leading: Icon(Icons.edit),
                                      title: Text('Edit'),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 2,
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.pop(context);
                                        var userId = snapshot
                                            .data!.docs[index].id
                                            .toString();
                                        fireStore
                                            .doc(userId)
                                            .delete()
                                            .then((value) {
                                          Utils.successToast("DATA is Deleted");

                                        }).onError((error, e) {
                                          Utils.failToast("data is problem");
                                        });
                                      },
                                      leading: Icon(Icons.delete),
                                      title: Text('Delete'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AppPostPageFirestore()));
        },
        child: Text("Add"),
      ),
    );
  }
}
