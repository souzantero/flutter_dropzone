import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const int count = 8;

  Map<int, DropzoneViewController> controllers = {};
  Map<int, String> messages = {};

  @override
  void initState() {
    super.initState();
    for (int index = 0; index < count; index++)
      messages[index] = 'Drop something here';
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Dropzone example'),
          ),
          body: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    buildZone(context, 0),
                    Center(child: Text(messages[0])),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    buildZone(context, 1),
                    Center(child: Text(messages[1])),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildZone(BuildContext context, int index) => Builder(
        builder: (context) => DropzoneView(
          operation: DragOperation.copy,
          onCreated: (ctrl) => controllers[index] = ctrl,
          onLoaded: () => print('Zone $index loaded'),
          onError: (ev) => print('Zone $index error: $ev'),
          onDrop: (ev) {
            print('Zone $index drop: ${ev.name}');
            setState(() {
              messages[index] = '${ev.name} dropped';
            });
          },
        ),
      );
}
