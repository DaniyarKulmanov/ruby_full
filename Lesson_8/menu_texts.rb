EXIT = '0 - Выход или введите значение вне меню'
CREATE = '1 - Создать'
DISPLAY = '2 - Просмотр'
MAIN_MENU = ['Основное меню',
             EXIT,
             '1 - Станции',
             '2 - Маршруты',
             '3 - Поезда',
             '4 - Вагоны'
            ]

STATION_MENU = ['Меню станций',
                EXIT,
                CREATE,
                DISPLAY,
                '3 - Посмотреть поезда на станциях'
]

ROUTE_MENU = ['Меню маршрутов',
                EXIT,
                CREATE,
                DISPLAY,
                '3 - Добавить станцию',
                '4 - Удалить станцию'
]

TRAIN_MENU = ['Меню поездов',
              EXIT,
              CREATE,
              DISPLAY,
              '3 - Назначить маршрут поезду',
              '4 - Добавить вагон поезду',
              '5 - Отцепить вагон поезду',
              '6 - Отправить поезд вперед',
              '7 - Отправить поезд назад',
              '8 - Посмотреть вагоны поездов'
]
TRAIN_WAGON_TYPE = ['Тип поезда',
              EXIT,
              '1 - Грузовой',
              '2 - Пассажирский'
]
WAGON_MENU = ['Меню вагонов',
                EXIT,
                CREATE,
                DISPLAY,
              '3 - Занять объем в грузовом вагоне',
              '4 - Занять места в пассажирских вагонах'
]