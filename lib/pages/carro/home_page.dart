import 'package:carros/drawer_list.dart';
import 'package:carros/pages/carro/carros_api.dart';
import 'package:carros/pages/carro/carros_listview.dart';
import 'package:flutter/material.dart';

import 'carro.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Carros'),
          bottom: const TabBar(
            tabs: [
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
          children: [
            CarrosListView(tipoCarro.classicos),
            CarrosListView(tipoCarro.esportivos),
            CarrosListView(tipoCarro.luxo),
          ],
        ),
        drawer: DrawerList(),
      ),
    );
  }
}
