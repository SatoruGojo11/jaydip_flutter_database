import 'package:flutter/material.dart';
import 'package:jaydip_flutter_database/APICalling/ServicesClass.dart';
import 'ModelClass.dart';

class UserApi extends StatefulWidget {
  const UserApi({super.key});

  @override
  State<UserApi> createState() => _UserApiState();
}

class _UserApiState extends State<UserApi> {
  UserServices services = UserServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Getting Data'),
      ),
      body: Center(
        child: FutureBuilder(
          future: services.getData(),
          builder: (context, snapShot) {
            print('Main Screen');
            if (snapShot.hasData) {
              List<UsersModel> dataList = snapShot.data! as List<UsersModel>;
              return ListView.separated(
                itemCount: dataList.length,
                separatorBuilder: (context, index) => Divider(thickness: 3),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Text('${dataList[index].id.toString()}'),
                    title:
                        Text('Name :- ${dataList[index].firstname.toString()}'),
                    subtitle: Text(
                        'Phone No. :- ${dataList[index].phone.toString()}'),
                  );
                },
              );
            } else {
              return CircularProgressIndicator(color: Colors.red);
            }
          },
        ),
      ),
    );
  }
}
