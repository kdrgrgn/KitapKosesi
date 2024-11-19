

import Foundation
import RxSwift
import RxCocoa

class BaseViewModel {
    let homeLoading : PublishSubject<Bool> = PublishSubject()
    let pageLoading : PublishSubject<Bool> = PublishSubject()
}
