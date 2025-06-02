import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:idp_app/component/dashboardAdmin.dart';
import 'package:idp_app/fucn_admin/dosen/brnd_ClientDosen.dart';
import 'package:idp_app/fucn_admin/dosen/kendali_tokenDsn.dart';
import 'package:idp_app/fucn_admin/dosen/list_tokenDsn.dart';
import 'package:idp_app/fucn_admin/dosen/list_userdsn.dart';
import 'package:idp_app/fucn_admin/list_tokenMhs.dart';
import 'package:idp_app/fucn_admin/list_usermhs.dart';
import 'package:idp_app/pages/admin.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:sizer/sizer.dart';
import 'package:idp_app/core/res/color.dart';
import 'package:idp_app/widgets/circle_gradient_icon.dart';
import 'package:idp_app/widgets/task_group.dart';

import '../fucn_admin/kendali_tokenMhs.dart';

class brndAdminDsn extends StatefulWidget {
  const brndAdminDsn({Key key}) : super(key: key);

  @override
  State<brndAdminDsn> createState() => _brndAdminDsnState();
}

class _brndAdminDsnState extends State<brndAdminDsn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 83, 192),
        title: Text("Management User Dosen",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => adminPage()),
            );
          },
          icon: Icon(LineAwesomeIcons.angle_left),
        ),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.pushReplacement(
        //         context, MaterialPageRoute(builder: (context) => adminPage()));
        //   },
        // ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 20),
        //     child: CircleGradientIcon(
        //       onTap: () {
        //         // Navigator.pushNamed(context, Routes.todaysTask);
        //       },
        //       icon: Icons.calendar_month,
        //       color: Colors.purple,
        //       iconSize: 24,
        //       size: 40,
        //     ),
        //   )
        // ],
      ),
      extendBody: true,
      body: _buildBody(),
    );
  }

  Stack _buildBody() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                _taskHeader(),
                const SizedBox(
                  height: 15,
                ),
                buildGrid(),
                const SizedBox(
                  height: 25,
                ),
                // _onGoingHeader(),
                // const SizedBox(
                //   height: 10,
                // ),
                // const OnGoingTask(),
                // const SizedBox(
                //   height: 40,
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row _taskHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SelectableText(
          "User Dosen",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
          toolbarOptions: const ToolbarOptions(
            copy: true,
            selectAll: true,
          ),
        ),
      ],
    );
  }

  void _navigateToPage(BuildContext context, String pageName) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => dashboard()),
    );
  }

  StaggeredGrid buildGrid() {
    return StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      children: [
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1.3,
          child: InkWell(
            onTap: () {
              // Handle tile press here
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => adminDsn()),
              );
            },
            child: TaskGroupContainer(
              color: Colors.pink,
              icon: Icons.menu_book_rounded,
              taskCount: 10,
              taskGroup: "List User Dosen",
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: InkWell(
            onTap: () {
              // Handle tile press here
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => adminTokenDsn()),
              );
            },
            child: TaskGroupContainer(
              color: Colors.orange,
              isSmall: true,
              icon: Icons.mobile_friendly,
              taskCount: 5,
              taskGroup: "Refresh Token Aktif",
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1.3,
          child: InkWell(
            onTap: () {
              // Handle tile press here
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => kendaliTokenDsn()),
              );
            },
            child: TaskGroupContainer(
              color: Colors.green,
              icon: Icons.article,
              taskCount: 2,
              taskGroup: "Kendali Acces Token",
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => brndClientDosen()),
              );
            },
            child: TaskGroupContainer(
              color: Colors.blue,
              isSmall: true,
              icon: SimpleIcons.countingworkspro,
              taskCount: 9,
              taskGroup: "Client SSO Dosen",
            ),
          ),
        ),
      ],
    );
  }
}
