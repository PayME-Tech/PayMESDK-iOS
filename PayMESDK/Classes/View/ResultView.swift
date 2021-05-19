//
//  ResultView.swift
//  PayMESDK
//
//  Created by Minh Khoa on 5/4/21.
//

import Foundation
import Lottie
import RxSwift


class ResultView: UIView {
    public let resultSubject : PublishSubject<Result> = PublishSubject()
    private let disposeBag = DisposeBag()

    let animationView = AnimationView()
    let screenSize: CGRect = UIScreen.main.bounds

    let containerView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(for: ResultView.self, named: "16Px"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let image: UIImageView = {
        var bgImage = UIImageView(image: UIImage(for: ResultView.self, named: "success"))
        bgImage.translatesAutoresizingMaskIntoConstraints = false
        return bgImage
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(24, 26, 65)
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let roleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(45, 187, 84)
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 36, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let failLabel: UILabel = {
        let failLabel = UILabel()
        failLabel.textColor = UIColor(241, 49, 45)
        failLabel.backgroundColor = .clear
        failLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        failLabel.lineBreakMode = .byWordWrapping
        failLabel.numberOfLines = 0
        failLabel.textAlignment = .center
        failLabel.translatesAutoresizingMaskIntoConstraints = false

        return failLabel
    }()

    let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(8, 148, 31)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        return button
    }()

    let detailView: UIView = {
        let detailView = UIView()
        detailView.translatesAutoresizingMaskIntoConstraints = false
        detailView.layer.cornerRadius = 15
        return detailView
    }()

    init(type: Int = 0) {
        super.init(frame: CGRect.zero)
        setupUI()
    }

    func setupUI() {
        backgroundColor = UIColor(242, 244, 243)
        topView.backgroundColor = .white
        detailView.backgroundColor = .white

        containerView.bounces = false

        addSubview(topView)
        addSubview(containerView)
        addSubview(button)
        addSubview(closeButton)

        containerView.addSubview(detailView)

        topView.addSubview(animationView)
        topView.addSubview(nameLabel)
        topView.addSubview(roleLabel)
        topView.addSubview(failLabel)
        // Semi-transparent background
        closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 19).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true

//        containerView.heightAnchor.constraint(equalToConstant: 570).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -8).isActive = true

        topView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.topAnchor.constraint(equalTo: topView.topAnchor, constant: 30).isActive = true
        animationView.heightAnchor.constraint(equalToConstant: 168).isActive = true
        animationView.widthAnchor.constraint(equalToConstant: 168).isActive = true
        animationView.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        animationView.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)

        nameLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 16).isActive = true

        roleLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        roleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4.0).isActive = true
        roleLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -30).isActive = true
        roleLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 30).isActive = true
        roleLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -24).isActive = true
        roleLabel.lineBreakMode = .byWordWrapping
        roleLabel.numberOfLines = 0
        roleLabel.textAlignment = .center

        failLabel.topAnchor.constraint(equalTo: roleLabel.bottomAnchor, constant: 4.0).isActive = true
        failLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -30).isActive = true
        failLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 30).isActive = true
        failLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true

        //detailView - bottomView
        detailView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 20).isActive = true
        detailView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        detailView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true

        //methodView
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        button.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 20).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true


        let bundle = Bundle(for: ResultView.self)
        let bundleURL = bundle.resourceURL?.appendingPathComponent("PayMESDK.bundle")
        let resourceBundle = Bundle(url: bundleURL!)
        let animation = Animation.named("Result_Thanh_Cong", bundle: resourceBundle!)

        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        button.setTitle("HOÀN TẤT", for: .normal)
    }

    func adaptView(result: Result) {
        nameLabel.text = result.titleLabel
        roleLabel.text = "\(formatMoney(input: result.orderTransaction.amount)) đ"
        if result.type == ResultType.SUCCESS {
            failLabel.isHidden = true
        } else {
            failLabel.text = result.failReasonLabel
        }
        let transactionView = TransactionInformationView(id: result.transactionInfo.transaction, time: result.transactionInfo.transactionTime)
        detailView.addSubview(transactionView)
        transactionView.topAnchor.constraint(equalTo: detailView.topAnchor).isActive = true
        transactionView.leadingAnchor.constraint(equalTo: detailView.leadingAnchor).isActive = true
        transactionView.trailingAnchor.constraint(equalTo: detailView.trailingAnchor).isActive = true
        transactionView.bottomAnchor.constraint(equalTo: detailView.bottomAnchor).isActive = true

        let serviceView = InformationView(data: [
            ["key": "Dịch vụ", "value": "\(result.orderTransaction.storeId)"],
            ["key": "Số tiền thanh toán", "value": "\(formatMoney(input: result.orderTransaction.total ?? 0)) đ", "color": UIColor(12, 170, 38)],
            ["key": "Nội dung", "value": result.orderTransaction.note]
        ])
        containerView.addSubview(serviceView)
        serviceView.topAnchor.constraint(equalTo: transactionView.bottomAnchor, constant: 12).isActive = true
        serviceView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        serviceView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true

        if result.type == ResultType.SUCCESS {
            var paymentView: InformationView
            switch result.orderTransaction.paymentMethod?.type {
            case MethodType.WALLET.rawValue:
                paymentView = InformationView(data: [
                    ["key": "Phương thức", "value": "Số dư ví"],
                    ["key": "Phí", "value": "\(formatMoney(input: result.orderTransaction.paymentMethod?.fee ?? 0)) đ"]
                ])
                break
            case MethodType.LINKED.rawValue:
                paymentView = InformationView(data: [
                    ["key": "Phương thức", "value": "Tài khoản liên kết"],
                    ["key": "Số tài khoản", "value": "\(String(describing: result.orderTransaction.paymentMethod?.title ?? ""))-\(String(describing: result.orderTransaction.paymentMethod!.label.suffix(4)))"],
                    ["key": "Phí", "value": "\(String(describing: formatMoney(input: result.orderTransaction.paymentMethod?.fee ?? 0))) đ"],
                ])
                break
            case MethodType.BANK_CARD.rawValue:
                paymentView = InformationView(data: [
                    ["key": "Phương thức", "value": "Thẻ ATM nội địa"],
                    ["key": "Số thẻ", "value": "\(String(describing: result.orderTransaction.paymentMethod?.dataBank?.bank?.shortName ?? ""))-\(String(describing: result.orderTransaction.paymentMethod?.dataBank?.cardNumber.suffix(4) ?? ""))"],
                    ["key": "Phí", "value": "\(String(describing: formatMoney(input: result.orderTransaction.paymentMethod?.fee ?? 0))) đ"]
                ])
            default:
                paymentView = InformationView(data: [])
                break
            }

            containerView.addSubview(paymentView)
            paymentView.topAnchor.constraint(equalTo: serviceView.bottomAnchor, constant: 12).isActive = true
            paymentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
            paymentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        }

        var contentRect: CGRect = containerView.subviews.reduce(into: .zero) { rect, view in
            rect = rect.union(view.frame)
        }
        contentRect = contentRect.union(CGRect(x: 0, y: contentRect.size.height - 16, width: contentRect.size.width, height: 0))
        containerView.contentSize = contentRect.size
        containerView.showsHorizontalScrollIndicator = false
        updateConstraints()
        layoutIfNeeded()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
