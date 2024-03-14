import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import '../../../core/domain/entities/punch_the_clock_entity.dart';
import '../../../core/domain/entities/user_entity.dart';
import '../../view_models/data_view_model.dart';
import '../buttons/icon_button_widget.dart';

mixin ClocksListDialogMixin {
  @pragma('vm:entry-point')
  Route<Object?> clocksDialog(
      {required UserEntity user,
      required DataViewModel viewModel,
      required List<PunchTheClockEntity> clocksList}) {
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
                        Container(
                          margin: const EdgeInsets.only(
                            top: 13,
                          ),
                          child: const Center(
                            child: Text(
                              'Lista de Pontos',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: 35,
                            top: 28,
                          ),
                          child: Row(
                            children: [
                              const Text(
                                'Usuario:',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                ' ${user.name}',
                                style: const TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 30),
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: clocksList.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Row(
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.only(
                                          left: 35,
                                        ),
                                        child: const Text(
                                          'Dia:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        )),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Text(
                                        DateFormat('dd/MM/yyyy')
                                            .format(clocksList[index].date),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.7,
                                        ),
                                      ),
                                    ),
                                    Container(
                                        margin: const EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: const Text(
                                          'Hora:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        )),
                                    Container(
                                        margin: const EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: Text(clocksList[index].time)),
                                  ],
                                ),
                                onTap: () {
                                  // Navigator.pushNamed(context, AppRoutes.lyricRoute,
                                  //    arguments: lyricsFiltered[index]);
                                },
                              );
                            },
                          ),
                        ),
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
