import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'data.dart';

/// Opens a certificate the right way for its type:
/// link -> browser, image / pdf -> CertificateViewPage.
Future<void> openCertificate(BuildContext context, Certificate cert) async {
  if (cert.type == CertType.link) {
    final ok = await launchUrl(
      Uri.parse(cert.source),
      mode: LaunchMode.externalApplication,
    );
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open the certificate link')),
      );
    }
    return;
  }
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => CertificateViewPage(cert: cert)),
  );
}

class CertificateViewPage extends StatelessWidget {
  final Certificate cert;
  const CertificateViewPage({super.key, required this.cert});

  Widget _missing(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.broken_image, size: 64, color: Colors.white70),
              const SizedBox(height: 12),
              Text(
                'Certificate file not found:\n${cert.source}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      );

  Widget _viewer(BuildContext context) {
    if (cert.type == CertType.pdf) {
      return SfPdfViewer.asset(
        cert.source,
        onDocumentLoadFailed: (details) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not load PDF: ${cert.source}')),
          );
        },
      );
    }
    // Image: pinch to zoom with InteractiveViewer
    return InteractiveViewer(
      minScale: 1,
      maxScale: 6,
      child: Center(
        child: Image.asset(
          cert.source,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => _missing(context),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cert.type == CertType.pdf ? null : Colors.black,
      appBar: AppBar(
        title: Text(cert.course, overflow: TextOverflow.ellipsis),
      ),
      body: _viewer(context),
    );
  }
}
