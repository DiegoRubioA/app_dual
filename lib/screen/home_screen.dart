import 'package:app_dual/data/data.dart';
import 'package:app_dual/Widgets/ejemplo_widgets.dart';
import 'package:app_dual/Widgets/post_search.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _refresh() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        backgroundColor: Colors.yellow,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: PostSearchDelegate(listCard),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menú',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              onTap: () => Navigator.pushReplacementNamed(context, '/'),
            ),
            ListTile(
              leading: const Icon(Icons.create),
              title: const Text('Crear Publicación'),
              onTap: () => Navigator.pushNamed(context, '/create'),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Mi Perfil'),
              onTap: () => Navigator.pushNamed(context, '/profile'),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuración'),
              onTap: () => Navigator.pushNamed(context, '/settings'),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.builder(
          itemCount: listCard.length,
          itemBuilder: (context, index) {
            final card = listCard[index];
            return Dismissible(
              key: ValueKey(card['name']! + index.toString()),
              direction: DismissDirection.endToStart,
              onDismissed: (_) {
                setState(() {
                  listCard.removeAt(index);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Eliminado: ${card['name']}')),
                );
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              child: Carfeed(
                card: card,
                onTap: () async {
                  await Navigator.pushNamed(
                    context,
                    '/details',
                    arguments: card,
                  );
                  setState(() {}); // para refrescar cuando vuelva
                },
              ),
            );
          },
        ),
      ),
      backgroundColor: Colors.green[300],
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // pushNamed sin genérico devuelve Object?
          final result =
              await Navigator.pushNamed(context, '/create')
                  as Map<String, String>?;
          if (result != null) {
            setState(() {
              listCard.insert(0, result);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
