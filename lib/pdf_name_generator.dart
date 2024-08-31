import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as page;
import 'package:printing/printing.dart';

class PdfNameGenerator extends StatefulWidget {
  @override
  _PdfNameGeneratorState createState() => _PdfNameGeneratorState();
}

class _PdfNameGeneratorState extends State<PdfNameGenerator> {
  final TextEditingController _nameController = TextEditingController();

  void _generatePdf() async {
    final pdf = page.Document();
    pdf.addPage(
      page.Page(
        build: (page.Context context) {
          return page.Center(
            child: page.Text(
              _nameController.text,
              style: page.TextStyle(fontSize: 40),
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Name Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Enter your name',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generatePdf,
              child: Text('Generate PDF'),
            ),
          ],
        ),
      ),
    );
  }
}
