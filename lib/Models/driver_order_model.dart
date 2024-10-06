
class DriverOrder {
  final String id;
  final String driverId;
  final String status;
  // final String? notes;
  final String shippedType;
  final DateTime assignedAt;
  final OrderDetails orderDetails;


  DriverOrder({
    required this.id,
    required this.driverId,
    required this.status,
     // this.notes,
    required this.assignedAt,
    required this.orderDetails,
    required this.shippedType,
  });

  factory DriverOrder.fromJson(Map<String, dynamic> json) {
    return DriverOrder(
      id: json['_id'],
      driverId: json['driver'],
      status: json['status'],
      shippedType:json['shippedType'],
      assignedAt: json['assignedAt'] != null ? DateTime.parse(json['assignedAt']) : DateTime.now(),
      orderDetails: OrderDetails.fromJson(json['order']),
      // notes: json['notes'] ?? '',
    );
  }
}
class OrderDetails {
  final String id;
  final String customerId;
  final String pickupAddress;
  final DateTime pickupDate;
  // final String pickupTime;
  final String storePhoneNumber;
  final String productCategory;
  final int quantity;
  final String receiverName;
  final String receiverPhoneNumber;
  final String receiverAddress;
  final double orderPrice;
  final double shippingPrice;
  final DateTime receiveDate;
  // final String receiveTime;
  final String paymentMethod;
  final String cashHandlingType;
  final String paymentStatus;
  final String orderStatus;
  final String orderWeight;
  final String notes;
  final double total;
  final DateTime? deliveredAt;
  final DateTime? wareHouseDate;
  final DateTime? driverRecievedDate;
  final DateTime? recieveFromWareHouseDate;
  final DateTime? driverTransferredDate;

  OrderDetails( {
    required this.id,
    required this.customerId,
    required this.pickupAddress,
    required this.pickupDate,
    // required this.pickupTime,
    required this.storePhoneNumber,
    required this.productCategory,
    required this.quantity,
    required this.receiverName,
    required this.receiverPhoneNumber,
    required this.receiverAddress,
    required this.orderPrice,
    required this.shippingPrice,
    required this.receiveDate,
    // required this.receiveTime,
    required this.paymentMethod,
    required this.cashHandlingType,
    required this.paymentStatus,
    required this.orderStatus,
    required this.orderWeight,
    required this.notes,
    required this.total,
    this.deliveredAt,
    this.wareHouseDate,
    this.driverRecievedDate,
    this.recieveFromWareHouseDate,
    this.driverTransferredDate,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      id: json['_id'],
      customerId: json['customerId'],
      pickupAddress: json['pickupAddress'],
      pickupDate: DateTime.parse(json['pickupDate']),
      // pickupTime: json['pickupTime'],
      storePhoneNumber: json['storePhoneNumber'],
      productCategory: json['productCategory'],
      quantity: json['quantity'],
      receiverName: json['receiverName'],
      receiverPhoneNumber: json['receiverPhoneNumber'],
      receiverAddress: json['receiverAddress'],
      orderPrice: json['orderPrice'].toDouble(),
      shippingPrice: json['shippingPrice'].toDouble(),
      receiveDate: DateTime.parse(json['receiveDate']),
      // receiveTime: json['receiveTime'],
      paymentMethod: json['paymentMethod'],
      cashHandlingType: json['cashHandlingType'],
      paymentStatus: json['paymentStatus'],
      orderStatus: json['orderStatus'],
      orderWeight: json['orderWeight'],
      notes: json['notes'],
      total: json['total'].toDouble(),
      deliveredAt: json['deliveredAt'] != null ? DateTime.parse(json['deliveredAt']): null,
      wareHouseDate: json['wareHouseDate'] != null ?DateTime.parse(json['wareHouseDate']): null,
      driverRecievedDate: json['driverRecievedDate'] != null ?DateTime.parse(json['driverRecievedDate'])
          : null,
      recieveFromWareHouseDate: json['recieveFromWareHouseDate'] != null ?DateTime.parse(json['recieveFromWareHouseDate'])
          : null,
      driverTransferredDate: json['driverTransferredDate'] != null ?DateTime.parse(json['driverTransferredDate']) : null,
    );
  }
}
