import 'package:flutter/material.dart';
import 'package:eshop/constants/global_variables.dart';

class AccountPrivacy extends StatefulWidget {
  static const String routeName = '/accountPrivacy';

  const AccountPrivacy({Key? key}) : super(key: key);

  @override
  State<AccountPrivacy> createState() => _AccountPrivacyState();
}

class _AccountPrivacyState extends State<AccountPrivacy> {
  bool _showFullText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Padding(
              padding: EdgeInsets.only(top: 20, left: 10),
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
          actions: const [
            Row(
              children: [
                // IconButton(
                //   onPressed: () {
                //     // Handle shopping cart action
                //   },
                //   icon: const Padding(
                //     padding: EdgeInsets.only(top: 20),
                //     child: Icon(
                //       Icons.shopping_cart_outlined,
                //       color: GlobalVariables.greenColor,
                //       size: 20,
                //     ),
                //   ),
                // ),
                // GestureDetector(
                //   onTap: () {
                //     // Handle share action
                //     // Share.share('Your message here');
                //   },
                //   child: const Padding(
                //     padding: EdgeInsets.only(top: 30, right: 10),
                //     child: Text(
                //       'Share',
                //       style: TextStyle(
                //         fontSize: 16,
                //         color: GlobalVariables.greenColor,
                //         fontFamily: 'SemiBold',
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  'Account Privacy',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontFamily: 'SemiBold',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Account privacy and policy",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Regular'),
              ),
              const SizedBox(
                height: 10,
              ),
              _showFullText
                  ? const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'We i.e. "----" are committed to protecting the privacy and security of your personal information. Your privacy is important to us and maintaining your trust is paramount.',
                          style: TextStyle(fontFamily: 'Regular', fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "This privacy policy explains how we collect, use, process and disclose information about you. By using our website/ app/ platform and affiliated services, you consent to the terms of our privacy policy ('Privacy Policy') in addition to our 'Terms of Use.' We encourage you to read this privacy policy to understand the collection, use, and disclosure of your information from time to time, to keep yourself updated with the changes and updates that we make to this policy.This privacy policy describes our privacy practices for all websites, products and services that are linked to it. However this policy does not apply to those affiliates and partners that have their own privacy policy. In such situations, we recommend that you read the privacy policy on the applicable site.Should you have any clarifications regarding this privacy policy, please write to us at info@----.com ",
                          style: TextStyle(fontSize: 16, fontFamily: 'Regular'),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'We i.e. "----" are committed to protecting the privacy and security of your personal information. Your privacy is important to us and maintaining your trust is paramount.',
                          style: TextStyle(fontSize: 16, fontFamily: 'Regular'),
                          maxLines:
                              5, // Adjust the number of lines to show initially
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                _showFullText = true;
                              });
                            },
                            child: const Row(
                              children: [
                                Text(
                                  "Read more",
                                  style: TextStyle(
                                    color: GlobalVariables
                                        .blueTextColor, // Change color as needed
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Regular', fontSize: 16,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: GlobalVariables.blueTextColor,
                                  size: 20,
                                ),
                              ],
                            )),
                        const SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.withOpacity(
                                    0.5), // Adjust border color as needed
                                width: 1, // Adjust border width as needed
                              ),
                              borderRadius: BorderRadius.circular(
                                  20), // Adjust border radius as needed
                            ),
                            padding: const EdgeInsets.all(
                                8), // Adjust padding as needed
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: GlobalVariables.blueBackground
                                  ),
                                  padding: const EdgeInsets.all(
                                      8), // Adjust padding as needed
                                  child: const Icon(
                                    Icons.delete_outline_outlined,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Request to delete account"),
                                      Text(
                                        "Request to closure of your account",
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  // decoration: BoxDecoration(
                                  //   shape: BoxShape.circle,
                                  //   color: Colors.grey.withOpacity(
                                  //       0.2), // Adjust opacity and color as needed
                                  // ),
                                  padding: const EdgeInsets.all(
                                      8), // Adjust padding as needed
                                  child: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
