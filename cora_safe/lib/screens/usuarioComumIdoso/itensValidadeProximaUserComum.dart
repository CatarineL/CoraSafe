import 'package:flutter/material.dart';

class itensValidadeProximaUserComum extends StatelessWidget {
  itensValidadeProximaUserComum({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Itens com valildade próxima",
        style: TextStyle(color: Colors.white, fontSize: 18)),
        backgroundColor: Colors.redAccent[400],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [

            SearchAnchor(
            builder: (BuildContext context, SearchController controller) {
            return SearchBar(
            controller: controller,
            padding: const WidgetStatePropertyAll<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 16.0),
            ),
            onTap: () {
            controller.openView();
            },
            onChanged: (_) {
            controller.openView();
            },
            leading: const Icon(Icons.search),
            trailing: <Widget>[
//                   Tooltip(
// //                     message: 'Change brightness mode',
// //                     child: IconButton(
// //                       isSelected: isDark,
// //                       onPressed: () {
// //                         setState(() {
// //                           isDark = !isDark;
// //                         });
// //                       },
//                       //icon: const Icon(Icons.wb_sunny_outlined),
//                       selectedIcon: const Icon(Icons.brightness_2_outlined),
//                     ),
//                   ),
      ],
      );
      },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          return List<ListTile>.generate(5, (int index) {
            final String item = 'item $index';
            return ListTile(
              title: Text(item),
              onTap: () {
                // setState(() {
                //   controller.closeView(item);
                // });
              },
            );
          });
        },
      ),
      ],
    ),
      ),
    );
  }
}


