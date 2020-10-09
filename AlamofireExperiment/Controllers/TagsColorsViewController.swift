import UIKit

class TagsColorsViewController: UIViewController {
  var tags: [String]?
  var colors: [PhotoColor]?
  var tableViewController: TagsColorsTableViewController?

  @IBOutlet var segmentedControl: UISegmentedControl!

  @IBAction func tagsColorsSegmentedControlChanged(_ sender: UISegmentedControl) {
    setupTableData()
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupTableData()
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "DataTable" {
      tableViewController = segue.destination as? TagsColorsTableViewController
    }
  }

  func setupTableData() {
    if segmentedControl.selectedSegmentIndex == 0 {
      if let tags = tags {
        tableViewController?.data = tags.map {
          TagsColorTableData(label: $0, color: nil)
        }
      } else {
        tableViewController?.data = [TagsColorTableData(label: "No tags were fetched.", color: nil)]
      }
    } else {
      if let colors = colors {
        tableViewController?.data = colors.map({ (photoColor: PhotoColor) -> TagsColorTableData in
          let uicolor = UIColor(
            red: CGFloat(photoColor.red!) / 255,
            green: CGFloat(photoColor.green!) / 255,
            blue: CGFloat(photoColor.blue!) / 255,
            alpha: 1.0
          )

          return TagsColorTableData(label: photoColor.colorName!, color: uicolor)
        })
      } else {
        tableViewController?.data = [TagsColorTableData(label: "No colors were fetched.", color: nil)]
      }
    }

    tableViewController?.tableView.reloadData()
  }
}
