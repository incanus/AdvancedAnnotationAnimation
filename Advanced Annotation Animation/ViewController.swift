import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        let map = MKMapView(frame: view.bounds)
        map.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        map.delegate = self
        view.addSubview(map)

        for i in 0...20 {
            let deltaRandom = Double(arc4random() % 20) * 0.001

            var latRandom = arc4random() % 2
            var lonRandom = arc4random() % 2

            let latDelta = deltaRandom * (latRandom == 1 ? -1 : 1)
            let lonDelta = deltaRandom * (lonRandom == 1 ? -1 : 1)

            let point = MKPointAnnotation()
            point.coordinate = CLLocationCoordinate2D(latitude: 37.783333 + latDelta, longitude: -122.416667 + lonDelta)
            map.addAnnotation(point)
        }

        map.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.783333, longitude: -122.416667), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: false)
    }

    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        return AnnotationView()
    }
}

class AnnotationView: MKAnnotationView {

    var sizeRandom: Int?
    var colorRandom: Int?
    var durationRandom: Int?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override convenience init() {
        let size = Int(arc4random() % 20)

        self.init(frame: CGRect(x: 0, y: 0, width: 20 + size, height: 20 + size))

        sizeRandom     = size
        colorRandom    = Int(arc4random() % 5)
        durationRandom = Int(arc4random() % 5) + 1

        let view = SSPieProgressView(frame: frame)

        let colors = [ UIColor.redColor(), UIColor.blackColor(), UIColor.greenColor(), UIColor.blueColor(), UIColor.purpleColor(), UIColor.orangeColor() ]

        let color = colors[colorRandom!]

        view.pieBorderColor = color
        view.pieFillColor   = color
        view.pieBackgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)

        view.progress = 0.33

        self.addSubview(view)

        UIView.animateWithDuration(NSTimeInterval(durationRandom!), delay: 0, options: .Repeat | .Autoreverse, animations: {
            view.transform = CGAffineTransformMakeRotation(CGFloat(1.5 * M_PI))
        }, completion: nil)

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

