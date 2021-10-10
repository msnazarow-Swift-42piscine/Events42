//
//  Intra21Contract.swift
//  Intra21
//
//  Created by out-nazarov2-ms on 25.09.2021.
//  
//

import UIKit

let verticalTranslation = max(!UIWindow.isLandscape ?
                            UIScreen.main.bounds.height / 844.0 :
                            UIScreen.main.bounds.height / 390.0, 1)
let horisontalTranslation = max(!UIWindow.isLandscape ?
                            UIScreen.main.bounds.width / 390.0 :
                            UIScreen.main.bounds.width / 844.0, 1)


/*TODO: Флоу Авторизация -> презентер -> интерактор -> сервис -> комплишн -> презентер получает ответ принимает решение
валалидная пара логин пароль или нет ( вообще не понятно нужен ли пароль) -> если невалидна -> view показать алерт ->
 если валидна -> navigationController.setviewcontroller( короче выкидываем экран авторизации, и устанавливаем главный в
 рут для navigation) -> вью говорит презентеру что загрузилась, презентер просит интерактор подргузить данные по пользователю ( 1 метод), и данные по евентам( 2й метод) -> данные по ивентам отправляем в datasource через updateSections, данные пользователя распаковываем и если не нил вызываем обновление соответствющий полей у вью ( через протокол). Проще и логичней засунуть поля пользователя в tableHeaderView,
 соответствнно сам User экран можно сразу наследоать от tableviewController, соответствнно он же по умолчанию и делегат самого себя
 И в методе didSelectRowAt говорим презентеру didSelectRowAt на какой строке тыкнули, презентер подтягивает соответствующую модель и передает её роутеру, вызывая routeToEventScreen(with event: Event) Вариант 2: более прошаренный, кидаем данные через notification center

Ну в общем то и всё
*/
