//
//  Game.swift
//  Millionaire
//
//  Created by Kirill on 17.08.2022.
//

import Foundation

class Game {
    
    static let shared = Game()

    var gameSession: GameSession?
    private(set) var records: [GameSession] = [] {
        didSet {
            recordsCaretaker.save(records: records)
        }
    }
    private let recordsCaretaker = RecordsCaretaker()
    
    struct Question {
        var text: String
        var answerA: String
        var answerB: String
        var answerC: String
        var answerD: String
        var correctAnswer: Int
    }
    
    var questions: [Question] = [
        Question(text: "Что растёт в огороде?",
                 answerA: "А: Пистолет",
                 answerB: "B: Лук",
                 answerC: "C: Пулемет",
                 answerD: "D: Ракета СС-20",
                 correctAnswer: 1),
        Question(text: "Как называют микроавтобусы, совершающие поездки по определённым маршрутам?",
                 answerA: "А: Рейсовка",
                 answerB: "B: Путевка",
                 answerC: "C: Курсовка",
                 answerD: "D: Маршрутка",
                 correctAnswer: 3),
        Question(text: "О чём писал Грибоедов, отмечая, что он «нам сладок и приятен»?",
                 answerA: "А: Дух купечества",
                 answerB: "B: Дым Отечества",
                 answerC: "C: Дар пророчества",
                 answerD: "D: Пыл девичества",
                 correctAnswer: 1),
        Question(text: "Какого персонажа нет в известной считалке «На золотом крыльце сидели»?",
                 answerA: "А: Сапожника",
                 answerB: "B: Кузнеца",
                 answerC: "C: Короля",
                 answerD: "D: Портного",
                 correctAnswer: 1),
        Question(text: "Где в основном проживают таты?",
                 answerA: "А: Татарстан",
                 answerB: "B: Башкортостан",
                 answerC: "C: Дагестан",
                 answerD: "D: Туркменистан",
                 correctAnswer: 2),
        Question(text: "Какой специалист занимается изучением неопознанных летающих объектов?",
                 answerA: "А: Кинолог",
                 answerB: "B: Уфолог",
                 answerC: "C: Сексопатолог",
                 answerD: "D: Психиатр",
                 correctAnswer: 1),
        Question(text: "Как называется курс парусного судна, совпадающий с направлением ветра?",
                 answerA: "А: Бейдевинд",
                 answerB: "B: Галфинд",
                 answerC: "C: Фордевинд",
                 answerD: "D: Бакштаг",
                 correctAnswer: 2),
        Question(text: "На вершине какой горы расположена сорокаметровая статуя Христа, являющаяся символом Рио-де-Жанейро?",
                 answerA: "А: Тупунгато",
                 answerB: "B: Уаскаран",
                 answerC: "C: Корковадо",
                 answerD: "D: Ильимани",
                 correctAnswer: 2),
        Question(text: "Что такое десница?",
                 answerA: "А: Бровь",
                 answerB: "B: Глаз",
                 answerC: "C: Шея",
                 answerD: "D: Рука",
                 correctAnswer: 3),
        Question(text: "Благодаря какому животному Шурик познакомился с Ниной в к/ф 'Кавказская пленница'?",
                 answerA: "А: Верблюд",
                 answerB: "B: Осел",
                 answerC: "C: Конь",
                 answerD: "D: Ежик",
                 correctAnswer: 1),
        Question(text: "В какое море впадает река Урал?",
                 answerA: "А: Азовское",
                 answerB: "B: Черное",
                 answerC: "C: Средиземное",
                 answerD: "D: Каспийское",
                 correctAnswer: 3),
        Question(text: "Как называется комедия В.В. Маяковского?",
                 answerA: "А: Пена",
                 answerB: "B: Клоп",
                 answerC: "C: Жук",
                 answerD: "D: Паук",
                 correctAnswer: 1),
        Question(text: "Кто является чемпионом гонок 'Формулы-1' 1998-99 г.г.?",
                 answerA: "А: М. Шумахер",
                 answerB: "B: Барикелло",
                 answerC: "C: Кулхард",
                 answerD: "D: Хаккинен",
                 correctAnswer: 3),
        Question(text: "На что кладут руку члены английского общества лысых во время присяги?",
                 answerA: "А: Баскетбольный мяч",
                 answerB: "B: Бильярдный шар",
                 answerC: "C: Апельсин",
                 answerD: "D: Кокосовый орех",
                 correctAnswer: 1),
        Question(text: "Какой из этих городов - родина Казановы?",
                 answerA: "А: Неаполь",
                 answerB: "B: Венеция",
                 answerC: "C: Милан",
                 answerD: "D: Флоренция",
                 correctAnswer: 1),
        Question(text: "Как назывался каменный монолит, на котором установлен памятник Петру I в Санкт-Петербурге?",
                 answerA: "А: Дом-камень",
                 answerB: "B: Гром-камень",
                 answerC: "C: Гора-камень",
                 answerD: "D: Разрыв-камень",
                 correctAnswer: 1),
        Question(text: "Территория какой из этих стран - наибольшая?",
                 answerA: "А: Германия",
                 answerB: "B: Италия",
                 answerC: "C: Япония",
                 answerD: "D: Финляндия",
                 correctAnswer: 2),
        Question(text: "Какое животное имеет второе название — кугуар?",
                 answerA: "А: Оцелот",
                 answerB: "B: Леопард",
                 answerC: "C: Пума",
                 answerD: "D: Пантера",
                 correctAnswer: 2),
        Question(text: "Какая очередность этих трех букв в русском алфавите правильная?",
                 answerA: "А: Ь Ы Ъ",
                 answerB: "B: Ъ Ь Ы",
                 answerC: "C: Ъ Ы Ь",
                 answerD: "D: Ь Ъ Ы",
                 correctAnswer: 2),
        Question(text: "Какая березка стояла во поле?",
                 answerA: "А: Высокая",
                 answerB: "B: Зеленая",
                 answerC: "C: Кудрявая",
                 answerD: "D: Засохшая",
                 correctAnswer: 2),
        Question(text: "Кто из этих знаменитых людей не является тезкой остальных?",
                 answerA: "А: Боярский",
                 answerB: "B: Лермонтов",
                 answerC: "C: Лужков",
                 answerD: "D: Горбачев",
                 correctAnswer: 2),
        Question(text: "Какая из этих рек впадает в Азовское море?",
                 answerA: "А: Днестр",
                 answerB: "B: Дон",
                 answerC: "C: Южный Буг",
                 answerD: "D: Днепр",
                 correctAnswer: 1)
    ]
    
    func addRecord(_ record: GameSession) {
        records.append(record)
    }
    
    func clearRecords() {
        records = []
    }
    
    private init() {
        records = recordsCaretaker.getSavedRecords()
    }
}
