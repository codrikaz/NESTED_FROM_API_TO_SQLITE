import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nested_to_sqlite/DatabaseHelper.dart';
import 'package:nested_to_sqlite/User.dart';
import 'package:nested_to_sqlite/constants.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<User> userList = [];
  final DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async{
    await getUsers();
    await getUserrData();
  }

  Future<void> getUsers() async {
    var url = Uri.parse("https://jsonplaceholder.typicode.com/users");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      setState(() {
        // userList = jsonData.map((data) => User.fromJson(data)).toList();
        print("TTTTTTDATA ${userList.toList()}");
      });
    } else {}
  }

  Future<void> getUserrData() async {
    userList.assignAll( await databaseHelper.getUserDatabase("select * from user_table"));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
            const EdgeInsets.only(top: 5, bottom: 5, left: 12, right: 12),
            child: Container(
              width: 300,

              decoration: Constant.userPageContainer,
              child: Column(
                children: [
                  Constant.height1,
                  //ID,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //id
                      Text(
                        'id : ',
                        style: Constant.userPageText,
                      ),
                      Text(
                        userList[index].id.toString(),
                        style: Constant.userPageText,
                      ),
                    ],
                  ),
                  //Name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Constant.height2,
                      Text(
                        'Name : ',
                        style: Constant.userPageText,
                      ),
                      //name
                      Text(
                        userList[index].name,
                        style: Constant.userPageText,
                      ),
                      Constant.width3,
                      //username
                      Text('Username : ', style: Constant.userPageText),
                      Flexible(
                        child: Text(
                          userList[index].username,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Constant.height2,
                  //Email
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //id
                      Text(
                        'email : ',
                        style: Constant.userPageText,
                      ),
                      Text(
                        userList[index].email,
                        style: Constant.userPageText,
                      ),
                    ],
                  ),
                  //
                  //Address
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //id
                      Text(
                        'address : ',
                        style: Constant.userPageText,
                      ),
                      Text(
                        userList[index].address.street,
                        style: Constant.userPageText,
                      ),
                      Constant.width1,
                      Text(
                        userList[index].address.city,
                        style: Constant.userPageText,
                      ),
                      Constant.width1,
                      Text(
                        userList[index].address.suite,
                        style: Constant.userPageText,
                      ),
                    ],
                  ),
                  //ZipCode and Coordinates
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        userList[index].address.zipcode,
                        style: Constant.userPageText,
                      ),
                      Constant.width1,
                      Text(
                        "lat: ${userList[index].address.geo.lat},",
                        style: Constant.userPageText,
                      ),
                      Constant.width1,
                      Text(
                        "long: ${userList[index].address.geo.lng},",
                        style: Constant.userPageText,
                      ),
                      Constant.width1,
                    ],
                  ),
                  Constant.height2,
                  //phone number
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'phone : ',
                        style: Constant.userPageText,
                      ),
                      Text(
                        userList[index].phone,
                        style: Constant.userPageText,
                      ),
                    ],
                  ),
                  //Website
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //id
                      Text(
                        'website : ',
                        style: Constant.userPageText,
                      ),
                      Text(
                        userList[index].website,
                        style: Constant.userPageText,
                      ),
                    ],
                  ),
                  //Company
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //id
                      Text(
                        'Company : ',
                        style: Constant.userPageText,
                      ),
                      Text(
                        userList[index].company.name,
                        style: Constant.userPageText,
                      ),
                    ],
                  ),
                  //Company description
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          "${userList[index].company.catchPhrase} ${userList[index].company.bs} ",
                          textAlign: TextAlign.center,
                          style: Constant.userPageText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
