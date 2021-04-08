//
//  TemplatesViewModel.swift
//  MemeMaker
//
//  Created by Алексей Черенов on 03.04.2021.
//

final class TemplatesViewModel {
    
	var output: TemplatesOutput?
    
    var assetsManager: AssetsManagerProtocol!
    
    private var memeUrlStrings = [
        "https://sun1-97.userapi.com/impg/KRZgfCC4CLv6Bchsfe1LTpd4K5B8IYA55Hk2Eg/zD-Zp03GApA.jpg?size=655x1080&quality=96&sign=222ed5eb420d81dc56f6c7ba41ebce55&type=album",
        "https://sun1-84.userapi.com/impg/N3TxqmYk_bmrh0QOnOKrHh5qSNberAd3cMOIYw/9EO1MQ8C-Ik.jpg?size=657x493&quality=96&sign=46d5578499c549d8ad0acf8ae1338366&type=album",
        "https://sun1-95.userapi.com/impg/Ap8JmJpOun04R2NJB9JacbOEMOI4rsDBRksYfA/UuRzXq4b8J0.jpg?size=487x389&quality=96&sign=b999864a11d0f454f42c9cdbddad5721&type=album",
        "https://sun1-84.userapi.com/impg/7On7PJxhxlqybkH-xrQi2hOU25eWrPl9YE3Whg/T2oRL450ZEU.jpg?size=640x640&quality=96&sign=3658ac8625231aba77964b0bfb82543f&type=album",
        "https://sun1-99.userapi.com/impg/rg4O3WS4Cb2nMQilvMrEPpqv-p_6h8EgLtNLTg/uI--OTTDIKU.jpg?size=1232x852&quality=96&sign=9ff1a6c79437d2d4138e7b71327a6c5c&type=album",
        "https://sun9-65.userapi.com/impg/gI_c09f1TSlx2UanTGmVi1bm0qybHmr8TcXvuA/lHuj1mZpBoA.jpg?size=711x563&quality=96&sign=f4b6a2f5638c086adf6f7ca24f1499f9&type=album",
        "https://sun1-89.userapi.com/impg/XKRLTzS8b0hzzeM6inp10OSWrvrNcn7kCX245g/Mlqys5UBMGo.jpg?size=539x960&quality=96&sign=e56b444390b04bed0ca81f7c78fb03e5&type=album",
        "https://sun1-97.userapi.com/impg/Woykb-4cuAbAAb32_71o7x4Yx_uHbVw6qwt5_Q/71CmWrBHGCU.jpg?size=465x582&quality=96&sign=b388fdb954489b3e063b14927a7c5a73&type=album",
        "https://sun1-85.userapi.com/impg/CjYH4EQgECqJRLZn_IqV6wiAWjalGaUX0M7T6g/qy3FaOJ0ABI.jpg?size=714x533&quality=96&sign=1f5a9bc9ff055d5a51cf59296523b316&type=album",
        "https://sun1-16.userapi.com/impg/c857320/v857320696/167970/WIRibz9cVwc.jpg?size=958x1224&quality=96&sign=b61d68d0a8da2dd1d4e7a0deab313329&type=album",
        "https://sun1-21.userapi.com/impg/lTXKR59iqRbWCIfhqgbH_Ahz3X2fQGyM1wTZQg/zzTOJJHTh2I.jpg?size=720x691&quality=96&sign=9b28e592ad22f4fac0e90d6277159830&type=album",
        "https://sun9-64.userapi.com/impf/c850220/v850220310/1dab2e/8oyZAG1x3lw.jpg?size=811x406&quality=96&sign=7a07cb0158450d1a1e6a04cae5eeb25f&type=album",
        "https://sun9-63.userapi.com/impf/c855420/v855420693/1ac99/hT0NiGXoQjo.jpg?size=708x944&quality=96&sign=67fecfff90e2debee625390c48fbedf2&type=album"
    ]
    var templates = [MemeTemplate]()

    init() {
        templates.append(contentsOf: memeUrlStrings.map { MemeTemplateRemote(imageUrlString: $0) })
    }
}

// MARK: - Configuration
extension TemplatesViewModel: CustomizableTemplatesViewModel {

}

// MARK: - Interface for view
extension TemplatesViewModel: TemplatesViewModelProtocol {
    
    func pickNewPhotoFromAssets(_ completionHandler: @escaping (ImageAssetProtocol) -> Void) {
        assetsManager.getSinglePhoto(completionHandler)
    }
}

