import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krutik_evital_practical/Home/home_page_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (HomeController controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(
              'User Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            backgroundColor: Colors.white,
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      hintText: 'Search...',
                      suffixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1.0),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onChanged: (value) {
                      controller.filterUsers(value);
                    }),
              ),
              Expanded(
                child: ListView.builder(
                  controller: controller.scrollController,
                  itemCount: controller.displayedUsers.length + 1,
                  itemBuilder: (context, index) {
                    if (index == controller.displayedUsers.length) {
                      return controller.isLoading == true
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : const SizedBox.shrink();
                    }
                    final user = controller.displayedUsers[index];
                    return ListTile(
                      leading: ClipOval(
                          child: Image.network(
                        user.imageUrl ?? 'https://randomuser.me/api/portraits/women/4.jpg',
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      )),
                      title: Text(
                        user.name ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${user.city} • ${user.phoneNumber}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      onTap: () {
                        showEditDialog(
                            context: context,
                            index: index,
                            controller: controller,
                            currentRupee: user.rupee);
                      },
                      trailing: Text(
                        user.rupee! > 50 ? 'High' : 'Low',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: user.rupee! > 50 ? Colors.green : Colors.red,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showEditDialog({
    required BuildContext context,
    required int index,
    required HomeController controller,
    int? currentRupee,
  }) {
    final TextEditingController rupeeController =
        TextEditingController(text: currentRupee?.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.teal[50],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Text(
            'Edit Rupee',
            style: TextStyle(
              color: Colors.teal[700],
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            controller: rupeeController,
            keyboardType: TextInputType.number,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              labelText: 'Rupee',
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              labelStyle: TextStyle(color: Colors.teal[700]),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.teal),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal[200]!),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            style: TextStyle(color: Colors.teal[900]),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                backgroundColor: Colors.teal,
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                final newRupee = int.tryParse(rupeeController.text);
                if (newRupee != null) {
                  controller.updateUserRupee(index, newRupee);
                }
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.teal,
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
              child: const Text('Save', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
