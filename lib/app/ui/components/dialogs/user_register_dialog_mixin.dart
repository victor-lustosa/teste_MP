import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/domain/entities/user_entity.dart';
import '../../blocs/calendar_bloc.dart';
import '../../utils/id_util.dart';
import '../../view_models/data_view_model.dart';
import '../buttons/elevated_button_widget.dart';
import '../buttons/icon_button_widget.dart';
import '../forms/form_field_widget.dart';
import 'error_dialog_widget.dart';

mixin UserRegisterlDialogMixin {
  @pragma('vm:entry-point')
  final _nameKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  Route<Object?> userDialog({
    required DataViewModel viewModel,
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
                                    androidIcon: Icons.clear,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: 30,
                            right: 20,
                            top: 23,
                          ),
                          child: const Text(
                            'Cadastro de Usuario no Sistema',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            top: 25,
                            left: 5,
                            bottom: 7,
                          ),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 18),
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
                              key: _nameKey,
                              cursorColor: Colors.black26,
                              controller: _nameController,
                              inputDecoration: const InputDecoration(
                                isDense: true,
                                hintText: "Nome",
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                  left: 20,
                                  top: 15,
                                ),
                              ),
                              validator: (value) {
                                return null;
                              },
                              title: 'Nome do usuario',
                              isValid: true,
                              errorText: const Text(""),
                              obscureText: false,
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(top: 35, bottom: 58),
                            child: ElevatedButtonWidget(
                              fixedSize: Size(
                                MediaQuery.of(context).size.width * .8,
                                60,
                              ),
                              backgroundColor: Colors.blue,
                              action: () {
                                if (_nameController.text != '') {
                                  viewModel.registerUser(
                                    UserEntity(
                                        id: IdUtil.create(8),
                                        name: _nameController.text),
                                  );
                                  Modular.get<CalendarBloc>()
                                      .add(GetUsersInHiveEvent());
                                  _nameController.text = '';
                                  Modular.to.pop(context);
                                } else {
                                  showCustomErrorDialog(
                                      context: context,
                                      title: 'Faltam dados',
                                      message: 'Você precisa informar o nome.');
                                }
                              },
                              child: const Text(
                                'Salvar',
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
