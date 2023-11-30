import 'package:flutter/material.dart';

class SecondTest extends StatefulWidget {
  const SecondTest({super.key});

  @override
  State<SecondTest> createState() => _SecondTestState();
}

class _SecondTestState extends State<SecondTest> {
  String selectedValue = '';
  String secondSelectedValue = '';
  bool showSecondButton = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('test'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF000000).withOpacity(0.45),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ]),
                  child: Column(
                    children: [
                      _headerForm("Datos del Beneficiario"),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () => _showModalBottomSheet(),
                        child: Container(
                          width: double.infinity,
                          height: 45,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black38)),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(selectedValue.isEmpty
                                    ? "Selecciona una categoria"
                                    : selectedValue),
                              ),
                              Container(
                                height: 2,
                                width: 25,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      if (showSecondButton)
                        GestureDetector(
                          onTap: () => _showSecondModal(),
                          child: Container(
                            width: double.infinity,
                            height: 45,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black38)),
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(secondSelectedValue.isEmpty
                                      ? "Selecciona una empresa"
                                      : secondSelectedValue),
                                ),
                                Container(
                                  height: 2,
                                  width: 25,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showModalBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
          minWidth: double.infinity),
      showDragHandle: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      isDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return MyReusableModal(
          options: const [
            'Claro Dominicana',
            'Altice Dominicana',
            'Tricom',
            'Viva',
            'Wind Telecom',
          ],
          onValueSelected: (value) {
            setState(() {
              selectedValue = value;
              if (value.isNotEmpty) {
                showSecondButton = true;
              }
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _showSecondModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return MyReusableModal(
          options: const ['Option A', 'Option B', 'Option C'],
          onValueSelected: (value) {
            setState(() {
              secondSelectedValue = value;
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }
}

Widget _headerForm(String title) {
  return Row(
    children: [
      Expanded(
          child: Container(
        height: 1,
        color: Colors.black26,
      )),
      const SizedBox(
        width: 15,
      ),
      Text(title),
      const SizedBox(
        width: 15,
      ),
      Expanded(
          child: Container(
        height: 1,
        color: Colors.black26,
      )),
    ],
  );
}

class MyReusableModal extends StatelessWidget {
  final List<String> options;
  final Function(String) onValueSelected;

  const MyReusableModal({
    super.key,
    required this.options,
    required this.onValueSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for (String option in options)
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(option),
            leading: Radio(
              value: option,
              groupValue: null, // Use null since each radio is independent
              onChanged: (value) {
                onValueSelected(value as String);
              },
            ),
          ),
      ],
    );
  }
}
