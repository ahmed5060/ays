import 'package:courses_app/core/endpoints/end_points.dart';
import 'package:courses_app/core/helper/api_helper.dart';
import 'package:courses_app/core/shared/main_app_bar_widget.dart';
import 'package:courses_app/models/course_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AskScreen extends StatefulWidget {
  const AskScreen({
    Key? key,
    required this.courseModel,
  }) : super(key: key);

  final CourseModel courseModel;
  @override
  _AskScreenState createState() => _AskScreenState();
}

bool isActive = false;
String title = "";
String pdf = "";
List<String> options = [];

List<Map<String, dynamic>> optionsdata = [];

List<String> selectedValues = [];
// ========== isQuestion1Accessible ============= \\
bool isQuestion1Accessible = false;
bool isQuestion2Accessible = false;
// ========== isQuestion1Accessible ============= \\

bool isLoading = false;

class _AskScreenState extends State<AskScreen> {
  String selectedValueQ1 = 'Option 1'; // Default selected value
  List<String> selectedValues = [];
  List<int> ansId = [];
  List<String> options2 = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];
  bool isLodingSubmit = false;
  @override
  void initState() {
    super.initState();
    getAnswerOptions(widget.courseModel.id);
    checkQuestionAccessibility(1);
    checkQuestionAccessibility(2);
  }

  Future<void> checkQuestionAccessibility(int questionNumber) async {
    final response = await APIHelper.apiCall(
      type: APICallType.get,
      url: '${EndPoints.getAccessQ}$questionNumber',
    );
    if (response.data != null && response.data['data'] != null) {
      //   print("access q" + response.data['data']);
      if (questionNumber == 1) {
        setState(() {
          isQuestion1Accessible = response.data['data'];
        });
      } else if (questionNumber == 2) {
        setState(() {
          isQuestion2Accessible = response.data['data'];
        });
      }
    } else {
      // Handle the case when the API request fails
      print('Failed to check question $questionNumber accessibility');
    }
  }

  Future<void> getAnswerOptions(int courseId) async {
    setState(() {
      isLoading = true;
    });

    final response = await APIHelper.apiCall(
      type: APICallType.get,
      url: '${EndPoints.getAskOP}$courseId',
    );

    if (response.success) {
      if (response.data != null && response.data['data'] != null) {
        print(response.data);
        final List<dynamic> data = response.data['data'];

        // Extract 'option_name' values from each item in the 'data' list
        final List<String> optionNames =
            data.map((item) => item['option_name'].toString()).toList();
        final List<Map<String, dynamic>> optionsData = data
            .map((item) => {
                  'id': item['id'],
                  'option_name': item['option_name'].toString(),
                  'price': item['price'].toString(),
                  'fawry_link': item['fawry_link'].toString(),
                })
            .toList();
        setState(() {
          options = optionNames;
          optionsdata = optionsData;
          isLoading = false;
        });
      } else {
        // Handle error
        print('Failed to load options from API');
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> submitQ(int courseId, dynamic answer, String type) async {
    final response = await APIHelper.apiCall(
      type: APICallType.post,
      url: EndPoints.submitQAsk,
      apiBody: {
        'course_id': courseId,
        'answers': answer,
        'type': type,
      },
    );

    if (response.success) {
      setState(() {
        isLodingSubmit = false;
      });
      print(response);
    }
  }

  String getOptionPrice(String selectedOption) {
    // Find the option in optionsdata
    var selectedOptionData = optionsdata.firstWhere(
      (option) => option["option_name"] == selectedOption,
      orElse: () => Map<String, String>.from({}),
    );

    // Return the price if the option is found, otherwise return an empty string
    return selectedOptionData.isNotEmpty
        ? selectedOptionData["price"].toString()
        : "";
  }

  int getOptionId(String selectedOption) {
    // Find the option in optionsdata
    var selectedOptionData = optionsdata.firstWhere(
      (option) => option["option_name"] == selectedOption,
      orElse: () => Map<String, String>.from({}),
    );

    // Return the price if the option is found, otherwise return an empty string
    return selectedOptionData.isNotEmpty ? selectedOptionData["id"] : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBarWidget(
        title: "Ask Screen",
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isLodingSubmit == false
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3E5799),
                ),
                onPressed: isQuestion1Accessible || isQuestion1Accessible
                    ? () {
                        setState(() {
                          isLodingSubmit = true;
                        });
                        if (isQuestion1Accessible) {
                          submitQ(widget.courseModel.id, selectedValueQ1, '1');
                        } else {
                          submitQ(widget.courseModel.id, ansId, '2');
                        }
                      }
                    : null,
                child: Text(
                  isQuestion1Accessible || isQuestion1Accessible
                      ? "Submit"
                      : "Not Allow",
                  style: const TextStyle(fontSize: 20),
                ))
            : const Center(child: CircularProgressIndicator()),
      ),
      body: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 20,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  'مكان استلام الشهادة ؟',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: Row(
                      children: [
                        Expanded(
                          child: isQuestion1Accessible
                              ? DropdownButton<String>(
                                  value: selectedValueQ1,
                                  icon: const Icon(Icons.arrow_drop_down,
                                      color: Colors.black),
                                  iconSize: 24,
                                  style: const TextStyle(color: Colors.black),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedValueQ1 = newValue!;
                                      // print(selectedValueQ1);
                                    });
                                  },
                                  items: options2.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                )
                              : const SizedBox(
                                  height: 40,
                                  child: Center(child: Text("Not Allow")),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 20,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  "الشهادات المراد استلامها ؟",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                const SizedBox(
                  height: 5,
                ),
                isLoading
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          children: [
                            isQuestion2Accessible
                                ? Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        _showMultiSelectDialog(context);
                                      },
                                      child: InputDecorator(
                                        decoration: const InputDecoration(
                                          label: Text("اختر الشهادات ؟"),
                                          hintText: 'Select options',
                                          border: InputBorder.none,
                                        ),
                                        child: Wrap(
                                          spacing: 8.0,
                                          runSpacing: 4.0,
                                          children: selectedValues
                                              .map((value) => Chip(
                                                    label: Text(value),
                                                    onDeleted: () {
                                                      setState(() {
                                                        selectedValues
                                                            .remove(value);
                                                      });
                                                    },
                                                  ))
                                              .toList(),
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(
                                    height: 45,
                                    child: Center(child: Text("Not Allow")),
                                  ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Name",
                  style: TextStyle(color: Color(0xFF3E5799), fontSize: 20),
                ),
                Text(
                  "Price",
                  style: TextStyle(color: Color(0xFF3E5799), fontSize: 20),
                ),
                Text(
                  "Pay",
                  style: TextStyle(color: Color(0xFF3E5799), fontSize: 20),
                )
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 450,
            child: ListView.builder(
              itemCount: selectedValues.length,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      selectedValues[index],
                      style: const TextStyle(fontSize: 22),
                    ),
                    Text(getOptionPrice(selectedValues[index])),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                              0xFF3E5799), // Set your desired background color here
                        ),
                        onPressed: () async {
                          String url = optionsdata[index]
                              ["fawry_link"]; // Replace with your desired link
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: const Text("Pay"))
                    // Add additional widgets as needed
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Future<void> _showMultiSelectDialog(BuildContext context) async {
    await getAnswerOptions(widget.courseModel.id);

    // ignore: use_build_context_synchronously
    List<String> result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('اختر الشهادات '),
          content: isLoading
              ? const Center(child: CircularProgressIndicator())
              : StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return SizedBox(
                      width: double.maxFinite,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          String option = options[index];
                          return CheckboxListTile(
                            checkColor: Colors.white,
                            activeColor: Color(0xFF3E5799),
                            title: Text(option),
                            value: selectedValues.contains(option),
                            onChanged: (bool? value) {
                              setState(() {
                                if (value != null) {
                                  if (value && selectedValues.length < 4) {
                                    selectedValues.add(option);
                                    ansId.add(getOptionId(option));
                                    if (selectedValues.length == 4) {
                                      _showSnackbar(context, "4 Options only");
                                    }
                                  } else if (!value) {
                                    selectedValues.remove(option);
                                    ansId.remove(getOptionId(option));
                                  }
                                }
                              });
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(selectedValues);
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Color(0xFF3E5799)),
              ),
            ),
          ],
        );
      },
    );

    if (result != null) {
      setState(() {
        selectedValues = List<String>.from(result);
      });
    }
  }
}

// packa-===
void _showSnackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
      ),
      backgroundColor: const Color(0xFF3E5799),
      duration: const Duration(seconds: 2),
    ),
  );
}
