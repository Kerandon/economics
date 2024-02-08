import 'package:economics_app/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final biggest = constraints.biggest;
        return Center(
          child: Padding(
            padding: EdgeInsets.all(biggest.width * 0.10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Error - unable to connect to the internet to download app data. '
                  'Please check your internet connection and try again.\n\n',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                          (route) => false);
                    },
                    icon: const Icon(
                      Icons.restart_alt_outlined,
                      size: 50,
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
