import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/utils/color_settings.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DASHBOARD'),
        backgroundColor: ColorSettings.colorPrimary,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Pachuchu'),
              accountEmail: Text('Pachuchu@tuano'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://scontent.fcyw3-1.fna.fbcdn.net/v/t1.6435-9/219586071_4218360068253777_8347528374764391585_n.jpg?_nc_cat=105&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=gYUOfIpsKWMAX_QNVsJ&_nc_ht=scontent.fcyw3-1.fna&oh=6940740293baa88e7bd4f68e50e1052f&oe=616548D1'),
              ),
              decoration: BoxDecoration(color: ColorSettings.colorPrimary),
            ),
            ListTile(
              title: Text('Practica 1'),
              subtitle: Text('Description'),
              leading: Icon(Icons.monetization_on_outlined),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/opcion1');
              },
            )
          ],
        ),
      ),
    );
  }
}
