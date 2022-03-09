import 'package:carros/drawer_list.dart';
import 'package:carros/pages/carro/carros_api.dart';
import 'package:carros/pages/carro/carros_listview.dart';
import 'package:carros/pages/carro/carros_page.dart';
import 'package:flutter/material.dart';

import '../../utils/prefs.dart';
import 'carro.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();

    _initTabs();
  }

  _initTabs() async {
    int? tabIdx = await Prefs.getInt("tabIdx");
    _tabController = TabController(length: 3, vsync: this);
    setState(() {
      _tabController?.index = tabIdx;
    });

    _tabController?.addListener(() {
      Prefs.setInt("tabIdx", _tabController!.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carros'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              text: 'Clássicos',
            ),
            Tab(
              text: 'Esportivos',
            ),
            Tab(
              text: 'Luxo',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          CarrosPage(tipoCarro.classicos),
          CarrosPage(tipoCarro.esportivos),
          CarrosPage(tipoCarro.luxo),
        ],
      ),
      drawer: DrawerList(),
    );
  }
}
