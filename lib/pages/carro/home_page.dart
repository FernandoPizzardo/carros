import 'package:carros/drawer_list.dart';
import 'package:carros/pages/carro/carros_api.dart';
import 'package:carros/pages/carro/carros_listview.dart';
import 'package:carros/pages/carro/carros_page.dart';
import 'package:carros/pages/login/login_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

import '../../utils/prefs.dart';
import 'carro.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();

    _initTabs();
  }

  /*_initTabs() async {
    _tabController = TabController(length: 4, vsync: this);
    _tabController.index = await Prefs.getInt("tabIdx");
    _tabController.addListener(() {
      Prefs.setInt("tabIdx", _tabController.index);
    });
  }*/

  _initTabs() async {
    int index = await Prefs.getInt("tabIdx");

    _tabController = TabController(length: 3, vsync: this);
    setState(() {
      _tabController!.index = index;
    });

    _tabController!.addListener(() {
      Prefs.setInt("tabIdx", _tabController!.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
        bottom: _tabController == null
            ? null
            : TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(
                    text: "Clássicos",
                    icon: Icon(Icons.directions_car),
                  ),
                  Tab(
                    text: "Esportivos",
                    icon: Icon(Icons.directions_car),
                  ),
                  Tab(
                    text: "Luxo",
                    icon: Icon(Icons.directions_car),
                  ),
                ],
              ),
      ),
      body: _tabController == null
          ? null
          : TabBarView(
              controller: _tabController,
              children: [
                CarrosListView(tipoCarro.classicos),
                CarrosListView(tipoCarro.esportivos),
                CarrosListView(tipoCarro.luxo),
              ],
            ),
      drawer: DrawerList(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _onClickAdicionarCarro,
      ),
    );
  }

  void _onClickAdicionarCarro() {
    push(context, LoginPage());
  }
}
