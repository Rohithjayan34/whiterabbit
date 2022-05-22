import 'package:flutter/material.dart';
import '../widgets/common_value_container.dart';
import 'employee_listpage.dart';

class EmployeeDetailedPage extends StatefulWidget {
  final String name;
  final String username;
  final String email;
  final String profileImage;
  final String phone;

  const EmployeeDetailedPage({
    Key? key,
    required this.name,
    required this.username,
    required this.email,
    required this.profileImage,
    required this.phone,
  }) : super(key: key);

  @override
  _EmployeeDetailedPageState createState() => _EmployeeDetailedPageState();
}

class _EmployeeDetailedPageState extends State<EmployeeDetailedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:  IconButton( onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
              HomePage()), (Route<dynamic> route) => false);
        }, icon: const Icon(Icons.arrow_back_ios),),
        title: const Text('Employee Detailed Page'),
        centerTitle: true,
      ),
      body: _buildEmployeeDetailedView(),
    );
  }

  _buildEmployeeDetailedView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            CircleAvatar(
                radius: 80, backgroundImage: NetworkImage(widget.profileImage)),
            const SizedBox(
              height: 40,
            ),
            CommonValueContainer(
              text: 'Name',
              value: widget.name,
            ),
            CommonValueContainer(
              text: 'Email:',
              value: widget.email,
            ),
            CommonValueContainer(text: 'Phone Number:', value: widget.phone),
            CommonValueContainer(
              text: 'User Name:',
              value: widget.username,
            ),
          ],
        ),
      ),
    );
  }
}
