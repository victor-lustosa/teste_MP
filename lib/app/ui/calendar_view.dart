import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../core/domain/entities/punch_the_clock_entity.dart';
import '../core/domain/entities/user_entity.dart';
import 'blocs/calendar_bloc.dart';
import 'components/buttons/elevated_button_widget.dart';
import 'components/calendar/calendar_widget.dart';
import 'components/dialogs/clocks_list_dialog_mixin.dart';
import 'components/dialogs/error_dialog_widget.dart';
import 'components/dialogs/punch_the_clock_dialog_mixin.dart';
import 'components/dialogs/user_register_dialog_mixin.dart';
import 'components/dropdowns/dropdown_widget.dart';
import 'components/loading/loading_widget.dart';
import 'view_models/data_view_model.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView>
    with
        UserRegisterlDialogMixin,
        PunchTheClockDialogMixin,
        ClocksListDialogMixin {
  final DataViewModel viewModel = Modular.get<DataViewModel>();
  late List<UserEntity> usersList;
  String userSelected = '';
  late double vWith;
  final CalendarBloc bloc = Modular.get<CalendarBloc>();


  @override
  void initState() {
    super.initState();
    bloc.add(GetUsersInHiveEvent());
  }

  @override
  Widget build(BuildContext context) {
    vWith = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocConsumer<CalendarBloc, CalendarState>(
            bloc: bloc,
            listener: (BuildContext context, CalendarState state) {},
            builder: (context, state) {
              if (state is LoadingUsersState) {
                return const LoadingWidget();
              } else if (state is UsersFetchedState) {
                usersList = state.entities;
                return SizedBox(
                  width: vWith,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 60, bottom: 20),
                        child: const Text(
                          'Sistema de batidas do Ministério Público',
                          style: TextStyle(fontSize: 19),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        child: const Text(
                          'Selecione um usuário',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Container(
                        width: 200,
                        height: 55,
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
                            width: 160,
                            height: 44,
                            usersList.map((e) => e.name).toList(),
                            (String value) {
                              setState(
                                () {
                                  userSelected = value;
                                },
                              );
                            },
                            "Usuário",

                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 50,
                          bottom: 50,
                          right: 20,
                          left: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButtonWidget(
                              action: () {
                                if (userSelected != '') {
                                  Modular.to.push(
                                    clockDialog(
                                      userEntity: usersList.firstWhere(
                                          (e) => e.name == userSelected),
                                      modelView: viewModel,
                                    ),
                                  );
                                } else {
                                  showCustomErrorDialog(
                                      context: context,
                                      title: 'Faltam dados',
                                      message:
                                          'Você precisa informar um usuario.');
                                }
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: EdgeInsets.zero,
                              fixedSize: const Size(150, 48),
                              backgroundColor: Colors.cyan,
                              shadowColor: Colors.grey,
                              foregroundColor: Colors.white,
                              child: const Text(
                                "Bater Ponto",
                              ),
                            ),
                            ElevatedButtonWidget(
                              action: () {
                                Modular.to.push(
                                  userDialog(
                                    viewModel: viewModel,
                                  ),
                                );
                              },
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              fixedSize: const Size(150, 48),
                              backgroundColor: Colors.cyan,
                              shadowColor: Colors.grey,
                              foregroundColor: Colors.white,
                              child: const Text(
                                "Cadastrar Usuário",
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        child: const Text(
                          'Clique sobre o dia que deseja visualizar as batidas.',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black12),
                        ),
                        margin: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          bottom: 20,
                        ),
                        child: Center(
                          child: CalendarWidget(
                            action: (selectedDay, focusedDay) async {
                              {
                                if (userSelected != '') {
                                  List<PunchTheClockEntity> clocksList =
                                      await viewModel.getClocks(
                                          DateFormat('dd/MM/yyyy')
                                              .format(selectedDay),
                                          userSelected);
                                  if (clocksList.isNotEmpty) {
                                    Modular.to.push(
                                      clocksDialog(
                                        viewModel: viewModel,
                                        user: usersList.firstWhere(
                                            (e) => e.name == userSelected),
                                        clocksList: clocksList,
                                      ),
                                    );
                                  } else {
                                    showCustomErrorDialog(
                                        context: context,
                                        title: 'Não há batidas',
                                        message:
                                            'Não há batidas registradas nesse dia.');
                                  }
                                } else {
                                  showCustomErrorDialog(
                                      context: context,
                                      title: 'Faltam dados',
                                      message:
                                          'Você precisa informar um usuario.');
                                }
                                if (!isSameDay(viewModel.selectedDay, selectedDay)) {
                                  // Call `setState()` when updating the selected day
                                  setState(() {
                                    viewModel.selectedDay = selectedDay;
                                    viewModel.focusedDay = focusedDay;
                                  });
                                }
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const Text('error');
              }
            },
          ),
        ),
      ),
    );
  }
}
