import 'package:dcontactoffline/DbHelper.dart';
import 'package:dcontactoffline/insertpage.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class viewpage extends StatefulWidget {
  const viewpage({Key? key}) : super(key: key);

  @override
  State<viewpage> createState() => _viewpageState();
}

class _viewpageState extends State<viewpage> {
  List<Map<String, Object?>> l = List.empty(growable: true);

  Database? db;

  bool status = false;

  bool search = false;
  List<Map> temp = [];
  List<Map> rem = [];

  @override
  void initState() {
    super.initState();

    getAllData();
  }

  getAllData() async {
    db = await DbHelper().createDatabase();

    String qry = "select * from Test";

    List<Map<String, Object?>> l1 = await db!.rawQuery(qry);

    temp = l1;
    return l1;
    // l.addAll(l1);

    // status = true;

    // setState(() {
    //   print(l);
    // });
    // return l1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: search
          ? AppBar(
              title: TextField(
                  onChanged: (value) {
                    rem = [];
                    if (value.isEmpty) {
                      rem = temp;
                    } else {
                      for (int i = 0; i < temp.length; i++) {
                        if (temp[i]['name']
                                .toString()
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            temp[i]['contact'].toString().contains(value)) {
                          rem.add(temp[i]);
                        }
                        ;
                      }
                    }
                    setState(() {});
                  },
                  autofocus: true,
                  cursorColor: Colors.black),
              leading: IconButton(
                  onPressed: () {
                    search = false;
                    rem = [];
                    setState(() {});
                  },
                  icon: Icon(Icons.arrow_back_rounded)),
            )
          : AppBar(
              title: Text("Contact Book"),
              actions: [
                IconButton(
                    onPressed: () {
                      search = true;
                      rem = temp;
                      setState(() {});
                    },
                    icon: Icon(Icons.search))
              ],
            ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<Map<String, Object?>> l =
                snapshot.data as List<Map<String, Object?>>;
            if (snapshot.hasData) {
              l = List.from(l);
              l.sort(
                (a, b) => a['name'].toString().compareTo(b['name'].toString()),
              );

              rem = List.from(rem);
              rem.sort(
                (a, b) => a['name'].toString().compareTo(b['name'].toString()),
              );

              return search
                  ? (l.length > 0)
                  ? ListView.builder(
                          itemCount: rem.length,
                          itemBuilder: (context, index) {
                            Map m = rem[index];
                            return ListTile(
                              onTap: () {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                  builder: (context) {
                                    return insertpage(a: 1, m: m);
                                  },
                                ));
                              },
                              onLongPress: () {
                                showDialog(
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Delete"),
                                      content: Text(
                                          "Are You Sure Delete ${m['name']} Is Permantaly Delete"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Cancle",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);

                                              int id = m['id'];

                                              String qry =
                                                  "DELETE FROM Test WHERE id = '$id'";

                                              db!.rawDelete(qry).then((value) {
                                                setState(() {
                                                  l.removeAt(index);
                                                });
                                              });
                                            },
                                            child: Text(
                                              "Delete",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            ))
                                      ],
                                    );
                                  },
                                  context: context,
                                );
                              },
                              // leading: Text("${m['id']}"),
                              leading: Container(
                                height: 55,
                                width: 55,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    shape: BoxShape.circle),
                                child: Text(
                                  "${m['name'].toString().split("")[0]}",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              title: Text("${m['name']}"),
                              subtitle:
                                  Text("${m['contact']}"),
                            );
                          }) :Center(child: Text("No Data Found"))
                      :(l.length > 0) ? ListView.builder(
                          itemCount: l.length,
                          itemBuilder: (context, index) {
                            Map m = l[index];
                            return ListTile(
                              onTap: () {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                  builder: (context) {
                                    return insertpage(a: 1, m: m);
                                  },
                                ));
                              },
                              onLongPress: () {
                                showDialog(
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Delete"),
                                      content: Text(
                                          "Are You Sure Delete ${m['name']} Is Permantaly Delete"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Cancle",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);

                                              int id = m['id'];

                                              String qry =
                                                  "DELETE FROM Test WHERE id = '$id'";

                                              db!.rawDelete(qry).then((value) {
                                                setState(() {
                                                  l.removeAt(index);
                                                });
                                              });
                                            },
                                            child: Text(
                                              "Delete",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            ))
                                      ],
                                    );
                                  },
                                  context: context,
                                );
                              },
                              // leading: Text("${m['id']}"),
                              leading: Container(
                                height: 55,
                                width: 55,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    shape: BoxShape.circle),
                                child: Text(
                                  "${m['name'].toString().split("")[0]}",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              title: Text("${m['name']}"),
                              subtitle: Text("${m['contact']}"),
                            );
                          })
                  : Center(child: Text("No Data Found"));
            }
            else {
              return Center(child: Text("No Data Here..."));
            }
          }
          return Center(child: CircularProgressIndicator());
        },
        future: getAllData(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return insertpage(a: 0);
            },
          ));
        },
        child: Icon(
          Icons.add,
          size: 35,
        ),
      ),
    );
  }
}
