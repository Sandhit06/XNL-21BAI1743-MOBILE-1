import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  bool _cameraPermissionGranted = false;

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  //  Request Camera Permission
  Future<void> _requestCameraPermission() async {
    var status = await Permission.camera.request();

    if (status.isGranted) {
      setState(() {
        _cameraPermissionGranted = true;
      });
    } else if (status.isDenied) {
      // If permission is denied, show alert and ask again
      _showPermissionDeniedDialog();
    } else if (status.isPermanentlyDenied) {
      // If permanently denied, direct user to settings
      openAppSettings();
    }
  }

  //  Alert Dialog for Permission Denial
  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Camera Permission Required"),
        content: Text(
            "Please allow camera access to scan QR codes."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _requestCameraPermission(); // Ask again
            },
            child: Text("Retry"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings(); // Redirect to settings
            },
            child: Text("Open Settings"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton.outlined(
          onPressed: () {
            // Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Scan",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
      body: _cameraPermissionGranted ? _buildScanOptions() : _buildPermissionRequest(),
    );
  }

  // UI for asking permission
  Widget _buildPermissionRequest() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center, // Ensures everything is centered
        children: [
          Icon(Icons.camera_alt, size: 80, color: Colors.grey),
          SizedBox(height: 20),
          Text(
            "Camera access is required to scan QR codes and documents.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _requestCameraPermission,
            child: Text("Grant Camera Access"),
          ),
        ],
      ),
    );
  }

  //  UI for Scan Options
  Widget _buildScanOptions() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QRCodeScanner()),
              );
            },
            child: Text('Scan QR Code'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DocumentScanner()),
              );
            },
            child: Text('Scan Document'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CheckDepositScanner()),
              );
            },
            child: Text('Deposit Check'),
          ),
        ],
      ),
    );
  }
}

// QR Code Scanner Page
class QRCodeScanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('QR Code Scanner')),
      body: MobileScanner(
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            final String? code = barcode.rawValue;
            if (code != null) {
              print('QR Code found: $code');
            } else {
              print('Failed to scan Barcode');
            }
          }
        },
      ),
    );
  }
}

//  Document Scanner Page
class DocumentScanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Document Scanner'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Add your document scanning functionality here
          },
          child: Text('Start Scanning'),
        ),
      ),
    );
  }
}

// ✅ Check Deposit Scanner Page
class CheckDepositScanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check Deposit'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Add your check deposit scanning functionality here
          },
          child: Text('Scan Check'),
        ),
      ),
    );
  }
}
