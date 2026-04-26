import 'package:flutter/material.dart';

class visualizacaoDispensaUserComum extends StatelessWidget {
  visualizacaoDispensaUserComum({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dispensa Atual",
        style: TextStyle(color: Colors.white, fontSize: 18)),
        backgroundColor: Colors.black26,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            // SizedBox(height: 20,),
            // Divider(),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => visualizacaoDispensaUserComum(),
                  //   ),
                  // );
                },
                icon: const Icon(Icons.edit),
                //icon: const Icon(Icons.delete),
                label: Text("FRUT MAMAO FORM PICFAT", style: TextStyle(fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  alignment: Alignment.center,
                  iconAlignment: IconAlignment.end,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
      );
  }
}