import 'package:app_dual/data/data.dart';
import 'package:app_dual/presentation/widgets/ejemplo_widgets.dart';
import 'package:app_dual/presentation/widgets/post_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/locale_provider.dart';
import '../../../l10n/l10n.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Future<void> _refresh() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context)!.appTitle),
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
              title: Text(S.of(context)!.home),
              onTap: () => Navigator.pushReplacementNamed(context, '/'),
            ),
            ListTile(
              leading: const Icon(Icons.create),
              title: Text(S.of(context)!.createPost),
              onTap: () => Navigator.pushNamed(context, '/create'),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(S.of(context)!.profile),
              onTap: () => Navigator.pushNamed(context, '/profile'),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(S.of(context)!.settingsTitle),
              onTap: () => Navigator.pushNamed(context, '/settings'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(S.of(context)!.languageLabel),
              subtitle: DropdownButton<Locale>(
                value: locale ?? Localizations.localeOf(context),
                onChanged: (Locale? newLocale) {
                  ref.read(localeProvider.notifier).state = newLocale;
                },
                items: const [
                  DropdownMenuItem(
                    value: Locale('es'),
                    child: Text('Español 🇪🇸'),
                  ),
                  DropdownMenuItem(
                    value: Locale('en'),
                    child: Text('English 🇺🇸'),
                  ),
                ],
              ),
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
                  SnackBar(
                    content: Text('${S.of(context)!.deleted}: ${card['name']}'),
                  ),
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
