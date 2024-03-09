import 'package:flutter/material.dart';
import 'package:flutter_happiness_poc/common/theme.dart';
import 'package:flutter_happiness_poc/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer(this.currentPage);

  final String currentPage;

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthService>(context, listen: true);
    return Drawer(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: [
                Container(
                  color: raisinBlack,
                  child: DrawerHeader(
                      child: Center(
                    child: Text(
                      'Happiness Flow',
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                  )),
                ),
                ListTile(
                  title: Text(
                    "Home pagina",
                    style: currentPage == 'Home'
                        ? TextStyle(
                            fontWeight: FontWeight.bold, color: oceanGreen)
                        : TextStyle(
                            fontWeight: FontWeight.normal, color: raisinBlack),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_sharp,
                      color: currentPage == 'Home' ? oceanGreen : raisinBlack),
                  selected: currentPage == 'Home',
                  onTap: () {
                    Navigator.of(context).pop();
                    if (currentPage != 'Home')
                      Navigator.of(context).pushReplacementNamed('/home');
                  },
                ),
                Divider(
                  height: 1,
                  color: raisinBlack,
                ),
                ListTile(
                  title: Text(
                    "Geschiedenis pagina",
                    style: currentPage == 'History'
                        ? TextStyle(
                            fontWeight: FontWeight.bold, color: oceanGreen)
                        : TextStyle(
                            fontWeight: FontWeight.normal, color: raisinBlack),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_sharp,
                      color:
                          currentPage == 'History' ? oceanGreen : raisinBlack),
                  selected: currentPage == 'History',
                  onTap: () {
                    Navigator.of(context).pop();
                    if (currentPage != 'History')
                      Navigator.of(context).pushReplacementNamed('/history');
                  },
                ),
                Divider(
                  height: 1,
                  color: raisinBlack,
                ),
                ListTile(
                  title: Text(
                    "Gesprek aanvragen",
                    style: currentPage == 'Conversation'
                        ? TextStyle(
                            fontWeight: FontWeight.bold, color: oceanGreen)
                        : TextStyle(
                            fontWeight: FontWeight.normal, color: raisinBlack),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_sharp,
                      color: currentPage == 'Conversation'
                          ? oceanGreen
                          : raisinBlack),
                  selected: currentPage == 'Conversation',
                  onTap: () {
                    Navigator.of(context).pop();
                    if (currentPage != 'Conversation')
                      Navigator.of(context)
                          .pushReplacementNamed('/conversation');
                  },
                ),
                Divider(
                  height: 1,
                  color: raisinBlack,
                ),
              ],
            ),
            Column(
              children: [
                Divider(
                  height: 1,
                  color: raisinBlack,
                ),
                ListTile(
                  title: Text(
                    "Logout",
                    style: TextStyle(
                        fontWeight: FontWeight.normal, color: raisinBlack),
                  ),
                  trailing: Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();

                    _auth.logout();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
