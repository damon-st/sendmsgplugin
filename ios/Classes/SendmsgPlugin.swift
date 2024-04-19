import Flutter
import UIKit
import MessageUI
import CoreTelephony



public class SendmsgPlugin: NSObject, FlutterPlugin,MFMessageComposeViewControllerDelegate {

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "sendmsg", binaryMessenger: registrar.messenger())
    let instance = SendmsgPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
     return   result("iOS " + UIDevice.current.systemVersion);
    case "requestPermission":
        
       return result(true);
    case "sendMsg","sendMsgSingle":
        // Verificar si el dispositivo puede enviar mensajes
               guard MFMessageComposeViewController.canSendText() else {
                   print("No se puede enviar mensajes desde este dispositivo.")
                   return result(false)
               }
        guard let args = call.arguments else {
             return  result(false)
             }
        var phone = "";
        var msg = "";
         let myArgs = args as! [String: Any];
        phone = myArgs["phone"] as! String;
        msg = myArgs["msg"] as! String;
        // Solicitar permiso para enviar mensajes
                let messageController = MFMessageComposeViewController()
                messageController.messageComposeDelegate = self
        // Configurar el mensaje y el destinatario (número de teléfono)
              messageController.recipients = [phone] // Reemplaza con el número de teléfono al que deseas enviar el mensaje
              messageController.body = msg
        // Presentar el controlador de mensajes desde el controlador de vista raíz
                if let rootViewController = UIApplication.shared.windows.first?.rootViewController {
                    rootViewController.present(messageController, animated: true, completion: nil)
                } else {
                    print("No se pudo acceder al controlador de vista raíz.")
                }
        return result(true);
    case "getAllSims":
        var infoSim: Array<[String: Any]> = Array()
        // Obtener una instancia de CTTelephonyNetworkInfo
              let networkInfo = CTTelephonyNetworkInfo()
              
              if let carrier = networkInfo.subscriberCellularProvider {
                  // Obtener el nombre del operador
                  let carrierName = carrier.carrierName ?? "Desconocido"
                  
                  print("Nombre del operador: \(carrierName)")
              } else {
                  print("No se pudo obtener información del operador.")
              }
        return result(infoSim)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
    
    public func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result {
               case .cancelled:
                   print("El usuario canceló el envío del mensaje.")
               case .sent:
                   print("Mensaje enviado correctamente.")
               case .failed:
                   print("Error al enviar el mensaje.")
               @unknown default:
                   break
               }
               
               // Cerrar el controlador de mensajes
               controller.dismiss(animated: true, completion: nil)
    }
    
}
