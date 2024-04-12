import 'package:bottom_nav_eexample/path.dart';
import 'package:bottom_nav_eexample/webview/webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter 바인딩 초기화

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  GoRouter get _router => GoRouter(
        initialLocation: NavPath.home.path,
        debugLogDiagnostics: true,
        routes: [
          GoRoute(
            path: NavPath.home.path,
            name: NavPath.home.name,
            builder: (_, state) => const MyHomePage(title: '웹뷰 테스트'),
            routes: [
              GoRoute(
                path: '${NavPath.webview.path}/:url',
                name: NavPath.webview.name,
                builder: (_, state) =>
                    WebViewScreen(url: state.pathParameters['url']!),
              ),
            ],
          ),
        ],
      );
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Rom_Bottom_Nav',
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blueGrey[900],
        useMaterial3: true,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'MSME 웹뷰',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.notifications_sharp)),
            label: 'Worker 웹뷰',
          ),
          // NavigationDestination(
          //   icon: Badge(
          //     label: Text('2'),
          //     child: Icon(Icons.messenger_sharp),
          //   ),
          //   label: 'Messages',
          // ),
        ],
      ),
      body: <Widget>[
        /// Home page
        Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: SizedBox.expand(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Home page',
                    style: theme.textTheme.titleLarge,
                  ),
                  TextButton(
                    onPressed: () {
                      print('@@@');
                      context.goNamed(
                        NavPath.webview.name,
                        pathParameters: {'url': 'https://grab.stg.joob.asia/'},
                      );
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         WebViewScreen(url: 'https://grab.stg.joob.asia/'),
                      //   ),
                      // );
                      // Navigator.pushNamed(context, '/webview',
                      //     arguments: 'https://grab.stg.joob.asia/');
                    },
                    child: Text(
                      '웹뷰 MSME 이동',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        /// Notifications page
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              const Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 1'),
                  subtitle: Text('This is a notification'),
                ),
              ),
              const Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 2'),
                  subtitle: Text('This is a notification'),
                ),
              ),
              Card(
                child: TextButton(
                  onPressed: () {
                    print('!!');
                    context.pushNamed(
                      NavPath.webview.name,
                      pathParameters: {'url': 'https://grab.stg.joob.id/'},
                    );
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) =>
                    //         WebViewScreen(url: 'https://grab.stg.joob.id/'),
                    //   ),
                    // );
                    // Navigator.pushNamed(context, '/webview',
                    //     arguments: 'https://grab.stg.joob.id/');
                  },
                  child: Text('웹뷰 Worker 이동'),
                ),
              ),
            ],
          ),
        ),

        /// Messages page
        ListView.builder(
          reverse: true,
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Hello',
                    style: theme.textTheme.bodyLarge!
                        .copyWith(color: theme.colorScheme.onPrimary),
                  ),
                ),
              );
            }
            return Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Hi!',
                  style: theme.textTheme.bodyLarge!
                      .copyWith(color: theme.colorScheme.onPrimary),
                ),
              ),
            );
          },
        ),
      ][currentPageIndex],
    );
  }
}
