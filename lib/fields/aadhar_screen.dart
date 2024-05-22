import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dynamic_textformfield/provider/provider.dart';

class AadharField extends StatelessWidget {
  AadharField({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aadhar"),
      ),
      body: Form(
        key: _formKey,
        child: Consumer<SampleProvider>(
          builder: (context, provider, child) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    provider.textFormFields.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: provider.textFormFields.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: TextFormField(
                                  controller: provider.controllers[index],
                                  keyboardType:
                                      provider.textFormFields[index].keyBoard ==
                                              "number"
                                          ? TextInputType.number
                                          : TextInputType.text,
                                  decoration: InputDecoration(
                                      hintText:
                                          provider.textFormFields[index].hint,
                                      labelText:
                                          provider.textFormFields[index].label,
                                      border: const OutlineInputBorder(),
                                      suffixIcon: provider
                                              .textFormFields[index].calendar
                                          ? IconButton(
                                              onPressed: () {
                                                provider.showDatePicker(
                                                    context, index);
                                              },
                                              icon: const Icon(
                                                  Icons.calendar_month))
                                          : const SizedBox()),
                                  onChanged: (value) {
                                    provider.updateController(index, value);
                                  },
                                  validator: (value) {
                                    return provider
                                            .textFormFields[index].validation
                                        ? provider.validateText(value, index)
                                        : null;
                                  },
                                ),
                              );
                            },
                          )
                        : SizedBox(),
                    provider.dropdownFields.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: provider.dropdownFields.length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(provider.dropdownFields[index].label),
                                  DropdownButton(
                                    isExpanded: true,
                                    hint: Text(
                                        provider.dropdownFields[index].hint),
                                    items: provider
                                        .dropdownFields[index].options
                                        .map<DropdownMenuItem<String>>((value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value.toString()),
                                      );
                                    }).toList(),
                                    value: provider.selectedOptions[index],
                                    onChanged: (value) {
                                      provider.updateDropdown(index, value);
                                    },
                                  )
                                ],
                              );
                            },
                          )
                        : SizedBox(),
                    provider.imageFields.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: provider.imageFields.length,
                            itemBuilder: (context, index) {
                              return provider.imageFields[index].widgetType ==
                                      "oneImg"
                                  ? Column(
                                      children: [
                                        if (provider.imageFields[index].image !=
                                            null)
                                          provider.uploadImage == false
                                              ? provider.imageFields[index]
                                                          .image !=
                                                      ""
                                                  ? Image.network(
                                                      provider
                                                          .imageFields[index]
                                                          .image!,
                                                      height: 200,
                                                    )
                                                  : const SizedBox()
                                              : Image.file(
                                                  provider.localOneImg!,
                                                  height: 200,
                                                ),
                                        ElevatedButton(
                                          onPressed: () {
                                            provider.pickOneFile(index);
                                          },
                                          child:
                                              const Text('Upload or Take Pic'),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount:
                                              provider.uploadImage == false
                                                  ? provider.imageFields[index]
                                                      .images!.length
                                                  : provider.localImg.length,
                                          itemBuilder: (context, imgIndex) {
                                            return provider.uploadImage == false
                                                ? Column(
                                                    children: [
                                                      Image.network(
                                                        provider
                                                            .imageFields[index]
                                                            .images![imgIndex],
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      )
                                                    ],
                                                  )
                                                : Column(
                                                    children: [
                                                      Image.file(
                                                        provider.localImg[
                                                            imgIndex]!,
                                                        height: 200,
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      )
                                                    ],
                                                  );
                                          },
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            provider.pickMultyFiles();
                                          },
                                          child:
                                              const Text('Upload or Take Pic'),
                                        ),
                                      ],
                                    );
                            },
                          )
                        : const SizedBox(
                            height: 30,
                          ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              const MaterialStatePropertyAll(Colors.green),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.amber)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          provider.sentDatas();
                        }
                      },
                      child: const Text('Submit'),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
