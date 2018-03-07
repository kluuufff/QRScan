import UIKit
import AVFoundation //фреймворк, отвечающий за мультимедия
import Vision

//AVCaptureMetadataOutputObjectsDelegate - делегат для декодирования qr
class ViewControllerScan: UIViewController, AVCaptureMetadataOutputObjectsDelegate  {
    @IBOutlet weak var infoLabel: UITextView!
    @IBOutlet weak var viewCam: UIView!
    
    var captureSession: AVCaptureSession! //сессия захвата
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var qrCodeFrameView: UIView?
    let shapeLayer = CAShapeLayer()
    
    var requests = [VNRequest]()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var captureDevice: AVCaptureDevice! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //захват видео
        captureDevice = AVCaptureDevice.default(for: .video) //устройство захвата; получает данные (1)
        
        //получение и обработка данных
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession = AVCaptureSession() //координация входных и выходных медиаданных
            captureSession?.addInput(input as AVCaptureInput) //входные данные
            
            let captureMetadataOutput = AVCaptureMetadataOutput() //выход данных
            captureSession?.addOutput(captureMetadataOutput)
            
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.upce, AVMetadataObject.ObjectType.code39,
                                                         AVMetadataObject.ObjectType.code39Mod43, AVMetadataObject.ObjectType.code93,
                                                         AVMetadataObject.ObjectType.code128, AVMetadataObject.ObjectType.ean8,
                                                         AVMetadataObject.ObjectType.ean13, AVMetadataObject.ObjectType.aztec,
                                                         AVMetadataObject.ObjectType.pdf417, AVMetadataObject.ObjectType.qr]
            //получая данные из (1), отделяет метаданные типа qr code, barcode
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession) //камера на экране
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = viewCam.layer.bounds
            viewCam.layer.addSublayer(videoPreviewLayer!) //вывод видео на экран
            
            captureSession?.startRunning() //запуск захвата видео
            
            self.viewCam.bringSubview(toFront: self.infoLabel)
            
            qrCodeFrameView = UIView()
            //рамка вокруг qr
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.orange.cgColor
                qrCodeFrameView.layer.borderWidth = 3
                viewCam.addSubview(qrCodeFrameView) //добавление рамки
                viewCam.bringSubview(toFront: qrCodeFrameView)
            }
        } catch {
            print(error)
            return
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let screenSize = qrCodeFrameView?.bounds.size
        if let touchPoint = touches.first {
            let x = touchPoint.location(in: qrCodeFrameView).y / (screenSize?.height)!
            let y = 1.0 - touchPoint.location(in: qrCodeFrameView).x / (screenSize?.width)!
            let focusPoint = CGPoint(x: x, y: y)
            
            if let device = captureDevice {
                do {
                    try device.lockForConfiguration()
                    
                    device.focusPointOfInterest = focusPoint
                    //device.focusMode = .continuousAutoFocus
                    device.focusMode = .autoFocus
                    //device.focusMode = .locked
                    device.exposurePointOfInterest = focusPoint
                    device.exposureMode = AVCaptureDevice.ExposureMode.continuousAutoExposure
                    device.unlockForConfiguration()
                }
                catch {
                    // just ignore
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if metadataObjects == nil || metadataObjects.count == 0 { //проверка на наличие кода
            qrCodeFrameView?.frame = CGRect.zero
            infoLabel.text = "QR Code или Bar Code не найден"
            return
        }
        
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject //создаем объект метадаты и берем из массива первый объект
        
        let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
        qrCodeFrameView?.frame = barCodeObject!.bounds
        
        let countries: [(country: Int, location: String)] =
        [(00, "США и Канада"), (01, "США и Канада"), (02, "США и Канада"), (03, "США и Канада"), (04, "США и Канада"),
         (05, "США и Канада"), (06, "США и Канада"), (07, "США и Канада"), (08, "США и Канада"), (09, "США и Канада"),
         (10, "США и Канада"), (11, "США и Канада"), (12, "США и Канада"), (13, "США и Канада"), (520, "Греция"),
         (521, "Греция"), (600, "Южная Африка"), (601, "Южная Африка"), (770, "Колумбия"), (771, "Колумбия"), (778, "Аргентина"),
         (779, "Аргентина"), (789, "Бразилия"), (790, "Бразилия"), (80, "Италия"), (81, "Италия"), (82, "Италия"),
         (83, "Италия"), (868, "Турция"), (869, "Турция"), (90, "Австрия"), (91, "Австрия"), (690, "Китай"), (691, "Китай"),
         (692, "Китай"), (693, "Китай"), (694, "Китай"), (695, "Китай"), (696, "Китай"), (697, "Китай"), (698, "Китай"),
         (699, "Китай"), (460, "Россия"), (461, "Россия"), (462, "Россия"), (463, "Россия"), (464, "Россия"), (465, "Россия"),
         (466, "Россия"), (467, "Россия"), (468, "Россия"), (469, "Россия"), (400, "Германия"), (401, "Германия"),
         (402, "Германия"), (403, "Германия"), (404, "Германия"), (405, "Германия"), (406, "Германия"), (407, "Германия"),
         (408, "Германия"), (409, "Германия"), (410, "Германия"), (411, "Германия"), (412, "Германия"), (413, "Германия"),
         (414, "Германия"), (415, "Германия"), (416, "Германия"), (417, "Германия"), (417, "Германия"), (418, "Германия"),
         (419, "Германия"), (420, "Германия"), (421, "Германия"), (422, "Германия"), (423, "Германия"), (424, "Германия"),
         (425, "Германия"), (426, "Германия"), (427, "Германия"), (428, "Германия"), (429, "Германия"), (430, "Германия"),
         (431, "Германия"), (432, "Германия"), (433, "Германия"), (434, "Германия"), (435, "Германия"), (436, "Германия"),
         (437, "Германия"), (438, "Германия"), (439, "Германия"), (440, "Германия"), (380, "Болгария"), (383, "Словения"),
         (385, "Хорватия"), (387, "Босния и Герцеговина"), (471, "Тайвань"), (474, "Эстония"), (475, "Латвия"),
         (476, "Азербайджан"), (477, "Литва"), (478, "Узбекистан"), (479, "Шри-Ланка"), (480, "Филиппины"), (481, "Беларусь"),
         (482, "Украина"), (484, "Молдова"), (485, "Армения"), (486, "Грузия"), (487, "Казахстан"), (489, "Гонконг"),
         (50, "Великобритания"), (528, "Ливан"), (529, "Кипр"), (531, "Македония"), (535, "Мальта"), (539, "Ирландия"),
         (54, "Бельгия, Люксембург"), (560, "Португалия"), (569, "Исландия"), (57, "Дания"), (590, "Польша"), (594, "Румыния"),
         (599, "Венгрия"), (609, "Маврикий"), (611, "Марокко"), (613, "Алжир"), (616, "Кения"), (619, "Тунис"), (529, "Кипр"),
         (621, "Сирия"), (622, "Египет"), (624, "Ливия"), (625, "Иордания"), (626, "Иран"), (627, "Кувейт"),
         (628, "Саудовская Аравия"), (629, "Объединенные Арабские Эмираты"), (64, "Финляндия"), (70, "Норвегия"),
         (729, "Израиль"), (73, "Швеция"), (740, "Гватемала"), (741, "Сальвадор"), (742, "Гондурас"), (743, "Никарагуа"),
         (744, "Коста-Рика"), (745, "Панама"), (746, "Доминиканская Республика"), (750, "Мексика"), (759, "Венесуэла"),
         (76, "Швейцария"), (773, "Уругвай"), (775, "Перу"), (777, "Боливия"), (780, "Чили"), (784, "Парагвай"),
         (786, "Эквадор"), (84, "Испания"), (850, "Куба"), (858, "Словакия"), (859, "Чехия"), (860, "Югославия"),
         (867, "Северная Корея"), (87, "Нидерланды"), (880, "Южная Корея"), (885, "Парагвай"), (888, "Эквадор"), (890, "Индия"),
         (893, "Вьетнам"), (899, "Индонезия"), (93, "Австралия"), (94, "Новая Зеландия"), (955, "Малайзия"), (958, "Макао")]
        
        var i = 0
        
        if metadataObj.stringValue != nil { //если можно сконвертировать объект в строку
            
            var strVC2 = ""
            
            let myVC2 = storyboard?.instantiateViewController(withIdentifier: "ViewControllerScanResult2") as! ViewControllerScanResult2
            
            infoLabel.text = metadataObj.stringValue
            strVC2 = infoLabel.text
            
            let arr = countries.map { $0.country }
            
            let testStr1 = infoLabel.text.index(infoLabel.text.startIndex, offsetBy: 2)
            let testStr2 = infoLabel.text.index(infoLabel.text.startIndex, offsetBy: 3)
            let givenId1 = Int(String(infoLabel.text.prefix(upTo: testStr1)))
            let givenId2 = Int(String(infoLabel.text.prefix(upTo: testStr2)))
            let location1 = countries.first{ $0.country == givenId1 }?.location ?? ""
            let location2 = countries.first{ $0.country == givenId2 }?.location ?? ""
          
            while (i < arr.count) {
                if (Int(String(infoLabel.text.prefix(upTo: testStr1))) == arr[i] || Int(String(infoLabel.text.prefix(upTo: testStr2))) == arr[i]) {
                    if location1 != "" {
                        strVC2 += "\n"+location1
                    }
                    else {
                        strVC2 += "\n"+location2
                    }
                }
                i += 1
            }
            
            myVC2.stringPassed = infoLabel.text
            myVC2.stringPassed2 = strVC2
            navigationController?.pushViewController(myVC2, animated: true)
            
            //приостановка видеозахвата
            stopCaptureSession()
        }
        
        //for focus
        //self.qrCodeFrameView.frame = highlightViewRect
        //self.view.bringSubview(toFront: self.qrCodeFrameView!)
        //self.view.addSubview(self.qrCodeFrameView!)
        
    }
    
    open func stopCaptureSession() {
        captureSession?.stopRunning()
    }
    
    open func resumeCaptureSession() {
        captureSession?.startRunning()
    }
}
