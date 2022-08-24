RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");

// Padding(
//   padding: const EdgeInsets.all(12.0),
//   child:
//   LinearProgressIndicator(
//     value: password_strength,
//       backgroundColor: Colors.grey.shade300,
//       minHeight: 5,
//       color: password_strength <= 1/4?
//           Colors.red:password_strength == 2/4?
//           Colors.yellow
//           : _passwordTextController == 3/4?
//           Colors.blue:Colors.green,
//   ),
// ),