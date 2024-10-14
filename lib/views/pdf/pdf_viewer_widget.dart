import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerWidget extends StatefulWidget {
  final String url;

  const PdfViewerWidget({Key? key, required this.url}) : super(key: key);

  @override
  _PdfViewerWidgetState createState() => _PdfViewerWidgetState();
}

class _PdfViewerWidgetState extends State<PdfViewerWidget> {
  late PdfViewerController _pdfViewerController;
  int _currentPage = 0;
  int _totalPages = 0;

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
    _pdfViewerController.addListener(_onPageChanged);
  }

  void _onPageChanged() {
    setState(() {
      _currentPage = _pdfViewerController.pageNumber;
      _totalPages = _pdfViewerController.pageCount;
    });
  }

  @override
  void dispose() {
    _pdfViewerController.removeListener(_onPageChanged);
    _pdfViewerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3E5799),
        title: Text('PDF Viewer'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '$_currentPage / $_totalPages',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
      body: SfPdfViewer.network(widget.url,
          controller: _pdfViewerController, initialZoomLevel: 1.4),
    );
  }
}
