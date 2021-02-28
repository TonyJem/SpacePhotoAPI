import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    let photoInfoController = PhotoInfoController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionLabel.text = ""
        
        photoInfoController.fetchPhotoInfo { (photoInfo) in
            guard let photoInfo = photoInfo else { return }
            DispatchQueue.main.async {
                self.title = photoInfo.title
                self.descriptionLabel.text = photoInfo.description
            }
        }
    }
    
}
