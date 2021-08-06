import 'package:flutter/material.dart';

import '../services/databasehandler.dart';
import '../services/user.dart';

class AllUsers extends StatelessWidget {
  const AllUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.arrow_back,
          ),
          title: Text("All Customers"),
        ),
        body: AllUsersListView());
  }
}

class AllUsersListView extends StatefulWidget {
  AllUsersListView({Key? key}) : super(key: key);

  @override
  _AllUsersListViewState createState() => _AllUsersListViewState();
}

class _AllUsersListViewState extends State<AllUsersListView> {
  late DatabaseHandler handler;

  Future<int> addUsers() async {
    User firstUser =
        User(name: "peter", amount: 2400, email: 'peter@gmail.com');
    User secondUser = User(name: "john", amount: 1200, email: 'jhon@yahoo.com');
    List<User> listOfUsers = [firstUser, secondUser];
    return await this.handler.insertUser(listOfUsers);
  }

  @override
  void initState() {
    super.initState();
    this.handler = DatabaseHandler();
    this.handler.initializeDB().whenComplete(() async {
      await this.addUsers();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: this.handler.retrieveUsers(),
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(Icons.delete_forever),
                  ),
                  key: ValueKey<String>(snapshot.data![index].name),
                  onDismissed: (DismissDirection direction) async {
                    // await this.handler.deleteUser(snapshot.data![index].name!);
                    setState(() {
                      snapshot.data!.remove(snapshot.data![index]);
                    });
                  },
                  child: Card(
                      child: ListTile(
                    contentPadding: EdgeInsets.all(8.0),
                    title: Text(snapshot.data![index].name),
                    subtitle: Text(snapshot.data![index].amount.toString()),
                  )),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
