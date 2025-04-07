import 'package:flutter/material.dart';
class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  bool _manualTestingDone = false;
  bool _automationTestingStarted = false;

  bool _signupPageTested = false;
  bool _homePageTested = false;
  bool _explorePageTested = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue.shade900,
            Colors.blue.shade700,
          ],
        ),
      ),
      child: Scaffold(backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text('Testing Progress',style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 16.0),
                  child: Column(
                    children: [
                      CheckboxListTile(
                        title: const Text(
                          'Done with Manual Testing',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        value: _manualTestingDone,
                        onChanged: (value) {
                          setState(() {
                            _manualTestingDone = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 2,
                  child: Column(
                    children: [
                      // Main Automation Testing Task
                      CheckboxListTile(
                        title: const Text(
                          'Started Automation Testing',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        value: _automationTestingStarted,
                        onChanged: (value) {
                          setState(() {
                            _automationTestingStarted = value ?? false;
          
                            // If automation testing is marked as not started,
                            // reset all sub-tasks
                            if (value == false) {
                              _signupPageTested = false;
                              _homePageTested = false;
                              _explorePageTested = false;
                            }
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
          
                      // Only show sub-tasks if automation testing is started
                      if (_automationTestingStarted) ...[
                        const Divider(height: 1),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: CheckboxListTile(
                            title: const Text('Tested Signup Page'),
                            value: _signupPageTested,
                            onChanged: (value) {
                              setState(() {
                                _signupPageTested = value ?? false;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: CheckboxListTile(
                            title: const Text('Tested Home Page Particulars'),
                            value: _homePageTested,
                            onChanged: (value) {
                              setState(() {
                                _homePageTested = value ?? false;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: CheckboxListTile(
                            title: const Text('Tested Explore Page Particulars'),
                            value: _explorePageTested,
                            onChanged: (value) {
                              setState(() {
                                _explorePageTested = value ?? false;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                if (_automationTestingStarted)
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Automation Testing Progress',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 10),
                          LinearProgressIndicator(
                            value: (_signupPageTested ? 1 : 0) +
                                (_homePageTested ? 1 : 0) +
                                (_explorePageTested ? 1 : 0) / 3,
                            backgroundColor: Colors.grey[300],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${((_signupPageTested ? 1 : 0) + (_homePageTested ? 1 : 0) + (_explorePageTested ? 1 : 0)) / 3 * 100}% Complete',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       const SnackBar(content: Text('Testing progress saved!')),
        //     );
        //   },
        //   child: const Icon(Icons.save),
        // ),
      ),
    );
  }
}