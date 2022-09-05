import 'package:dcontactoffline/DbHelper.dart';
import 'package:dcontactoffline/viewpage.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class insertpage extends StatefulWidget {

  int? a;
  Map? m;

  insertpage({required this.a, this.m});

  @override
  State<insertpage> createState() => _insertpageState();
}

class _insertpageState extends State<insertpage> {


  Database? db;

      TextEditingController tname = TextEditingController();
      TextEditingController tcontact = TextEditingController();
      TextEditingController temail = TextEditingController();


  @override
  void initState() {
    super.initState();

    DbHelper().createDatabase().then((value)
    {
          db = value;
    }
    );

    if(widget.a == 1)
      {
            tname.text = widget.m!['name'];
            tcontact.text = widget.m!['contact'];
            temail.text = widget.m!['email'];
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 10),

            TextField(
              controller: tname,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                prefixIcon: Icon(Icons.account_circle_rounded),
                prefix: Text("Mr."),
                helperText: "Enter First Character In Capital",
                labelText: "Username",
              ),
            ),

            SizedBox(height: 15),

            TextField(
              controller: tcontact,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                prefixIcon: Icon(Icons.phone),
                labelText: "Contact Number",
              ),
            ),

            // SizedBox(height: 5),

            /*TextField(
              controller: temail,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                prefixIcon: Icon(Icons.email),
                labelText: "Email-Id",
                hintText: "Enter Email-Id",
              ),
            ),*/

            SizedBox(height: 15),

             Center(
              child: (widget.a == 0) ? ElevatedButton(onPressed: () async{

                String name = tname.text;
                String contact = tcontact.text;
                // String email = temail.text;

                String qry ="insert into Test (name,contact) values('$name','$contact')";

                int a = await db!.rawInsert(qry);

                print(a);

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return viewpage();
                },));

              }, child: Text("Save"))
             : ElevatedButton(onPressed: () async{

              String name = tname.text;
              String contact = tcontact.text;
              // String email = temail.text;

              int id = widget.m!['id'];

              String qry ="update Test set name='$name',contact='$contact' where id = '$id'";


              db!.rawUpdate(qry);

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return viewpage();
              },));

            }, child: Text("Update"))
             )],
        ),
      ),
    );
  }
}
