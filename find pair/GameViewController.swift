import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var restartBtn: UIButton!

    private var allEmojis = ["🍎","🍊","🍌","🍉","🍇","🍓","🍒","🍍","🥝","🥥"]
    private var chosenEmojis: [String] = []
    private var buttons: [UIButton] = []
    private var shownButtons: [UIButton] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        buttons = [btn1, btn2, btn3, btn4]
        setupGame()
    }

    private func setupGame() {
        winLabel.text = ""
        let randomTwo = allEmojis.shuffled().prefix(2)
        chosenEmojis = Array(randomTwo + randomTwo).shuffled()
        for (i, btn) in buttons.enumerated() {
            btn.setTitle("", for: .normal)
            btn.tag = i
            btn.addTarget(self, action: #selector(handleTap(_:)), for: .touchUpInside)
        }
        restartBtn.addTarget(self, action: #selector(restartGame), for: .touchUpInside)
        shownButtons.removeAll()
    }

    @objc private func handleTap(_ sender: UIButton) {
        let emoji = chosenEmojis[sender.tag]
        sender.setTitle(emoji, for: .normal)
        if !shownButtons.contains(sender) {
            shownButtons.append(sender)
        }
        if shownButtons.count == 3 {
            let first = shownButtons[0]
            let second = shownButtons[1]
            if chosenEmojis[first.tag] != chosenEmojis[second.tag] {
                first.setTitle("", for: .normal)
                second.setTitle("", for: .normal)
            }
            shownButtons.removeFirst(2)
        }
        checkWin()
    }

    private func checkWin() {
        let allOpened = buttons.allSatisfy { $0.currentTitle != "" }
        if allOpened {
            winLabel.text = "You win!"
        }
    }

    @objc private func restartGame() {
        setupGame()
    }
}
