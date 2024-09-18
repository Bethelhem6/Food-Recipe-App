import 'package:emebet/core/styles/app_colors.dart';
import 'package:emebet/core/utils/constant/app_assets.dart';
import 'package:emebet/features/notification/domain/models/notification_param.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../shared/presentation/snackbar/error_message.dart';
import '../../../../shared/presentation/widgets/app_bar.dart';
import '../../../../shared/presentation/widgets/cutom_text.dart';
import '../../../../shared/presentation/widgets/faluire_widget_builder.dart';
import '../../data/model/notification.dart';
import '../bloc/notification_bloc.dart';

class Notifications extends StatefulWidget {
  static const String routeName = "notification";
  const Notifications({super.key});
  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  DateTime dateTime = DateTime.now();

  List<NotificationModel> notification = [];

  int skip = 0;
  int _top = 10;
  bool _hasNextPage = true;
  ScrollController _controller = ScrollController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller = ScrollController()..addListener(_loadMore);
      fetchNotification();
    });
  }

  fetchNotification() async {
    skip = 0;
    _top = 10;
    _hasNextPage = true;

    try {
      // notification =
      //     await Provider.of<NotificationProvider>(context, listen: false)
      //         .notifiacations(_top, skip);
      BlocProvider.of<NotificationBloc>(context).add(
          NotificationGets(param: NotificationParam(skip: null, top: null)));
    } catch (_) {}
  }

  void _loadMore() async {
    if (_hasNextPage == true && _controller.position.extentAfter < 100) {
      skip += _top;
      try {
        BlocProvider.of<NotificationBloc>(context).add(NotificationGetsMore(
            param: NotificationParam(top: _top, skip: skip)));
      } catch (_) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Notifications",
        onGoBack: () {
          Navigator.pop(context);
          // Navigator.pushNamedAndRemoveUntil(
          //     context, RoutesScreen.homePage, (route) => false);
        },
      ),
      body: BlocConsumer<NotificationBloc, NotificationState>(
          listener: (context, state) {
        if (state is NotificationGetsFaulire) {
          errorMessageHandler(
            context,
            state.failure.errorMessage.toString(),
          );
        }
        if (state is NotificationGetsMoreFaulire) {
          errorMessageHandler(
            context,
            state.failure.errorMessage.toString(),
          );
        }
      }, builder: (context, state) {
        if (state is NotificationGetsFaulire) {
          return FaluireWidgetBuilder(
              onTryAgain: fetchNotification, failure: state.failure);
        }
        if (state is NotificationGetsLoading) {
          // return const ShimmeNotificationLoader();
        }
        if (state is NotificationGetsMoreSuccess) {
          if (state.notifiacations.isEmpty) {
            _hasNextPage = false;
          }
          notification.addAll(state.notifiacations);
        }
        return notification.isEmpty
            ? RefreshIndicator(
                onRefresh: () async {
                  await fetchNotification();
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .23,
                    ),
                    SvgPicture.asset(
                      AppAssets.bell,
                      height: 100,
                      colorFilter: const ColorFilter.mode(
                          AppColors.primaryColor, BlendMode.srcIn),
                    ),
                    // Image.asset(AppAssets.emptyNotification),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.info,
                          color: AppColors.grey500,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CustomText(
                          title: "No notification found",
                          textColor: AppColors.grey500,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : Container(
                margin: const EdgeInsets.all(10),
                child: RefreshIndicator(
                  onRefresh: () async {
                    await fetchNotification();
                  },
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ListView.builder(
                            controller: _controller,
                            itemCount: notification.length,
                            itemBuilder: (context, index) {
                              return _notification(
                                notification[index].title ?? "",
                                notification[index].body ?? "",
                                notification[index].createdAt ?? "",
                                notification[index].isSeen ?? false,
                              );
                            }),
                      ),
                      if (state is NotificationGetsMoreLoading)
                        const Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Center(
                            child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.grey,
                                )),
                          ),
                        ),
                    ],
                  ),
                ),
                // );
                // },
              );
      }),
    );
  }

  Container _notification(String title, String body, String date, bool isSeen) {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 238, 238, 238),
              blurRadius: 1.0, // soften the shadow
              spreadRadius: 1.0, //extend the shadow
              offset: Offset(
                1.0, // Move to right 5  horizontally
                4.0, // Move to bottom 5 Vertically
              ),
            )
          ]),
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .03, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  title: title,
                  fontSize: 17,
                ),
                CustomText(
                  title: DateFormat('E, MMM yyyy').format(DateTime.parse(date)),
                  fontSize: 12,
                  textColor: AppColors.primaryColor,
                ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(10)),
                border: Border(
                  left: BorderSide(
                    color: AppColors.primaryColor,
                    width: 2.0,
                  ),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // height: double.infinity,
                  margin: const EdgeInsets.only(bottom: 5),
                  width: 2.5,
                  decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  alignment: Alignment.centerLeft,
                ),
                const SizedBox(
                  width: 4,
                ),
                Flexible(
                  child: Text(
                    body,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xff9E9E9E),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}
