import 'package:clipboard/clipboard.dart';
import 'package:eshop/common/widgets/custom_buttons.dart';
import 'package:eshop/common/widgets/sinwave_horizontal_line.dart';
import 'package:eshop/constants/global_variables.dart';
import 'package:eshop/features/admin/service/admin_services.dart';
import 'package:eshop/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:eshop/models/order.dart';

class OrderDetailScreen extends StatefulWidget {
  static const String routeName = '/order-details';
  Order? order; // Made mutable

  OrderDetailScreen({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  int currentStep = 0;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    if (widget.order != null) {
      currentStep = widget.order!.status;
    }
  }

  void changeOrderStatus(int status) {
    if (widget.order != null) {
      adminServices.changeOrderStatus(
        context: context,
        status: status,
        order: widget.order!,
        onSuccess: () {
          setState(() {
            widget.order!.status = status; // Update the order status
            currentStep = status;
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    int handelingCharge = 10;
    bool isAdmin = user.type == 'admin';
    String id = '${widget.order!.id}';

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
                size: 25,
              ),
            ),
          ),
          actions: const [
            Row(
              children: [],
            ),
          ],
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  'Your Orders',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontFamily: 'Regular',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: widget.order == null
          ? const Center(
              child: Text(
                'NO Order yet',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                children: [
                                  const Text(
                                    "Bill details",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'SemiBold',
                                        color: GlobalVariables.faintBlackColor),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '-  ${DateFormat('yyyy-MM-dd').format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          widget.order!.orderedAt),
                                    )}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      'ID: ${id}',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          Clipboard.setData(
                                              ClipboardData(text: id));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    'ID copied to clipboard')),
                                          );
                                        },
                                        child: Icon(
                                          Icons.copy,
                                          size: 12,
                                        )),
                                    const Spacer(),
                                    Text(
                                      'Time: ${DateFormat('hh:mm a').format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            widget.order!.orderedAt),
                                      )}',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(),
                              const Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Item',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Regular',
                                          color: GlobalVariables.faintBlackColor),
                                    ),
                                    // SizedBox(
                                    //   width: 10,
                                    // ),
                                    Text(
                                      'Price(1 Q.)',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Regular',
                                          color: GlobalVariables.faintBlackColor),
                                    ),
                                    Text(
                                      'Quantity',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Regular',
                                          color: GlobalVariables.faintBlackColor),
                                    ),
                                  ],
                                ),
                              ),
                            Padding(
  padding: const EdgeInsets.only(left: 10, right: 20),
  child: Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widget.order!.products.isEmpty
          ? [
              const Center(
                child: Text(
                  'No products in this order.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ]
          : [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: const [
              //     Expanded(
              //       child: Text(
              //         'Name',
              //         style: TextStyle(
              //           fontSize: 16,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ),
              //     Expanded(
              //       child: Text(
              //         'Price',
              //         style: TextStyle(
              //           fontSize: 16,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ),
              //     Expanded(
              //       child: Text(
              //         'Quantity',
              //         style: TextStyle(
              //           fontSize: 16,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(height: 10),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.order!.products.map((product) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Regular',
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.order!.products.map((product) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            (product.price.toInt()).toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Regular',
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  
                  
                  Expanded(
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.order!.products.map((product) {
                        int index = widget.order!.products.indexOf(product);
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            '${widget.order!.quantity[index]}',
                            style: const TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 14,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ],
    ),
  ),
),

                            const Divider(),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 20),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.event_note_sharp,
                                    size: 18,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text(
                                    "Sub Total",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Regular',
                                        color: GlobalVariables.faintBlackColor),
                                  ),
                                  const Spacer(),
                                  // CartSubtotal(),
                                  Text('₹${widget.order!.totalPrice}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Regular',
                                          color:
                                              GlobalVariables.faintBlackColor))
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 10, right: 20),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.shopping_bag_rounded,
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Handeling Charge",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Regular',
                                        color: GlobalVariables.faintBlackColor),
                                  ),
                                  Spacer(),
                                  Text("₹10",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Regular',
                                          color:
                                              GlobalVariables.faintBlackColor)),
                                ],
                              ),
                            ),
                            const Divider(),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 15, right: 20, bottom: 10),
                              child: Row(
                                children: [
                                  Text("Grand Total",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Regular')),
                                  Spacer(),
                                  // CartTotal(),
                                  Text(
                                      '₹${widget.order!.totalPrice + handelingCharge}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Regular',
                                          color:
                                              GlobalVariables.faintBlackColor))
                                ],
                              ),
                            ),
                            Stack(
                              children: [
                                ClipPath(
                                  clipper: SineWaveClipper(
                                    amplitude: 3,
                                    frequency: 15,
                                  ),
                                  child: DecoratedBox(
                                    decoration: const BoxDecoration(),
                                    child: Container(
                                      width: double.infinity,
                                      height: 70, // Adjust the height as needed

                                      decoration: const BoxDecoration(
                                          color: GlobalVariables.savingColor,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(15),
                                              bottomRight:
                                                  Radius.circular(15))),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Positioned(
                                            top:
                                                19, // Adjust this value to position the text correctly
                                            left: 20,
                                            right: 10,
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Total savings",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: GlobalVariables
                                                        .blueTextColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Regular',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            top:
                                                35, // Adjust this value to position the text correctly
                                            left: 20,
                                            right: 10,
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Includes 150 savings through free delivery",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: GlobalVariables
                                                          .lightBlueTextColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Text(
                                        '₹${widget.order!.totalSave + 150}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: GlobalVariables.blueTextColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            left: 15, right: 15, bottom: 10, top: 20),
                        child: Text(
                          "Track Order",
                          style: TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )),
                    Container(
                      child: Stepper(
                        currentStep: currentStep,
                        controlsBuilder: (context, details) {
                          return (isAdmin && widget.order!.status < 3)
                              ? Container(
                                width: 200,
                                child: CustomButton(
                                    text: 'Done',
                                    onTap: () =>
                                        changeOrderStatus(details.stepIndex + 1),
                                        
                                  ),
                              )
                              : const SizedBox();
                        },
                        steps: [
                          Step(
                            title: const Text('Pending'),
                            content: Row(
                              children: [
                                const Text(
                                  'Your order is yet to be accept',
                                ),
                              ],
                            ),
                            isActive: currentStep >= 0,
                            state: currentStep > 0
                                ? StepState.complete
                                : StepState.indexed,
                          ),
                          Step(
                            title: const Text('Accepted'),
                            content: Row(
                              children: [
                                const Text(
                                  'Your order has been Accdepted, yet to ready.',
                                ),
                              ],
                            ),
                            isActive: currentStep >= 1,
                            state: currentStep > 1
                                ? StepState.complete
                                : StepState.indexed,
                          ),
                          Step(
                            title: const Text('Ready'),
                            content: Row(
                              children: [
                                const Text(
                                  'Your order is take away.',
                                ),
                              ],
                            ),
                            isActive: currentStep >= 2,
                            state: currentStep > 2
                                ? StepState.complete
                                : StepState.indexed,
                          ),
                          Step(
                            title: const Text('Delivered'),
                            content: Row(
                              children: [
                                const Text(
                                  'Your order is completed.',
                                ),
                              ],
                            ),
                            isActive: currentStep >= 3,
                            state: currentStep >= 3
                                ? StepState.complete
                                : StepState.indexed,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
