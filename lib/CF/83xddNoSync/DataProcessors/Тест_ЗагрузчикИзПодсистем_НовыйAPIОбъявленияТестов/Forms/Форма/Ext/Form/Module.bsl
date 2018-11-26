﻿&НаКлиенте
Перем КонтекстЯдра;
&НаКлиенте
Перем Ожидаем;

&НаКлиенте
Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
	КонтекстЯдра = КонтекстЯдраПараметр;
	Ожидаем = КонтекстЯдра.Плагин("УтвержденияBDD");
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьНаборТестов(НаборТестов) Экспорт
	// Устанавливает режим выполнения для контейнера обработки
	НаборТестов.СлучайныйПорядокВыполнения();
	//НаборТестов.СтрогийПорядокВыполнения();
	
	НаборТестов.Добавить("ТестДолжен_ПроверитьВыполнение_ПростогоТеста");
	
	НаборТестов.НачатьГруппу("Группа со случайным порядком выполнения");
	НаборТестов.Добавить("ТестДолжен_ПроверитьВыполнение_ПростогоТеста_СПроизвольнымПредставлением", , "Тест с произвольным представлением");
	НаборТестов.Добавить("ТестДолжен_ПроверитьВыполнение_ТестаСПараметром", НаборТестов.ПараметрыТеста(Истина));
	
	НаборТестов.НачатьГруппу("Группа со строгим порядком выполнения", Истина);
	НаборТестов.Добавить("ТестДолжен_СохранитьКонтекст");
	НаборТестов.Добавить("ТестДолжен_ПроверитьСохраненныйКонтекст");
	
	НаборТестов.НачатьГруппу("Группа параметризированных тестов со строгим порядком выполнения", Истина);
	НаборТестов.Добавить("ТестДолжен_СохранитьРезультатСложенияВКонтекст", НаборТестов.ПараметрыТеста(5, 7), "Тест должен сохранить результат сложения (5 + 7) в контекст");
	Тест = НаборТестов.Добавить("ТестДолжен_СравнитьКонтекстСоСвоимПараметром");
	Тест.Параметры.Добавить(12);
КонецПроцедуры

&НаКлиенте
Процедура ТестДолжен_ПроверитьВыполнение_ПростогоТеста() Экспорт
	Ожидаем.Что(Истина).ЭтоИстина();
КонецПроцедуры

&НаКлиенте
Процедура ТестДолжен_ПроверитьВыполнение_ПростогоТеста_СПроизвольнымПредставлением() Экспорт
	Ожидаем.Что(Истина).ЭтоИстина();
КонецПроцедуры

&НаКлиенте
Процедура ТестДолжен_ПроверитьВыполнение_ТестаСПараметром(Параметр) Экспорт
	Ожидаем.Что(Параметр).ЭтоИстина();
КонецПроцедуры

// { Группа со строгим режимом выполнения
&НаКлиенте
Процедура ТестДолжен_СохранитьКонтекст() Экспорт
	КонтекстЯдра.СохранитьКонтекст(10);
КонецПроцедуры

&НаКлиенте
Процедура ТестДолжен_ПроверитьСохраненныйКонтекст() Экспорт
	Контекст = КонтекстЯдра.ПолучитьКонтекст();
	Ожидаем.Что(Контекст).Равно(10);
КонецПроцедуры
// } Группа со строгим режимом выполнения

// { Группа параметризированных тестов со строгим режимом выполнения
&НаКлиенте
Процедура ТестДолжен_СохранитьРезультатСложенияВКонтекст(Знач1, Знач2) Экспорт
	КонтекстЯдра.СохранитьКонтекст(Знач1 + Знач2);
КонецПроцедуры

&НаКлиенте
Процедура ТестДолжен_СравнитьКонтекстСоСвоимПараметром(Результат) Экспорт
	Контекст = КонтекстЯдра.ПолучитьКонтекст();
	Ожидаем.Что(Контекст).Равно(Результат);
КонецПроцедуры
// } Группа параметризированных тестов со строгим режимом выполнения
