import 'package:flutter/material.dart';
import 'package:radio_emoji/constants.dart';
import 'package:radio_emoji/form_field.dart';
import 'package:radio_emoji/raised_fab.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radio Emoji',
      debugShowCheckedModeBanner: false,
      home: FeedbackScreen(),
    );
  }
}

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  List<String> _questions = [
    'How satisfied are you with the app UI?',
    'How much do you recommend our app to your friends?',
    'How was your overall experience?',
  ];

  List<int> _feedbackValue = [];

  List<bool> _isFormFieldComplete = [];

  String additionalComments;

  void _handleRadioButton(int group, int value) {
    setState(() {
      _feedbackValue[group] = value;
      _isFormFieldComplete[group] = false;
    });
  }

  void handleSubmitFeedback() {
    bool complete = true;
    for (int i = 0; i < _feedbackValue.length; ++i) {
      if (_feedbackValue[i] == -1) {
        complete = false;
        _isFormFieldComplete[i] = true;
      } else {
        _isFormFieldComplete[i] = false;
      }
    }
    setState(() {});
    if (complete == true) {
      // setState(() => loading = true);
    }
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _questions.length; ++i) {
      _feedbackValue.add(-1);
      _isFormFieldComplete.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback Screen'),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Please choose appropriate emoji icon for response',
                style: kFeedbackFormFieldTextStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '😍 - Very Satisfied',
                style: kFeedbackFormFieldTextStyle,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '☺ - Satisfied',
                style: kFeedbackFormFieldTextStyle,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '😐 - Somehow Satisfied',
                style: kFeedbackFormFieldTextStyle,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '😕 - Dissatified',
                style: kFeedbackFormFieldTextStyle,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '😠 - Very Dissatisfied',
                style: kFeedbackFormFieldTextStyle,
              ),
              Divider(
                height: 25.0,
              ),
            ]
              ..addAll(
                _questions.asMap().entries.map((entry) {
                  return FeedbackFormField(
                    id: entry.key + 1,
                    question: entry.value,
                    groupValue: _feedbackValue[entry.key],
                    radioHandler: (int value) =>
                        _handleRadioButton(entry.key, value),
                    error: _isFormFieldComplete[entry.key]
                        ? 'This is a required field'
                        : null,
                  );
                }),
              )
              ..addAll([
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  decoration: kFeedbackFormFieldDecoration.copyWith(
                    hintText: 'Additional Comments (Optional)',
                    ),
                  maxLines: 5,
                  onChanged: (value) => additionalComments = value,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomRaisedButton(
                      save: handleSubmitFeedback,
                      title: 'Submit',
                    ),
                  ],
                ),
              ]),
          ),
        ),
      ),
    );
  }
}
