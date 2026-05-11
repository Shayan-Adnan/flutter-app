enum Gender { male, female, other }

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();

  Gender? selectedGender;
  bool signupForMarketingAds = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: "Full Name",
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Required";
              }
              return null;
            },
          ),

          TextFormField(
            decoration: InputDecoration(
              labelText: "Password",
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Required";
              }
              if (!RegExp(r'[A-Z]').hasMatch(value)) {
                return "At least one uppercase letter is required";
              }
              if (!RegExp(r'[!@#$%^&*]').hasMatch(value)) {
                return "At least one special character is required";
              }
              return null;
            },
          ),

          DropdownButtonFormField<Gender>(
            value: selectedGender,
            items: [
              DropdownMenuItem(
                value: Gender.male,
                child: Text("Male"),
              ),
              DropdownMenuItem(
                value: Gender.female,
                child: Text("Female"),
              ),
              DropdownMenuItem(
                value: Gender.other,
                child: Text("Other"),
              ),
            ],
            onChanged: (value) {
              setState(() {
                selectedGender = value;
              });
            },
          ),

          Switch(
            value: signupForMarketingAds,
            onChanged: (value) {
              setState(() {
                signupForMarketingAds = value;
              });
            },
          ),

          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                print("Signup successful!");
              }
            },
            child: Text("Submit"),
          ),
        ],
      ),
    );
  }
}