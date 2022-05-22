import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../database/db_provider.dart';
import '../database/employee_api_call.dart';
import '../models/employee_model.dart';
import 'employee_detailed_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var isLoading = false;
  String userSearchInput = "";
  TextEditingController _searchInputController = TextEditingController();

  List<Employee> allCourses = [];
  List<Employee> items = [];
  bool doItJustOnce = false;

  void _filterList(value) {
    setState(() {
      items = allCourses
          .where(
              (text) => text.name!.toLowerCase().contains(value.toLowerCase()))
          .toList(); // I don't understand your Word list.
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doItJustOnce == false;
    _loadFromApi().then((employee) {
      setState(() {
        allCourses = employee;
        items = allCourses;
      });
    });
  }

  TextField showSearchBar() {
    return TextField(
      autofocus: false,
      enableInteractiveSelection: false,
      controller: _searchInputController,
      onChanged: (value) {
        _filterList(value);
      },
      decoration: const InputDecoration(hintText: "Search"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: doItJustOnce != false
            ? TextField(
                autofocus: false,
                enableInteractiveSelection: false,
                controller: _searchInputController,
                onChanged: (value) {
                  _filterList(value);
                },
                decoration: const InputDecoration(hintText: "Search"),
              )
            : const Text("Employee Listing"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {});
              showSearchBar();
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _buildEmployeeListView(),
    );
  }

  _loadFromApi() async {
    setState(() {
      isLoading = true;
    });

    var apiProvider = EmployeeApiProvider();
    await apiProvider.getAllEmployees();

    // wait for 2 seconds to simulate loading of data
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  _deleteData() async {
    setState(() {
      isLoading = true;
    });

    await DBProvider.db.deleteAllEmployees();

    // wait for 1 second to simulate loading of data
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoading = false;
    });

    print('All employees deleted');
  }

  _buildEmployeeListView() {
    return FutureBuilder(
        future: DBProvider.db.getAllEmployees(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Employee>> snapshot) {
          if (snapshot.hasData) {
            if (!doItJustOnce) {
              //You should define a bool like (bool doItJustOnce = false;) on your state.
              allCourses = snapshot.data!;
              items = allCourses;
              doItJustOnce = !doItJustOnce; //this line helps to do just once.
            }
            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              reverse: false,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EmployeeDetailedPage(
                                  name: items[index].name.toString(),
                                  email: items[index].email.toString(),
                                  phone: items[index].phone.toString(),
                                  username: items[index].username.toString(),
                                  profileImage:
                                      items[index].profileImage.toString(),
                                )));
                  },
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(35.0),
                    child: CachedNetworkImage(
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      imageUrl: items[index].profileImage.toString(),
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error,
                        size: 20,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  // CircleAvatar(
                  //     radius: 30,
                  //     backgroundImage:
                  //         NetworkImage('${items[index].profileImage}')),
                  title: Text("Name: ${items[index].name} "),
                  subtitle: Text('Company Mail: ${items[index].email}'),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
