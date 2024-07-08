/*import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpForm extends StatefulWidget {
  final void Function(String) onOtpSubmitted;

  const OtpForm({Key? key, required this.onOtpSubmitted}) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final TextEditingController otpController = TextEditingController();

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
      child: Column(
        children: [
          Text(
            'Enter OTP',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: otpController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              hintText: 'Enter OTP',
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              String enteredOtp = otpController.text.trim();
              widget.onOtpSubmitted(enteredOtp);
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.teal[900],
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            ),
            child: Text('Verify OTP'),
          ),
        ],
      ),
    );
  }
}*/
