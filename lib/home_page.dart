import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_notification/services/notification_service.dart';
import 'package:local_notification/widgets/custom_card.dart';
import 'package:local_notification/widgets/header_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final NotificationService _notificationService = NotificationService();
  DateTime? date;
  TimeOfDay? time;

  @override
  void initState() {
    super.initState();
    initializeNotification();
  }

  initializeNotification() {
    _notificationService.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HeaderWidget(),
            Text(
              "Notification Types",
              style: GoogleFonts.roboto(fontSize: 20.0),
            ),
            SizedBox(height: 10.0),

            CustomCard(
              title: "Instant Notification",
              description: "Send a notification that appears immediately ",
              onClick: () {
                showNotificationInputDialog(isScheduled: false);
              },
              iconData: Icons.notifications,
              iconColor: Colors.deepPurple.shade800,
            ),
            SizedBox(height: 16.0),
            CustomCard(
              title: "Schedule Notification",
              description: "Send a notification that appears after given time ",
              onClick: () {
                showNotificationInputDialog(isScheduled: true);
              },
              iconData: Icons.schedule,
              iconColor: Colors.pinkAccent.shade700,
            ),
          ],
        ),
      ),
    );
  }

  Future showNotificationInputDialog( {required bool isScheduled}) {
     return showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
        title: Text("Send Notification", style: GoogleFonts.lato()),
        content: SingleChildScrollView(
        child:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,

              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Notification Title",
                suffixStyle: GoogleFonts.roboto(),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _descriptionController,
              minLines: 3,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Notification Description",
                suffixStyle: GoogleFonts.roboto(),
              ),
            ),
            SizedBox(height: 20.0),
            if(isScheduled)
              ElevatedButton.icon(
                onPressed: () async {
       DateTime? picked = await showDatePicker(
           context: context,
           firstDate: DateTime.now(),
           lastDate: DateTime.now().add(Duration(days: 2))
       );

       if (picked != null) {
         date = picked;
         TimeOfDay? pickedtime = await showTimePicker(
             context: context,
             initialTime: TimeOfDay.fromDateTime(picked)
         );

         if (pickedtime != null) {

           setState(() {
             date =picked;
             time = pickedtime;

           });
           print(date);
           print(time);
       }
     }
                },
                label: Text("Select Date and Time"),
                icon: Icon(Icons.timer_outlined),
              ),
            Text("$date : $time"),
          ],
        ),
        ),

        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel", style: GoogleFonts.roboto()),
          ),
          TextButton(
            onPressed: () {
    Navigator.pop(context);

    if (isScheduled) {
    _notificationService.sendScheduleNotification(
    title: _titleController.text,
    body: _descriptionController.text,
    dateTime: DateTime(
    date!.year,
    date!.month,
    date!.day,
    time!.hour,
    time!.minute),
    );
    } else {
    _notificationService.sendInstanceNotification(
    title: _titleController.text,
    description: _descriptionController.text,
    );
    _titleController.text = "";
    _descriptionController.text = "";
    }
    },
              child:
              Text("Send notification", style: GoogleFonts.roboto()),

          ),
        ],
      ),
    );
  }
}