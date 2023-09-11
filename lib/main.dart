import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CV App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CVView(),
    );
  }
}

class CVView extends StatefulWidget {
  const CVView({super.key});

  @override
  _CVViewState createState() => _CVViewState();
}

class _CVViewState extends State<CVView> {
  String fullName = 'Etoma-etoto Odi';
  String slackUsername = 'kelvin.dart';
  String githubHandle = 'Kellytomi';
  String bio = 'I am a Flutter developer, with a passion for learning. I am an '
      'ex-cadet of the Nigerian Defence Academy, Kaduna State, Nigeria. I am a '
      'member of the Flutter Nigeria community, I am passionate and motivated '
      'with a strong desire to learn and grow in the world of mobile app'
      'development. Eager to leverage my skills and creativity to build'
      'innovative and user-friendly cross-platform applications. Committed to'
      'staying up-to-date with the latest Flutter trends and best practices'
      'while continuously expanding my knowledge in this exciting field.';

  Widget buildCodeBlock(String label, String content) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[200]?.withOpacity(0.7), // Adjust opacity as needed
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color and opacity
            spreadRadius: 2, // Spread radius
            blurRadius: 5, // Blur radius
            offset: const Offset(0, 3), // Offset
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            content,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _navigateToEditPage(BuildContext context) async {
    final updatedData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditCVPage(
          fullName: fullName,
          slackUsername: slackUsername,
          githubHandle: githubHandle,
          bio: bio,
        ),
      ),
    );

    if (updatedData != null) {
      setState(() {
        fullName = updatedData['fullName'] ?? fullName;
        slackUsername = updatedData['slackUsername'] ?? slackUsername;
        githubHandle = updatedData['githubHandle'] ?? githubHandle;
        bio = updatedData['bio'] ?? bio;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            const Color.fromARGB(255, 87, 5, 228), // Set app bar color
        title: const Text('HNGx CV App'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 220, 103, 8),
              Color.fromARGB(255, 87, 5, 228)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            buildCodeBlock('Full Name:', fullName),
            buildCodeBlock('Slack Username:', slackUsername),
            buildCodeBlock('GitHub Handle:', githubHandle),
            buildCodeBlock('Bio:', bio),
            ElevatedButton(
              onPressed: () => _navigateToEditPage(context),
              child: const Text('Edit CV'),
            ),
          ],
        ),
      ),
    );
  }
}

class EditCVPage extends StatefulWidget {
  final String fullName;
  final String slackUsername;
  final String githubHandle;
  final String bio;

  const EditCVPage({
    Key? key,
    required this.fullName,
    required this.slackUsername,
    required this.githubHandle,
    required this.bio,
  }) : super(key: key);

  @override
  _EditCVPageState createState() => _EditCVPageState();
}

class _EditCVPageState extends State<EditCVPage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController slackUsernameController = TextEditingController();
  TextEditingController githubHandleController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize text controllers with current values
    fullNameController.text = widget.fullName;
    slackUsernameController.text = widget.slackUsername;
    githubHandleController.text = widget.githubHandle;
    bioController.text = widget.bio;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            const Color.fromARGB(255, 87, 5, 228), // Set app bar color
        title: const Text('Edit CV'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 18.0), // Add spacing
              _buildTextField(fullNameController, 'Full Name'),
              const SizedBox(height: 18.0), // Add spacing
              _buildTextField(slackUsernameController, 'Slack Username'),
              const SizedBox(height: 18.0), // Add spacing
              _buildTextField(githubHandleController, 'GitHub Handle'),
              const SizedBox(height: 18.0), // Add spacing
              _buildMultilineTextField(bioController, 'Bio'),
              const SizedBox(height: 18.0), // Add spacing
              ElevatedButton(
                onPressed: () {
                  final updatedData = {
                    'fullName': fullNameController.text,
                    'slackUsername': slackUsernameController.text,
                    'githubHandle': githubHandleController.text,
                    'bio': bioController.text,
                  };
                  Navigator.pop(context, updatedData);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Button color
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCodeBlock(String label, String content) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[200]?.withOpacity(0.7), // Adjust opacity as needed
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color and opacity
            spreadRadius: 2, // Spread radius
            blurRadius: 5, // Blur radius
            offset: const Offset(0, 3), // Offset
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            content,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildMultilineTextField(
      TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      maxLines: null, // Allow unlimited lines
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
