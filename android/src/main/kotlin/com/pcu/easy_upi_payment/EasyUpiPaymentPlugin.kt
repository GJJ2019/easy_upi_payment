package com.pcu.easy_upi_payment

import android.app.Activity
import androidx.annotation.NonNull
import dev.shreyaspatil.easyupipayment.EasyUpiPayment
import dev.shreyaspatil.easyupipayment.listener.PaymentStatusListener
import dev.shreyaspatil.easyupipayment.model.TransactionDetails
import dev.shreyaspatil.easyupipayment.model.TransactionStatus

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** EasyUpiPaymentPlugin */
class EasyUpiPaymentPlugin: FlutterPlugin, MethodCallHandler, ActivityAware, PaymentStatusListener {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private var activity: Activity? = null
  private lateinit var result: Result
  private var easyUpiPayment: EasyUpiPayment? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "easy_upi_payment")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "startPayment" && activity != null) {
        this.result = result
        easyUpiPayment = EasyUpiPayment(activity!!) {
        this.payeeVpa = call.argument<String>("payeeVpa")
        this.payeeName = call.argument<String>("payeeName")
        this.payeeMerchantCode = call.argument<String?>("payeeMerchantCode")
        this.transactionId = call.argument<String>("transactionId")
        this.transactionRefId = call.argument<String>("transactionRefId")
        this.description = call.argument<String?>("description")
        this.amount = call.argument<String>("amount")
      }

      easyUpiPayment?.setPaymentStatusListener(this);
      easyUpiPayment?.startPayment()

    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity;
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null;
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity;
  }

  override fun onDetachedFromActivity() {
    activity = null;
  }

  override fun onTransactionCancelled() {
    result.error("Cancelled", "Transaction cancelled by user", "Transaction was cancelled by the user");
  }

  override fun onTransactionCompleted(transactionDetails: TransactionDetails) {
    when(transactionDetails.transactionStatus) {
      TransactionStatus.FAILURE -> result.error(
        "Failure",
        "Transaction is failed.",
        "Transaction is failed."
      )
      TransactionStatus.SUCCESS -> result.success(
        hashMapOf(
          "transactionId" to transactionDetails.transactionId,
          "responseCode" to transactionDetails.responseCode,
          "approvalRefNo" to transactionDetails.approvalRefNo,
          "transactionRefId" to transactionDetails.transactionRefId,
          "amount" to transactionDetails.amount,
        ),
      )
      TransactionStatus.SUBMITTED -> result.error(
        "Submitted",
        "Transaction is in PENDING state. Money might get deducted from user’s account but not yet deposited in payee’s account.",
        "Transaction is in PENDING state. Money might get deducted from user’s account but not yet deposited in payee’s account."
      )
    }
    easyUpiPayment?.removePaymentStatusListener();
  }
}
