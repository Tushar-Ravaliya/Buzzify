import 'package:buzzify/features/chat/widgets/chat_message_bubble.dart';
import 'package:buzzify/features/chat/widgets/message_input_field.dart';
import 'package:flutter/material.dart';
import '../../common/constants/app_colors.dart'; // Using your existing colors

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  // State to control the visibility of the schedule dialog
  bool _isScheduleDialogVisible = false;

  void _toggleScheduleDialog() {
    setState(() {
      _isScheduleDialogVisible = !_isScheduleDialogVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              // Chat messages area
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: const [
                    _TimestampChip(text: 'Just now'),
                    ChatMessageBubble(isSender: true, text: 'hi'),
                    ChatMessageBubble(isSender: false, text: 'hello'),
                    ChatMessageBubble(
                      isSender: true,
                      text: 'ok fine thank u\nlorem',
                    ),
                  ],
                ),
              ),
              // Message input field at the bottom
              MessageInputField(onScheduleTap: _toggleScheduleDialog),
            ],
          ),

          // Conditionally display the schedule dialog as an overlay
          if (_isScheduleDialogVisible)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.4),
                child: Center(
                  child: _ScheduleMessageDialog(
                    onCancel: _toggleScheduleDialog,
                    onSchedule: _toggleScheduleDialog,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Custom AppBar
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      // leading: const Icon(Icons.arrow_back, color: AppColors.black),
      title: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.purple,
            child: Text('A', style: TextStyle(color: AppColors.white)),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Alex',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Online',
                style: TextStyle(color: Colors.green.shade400, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton.icon(
          icon: const Icon(Icons.image_outlined, color: AppColors.grey),
          label: const Text(
            'Upload Wallpaper',
            style: TextStyle(color: AppColors.grey),
          ),
          style: TextButton.styleFrom(
            backgroundColor: AppColors.lightGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {},
        ),
        const Icon(Icons.more_vert, color: AppColors.black),
        const SizedBox(width: 8),
      ],
    );
  }
}

// Widget for the Timestamp
class _TimestampChip extends StatelessWidget {
  final String text;
  const _TimestampChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Chip(label: Text(text), backgroundColor: AppColors.lightGrey),
    );
  }
}

// Widget for the "Schedule Message" dialog
class _ScheduleMessageDialog extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSchedule;

  const _ScheduleMessageDialog({
    required this.onCancel,
    required this.onSchedule,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: const BorderRadius.all(Radius.circular(40)),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Schedule Message',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Text('To: Alex', style: TextStyle(color: AppColors.grey)),
          const SizedBox(height: 16),
          const TextField(
            decoration: InputDecoration(
              hintText: 'Enter your message',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: AppColors.white,
            ),
          ),
          const SizedBox(height: 16),
          const Text('Schedule for:'),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.calendar_today),
                    hintText: '27/8/2025',
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: AppColors.white,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.access_time),
                    hintText: '12:46PM',
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(onPressed: onCancel, child: const Text('Cancel')),
              ElevatedButton(
                onPressed: onSchedule,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                ),
                child: const Text(
                  'Schedule',
                  style: TextStyle(color: AppColors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
