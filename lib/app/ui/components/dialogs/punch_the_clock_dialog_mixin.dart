import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import '../../../core/domain/entities/punch_the_clock_entity.dart';
import '../../../core/domain/entities/user_entity.dart';
import '../../utils/id_util.dart';
import '../../view_models/data_view_model.dart';
import '../buttons/elevated_button_widget.dart';
import '../buttons/icon_button_widget.dart';
import '../dropdowns/dropdown_widget.dart';
import '../forms/form_field_widget.dart';
import 'error_dialog_widget.dart';

mixin PunchTheClockDialogMixin {
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");
  final TextEditingController _hourController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _minutesController = TextEditingController();
  final _dateKey = GlobalKey<FormState>();

  @pragma('vm:entry-point')
  Route<Object?> clockDialog({
    required UserEntity userEntity,
    required DataViewModel modelView,
  }) {
    late Orientation orientation;
    return RawDialogRoute<void>(
        barrierColor: Colors.black.withOpacity(.3),
        transitionBuilder: (context, a1, a2, widget) {
          orientation = MediaQuery.of(context).orientation;
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1;
          return Transform(
            transform: Matrix4.translationValues(0, curvedValue * 200, 0),
            child: Opacity(
              opacity: a1.value,
              child: SingleChildScrollView(
                child: Dialog(
                  surfaceTintColor: Colors.transparent,
                  backgroundColor: Colors.white,
                  insetPadding: EdgeInsets.only(
                    top: orientation.name == 'portrait' ? 210 : 40,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: SizedBox(
                    width: orientation.name == 'portrait'
                        ? MediaQuery.of(context).size.width * .89
                        : 490,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 20, right: 18),
                              child: InkWell(
                                onTap: () => Modular.to.pop(context),
                                child: const SizedBox(
                                    height: 28,
                                    child: IconButtonWidget(
                                        color: Colors.black26,
                                        iOSIcon: CupertinoIcons.clear,
                                        androidIcon: Icons.clear)),
                              ),
                            ),
                          ],
                        ),
                        const Center(
                          child: Text(
                            'Bater Ponto',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: 18,
                            top: 23,
                          ),
                          child: Text(
                            'Usuario: ${userEntity.name}',
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            top: 15,
                            left: 18,
                            bottom: 7,
                            right: 18,
                          ),
                          child: FormFieldWidget(
                            fieldHeight: 60,
                            titleMargin: const EdgeInsets.only(
                              bottom: 10,
                            ),
                            fieldDecoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black26),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            key: _dateKey,
                            cursorColor: Colors.black26,
                            controller: _dateController,
                            inputDecoration: const InputDecoration(
                              isDense: true,
                              hintText: "dd-MM-yyyy",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                left: 20,
                                top: 15,
                              ),
                            ),
                            validator: (value) {
                              return null;
                            },
                            title: 'Data',
                            isValid: true,
                            errorText: const Text(""),
                            obscureText: false,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            top: 15,
                            left: 18,
                            right: 18,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(
                                          left: 4, bottom: 5),
                                      child: const Text('Hora')),
                                  Container(
                                    width: 140,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      border: Border.all(
                                        color: Colors.black45,
                                        width: 1.0,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    child: Form(
                                      autovalidateMode: AutovalidateMode.always,
                                      child: DropdownWidget(
                                        height: 44,
                                        width: 80,
                                        //  usersList.map((e) => e.name).toList(),
                                        IdUtil.hours,
                                        (String value) {
                                          _hourController.text = value;
                                        },
                                        "Hora",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(
                                          left: 4, bottom: 5),
                                      child: const Text('Minuto')),
                                  Container(
                                    width: 140,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      border: Border.all(
                                        color: Colors.black45,
                                        width: 1.0,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    child: Form(
                                      autovalidateMode: AutovalidateMode.always,
                                      child: DropdownWidget(
                                        height: 44,
                                        width: 80,
                                        IdUtil.minutes,
                                        (String value) {
                                          _minutesController.text = value;
                                        },
                                        "Minuto",
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(top: 50, bottom: 45),
                            child: ElevatedButtonWidget(
                              fixedSize: Size(
                                MediaQuery.of(context).size.width * .8,
                                60,
                              ),
                              backgroundColor: Colors.blue,
                              action: () {
                                if (_dateController.text != '' &&
                                    _hourController.text != '' &&
                                    _minutesController.text != '') {
                                  try{
                                    modelView.registerClock(
                                      PunchTheClockEntity(
                                        id: IdUtil.create(8),
                                        user: userEntity,
                                        time:
                                        '${_hourController.text}:${_minutesController.text}',
                                        date: dateFormat
                                            .parse(_dateController.text),
                                      ),
                                    );
                                    _dateController.text = '';
                                    _hourController.text = '';
                                    _minutesController.text = '';
                                    Modular.to.pop(context);
                                  } catch(e){
                                    showCustomErrorDialog(
                                        context: context,
                                        title: 'Campo incorreto',
                                        message:
                                        'Você precisa informar uma data válida.');
                                  }


                                } else {
                                  showCustomErrorDialog(
                                      context: context,
                                      title: 'Faltam dados',
                                      message:
                                          'Você precisa informar todos os campos');
                                }
                              },
                              child: const Text(
                                'Bater',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        pageBuilder: (_, __, ___) {
          return const SizedBox();
        });
  }
}
