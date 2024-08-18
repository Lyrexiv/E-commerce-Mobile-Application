import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Map<String, String>> notifications = [
    {
      'title': 'Thông báo 1',
      'content': 'Nội dung thông báo 1',
      'hidden': 'false',
    },
    {
      'title': 'Thông báo 2',
      'content': 'Nội dung thông báo 2',
      'hidden': 'false',
    },
    {
      'title': 'Thông báo 3',
      'content': 'Nội dung thông báo 3',
      'hidden': 'false',
    },
  ];

  void _hideNotification(int index) {
    setState(() {
      notifications[index]['hidden'] = 'true';
    });
  }

  void _deleteNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông báo'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          if (notification['hidden'] == 'true') {
            return SizedBox.shrink();
          }
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        notification['title']!,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'hide') {
                            _hideNotification(index);
                          } else if (value == 'delete') {
                            _deleteNotification(index);
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return {'Ẩn thông báo', 'Xóa thông báo'}
                              .map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice == 'Ẩn thông báo' ? 'hide' : 'delete',
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    notification['content']!,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: NotificationPage(),
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
  ));
}
