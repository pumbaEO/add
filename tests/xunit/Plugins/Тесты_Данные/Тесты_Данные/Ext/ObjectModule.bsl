﻿Перем КонтекстЯдра;
Перем Утверждения;
Перем Ожидаем;
Перем СериализаторMXL;
Перем СравнениеТаблиц;
Перем Кеш;
Перем Данные;
Перем ЗапросыИзБД;

//{ основная процедура для юнит-тестирования xUnitFor1C
Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
	КонтекстЯдра = КонтекстЯдраПараметр;
	Утверждения = КонтекстЯдра.Плагин("БазовыеУтверждения");
	Ожидаем = КонтекстЯдра.Плагин("УтвержденияBDD");
	СравнениеТаблиц = КонтекстЯдра.Плагин("УтвержденияПроверкаТаблиц");
	СериализаторMXL = КонтекстЯдра.Плагин("СериализаторMXL");
	Данные = КонтекстЯдра.Плагин("Данные");
	ЗапросыИзБД = КонтекстЯдра.Плагин("ЗапросыИзБД");
КонецПроцедуры

Процедура ЗаполнитьНаборТестов(НаборТестов) Экспорт
	
	НаборТестов.НачатьГруппу("Создание набор записей регистров накопления");
		НаборТестов.Добавить("Тест_СоздаетЗаписиРегистраНакопления");
		НаборТестов.Добавить("Тест_ДобавлениеСтрокиВпараметры");
		
	НаборТестов.НачатьГруппу("Создание узла обмена");	
		НаборТестов.Добавить("Тест_СозданиеУзлаОбмена_НовыйИнтерфейс");
		НаборТестов.Добавить("Тест_СозданиеУзлаОбмена_СтарыйИнтерфейс");	
		
	НаборТестов.НачатьГруппу("Создание документов");	
		НаборТестов.Добавить("Тест_СозданиеДокумента_НовыйИнтерфейс");
		НаборТестов.Добавить("Тест_СозданиеДокумента_СтарыйИнтерфейс");
		
	НаборТестов.НачатьГруппу("Создание элементов справочников");
		Набортестов.Добавить("Тест_СозданиеЭлементовСправочников_НовыйИнтерфейс");
		Набортестов.Добавить("Тест_СозданиеЭлементовСправочников_СтарыйИнтерфейс");
		
	НаборТестов.НачатьГруппу("Создание элементов планов вида характеристик");
		Набортестов.Добавить("Тест_СозданиеЭлементовПлановВидовХарактеристик_НовыйИнтерфейс");
		Набортестов.Добавить("Тест_СозданиеЭлементовПлановВидовХарактеристик_СтарыйИнтерфейс");
	
	НаборТестов.НачатьГруппу("Создание наборов регистра бухгалтерии");	
		НаборТестов.Добавить("Тест_СоздаетЗаписиРегистраБухгалтерии");
		
	НаборТестов.НачатьГруппу("Автозаполнение параметров");	
		НаборТестов.Добавить("Тест_РеквизитСправочникаАвтоматическиЗаполнился");
		НаборТестов.Добавить("Тест_ВызваноИСключениеДляСоставногоТипа");
		
КонецПроцедуры

//}

//{ Блок юнит-тестов

Процедура ПередЗапускомТеста() Экспорт
	НачатьТранзакцию();
КонецПроцедуры

Процедура ПослеЗапускаТеста() Экспорт
	Если ТранзакцияАктивна() Тогда
		ОтменитьТранзакцию();
	КонецЕсли;
КонецПроцедуры

#Область РегистрыНакопления

Процедура Тест_ДобавлениеСтрокиВпараметры() Экспорт

	Параметры = Новый Структура;
	Данные.СтрокаНабора(Параметры, Новый Структура("Первый", 1));	
	Данные.СтрокаНабора(Параметры, Новый Структура("Второй", 2));
	
	//Утверждения.ПроверитьТип(Параметры, "Массив", Тип);
	Утверждения.ПроверитьРавенство(2, Параметры.ЭтотОбъект.Количество());

КонецПроцедуры 

Процедура Тест_СоздаетЗаписиРегистраНакопления() Экспорт

	// I подготовка данных
	
	Данные.НачатьСоздание("РегистрНакопления.РегистрНакопленияОстатки")
		.Реквизит("_ОтборРегистратор", Данные.СоздатьДокумент("ДокументСДвижениями"))
		.Реквизит("Период", НачалоДня(ТекущаяДата()))
		.Реквизит("ВидДвижения", ВидДвиженияНакопления.Приход)
		.ШапкаНабора("Измерение1", "РесурсЧисло1")
			.ЗаписьНабора("Тестовое1", 100)
			.ЗаписьНабора("Тестовое2", 120);
	Набор = Данные.Создать();
	
	// II подготовка к вызову и вызов проверяемой функции
	
	// III обработка и проверка результата
	КоличествоЗаписей = ЗапросыИзБД.ПолучитьКоличествоЭлементовРегистраПоОтбору("РегистрНакопления",  "РегистрНакопленияОстатки", Новый Структура("Измерение1", "Тестовое1"));	
	Утверждения.ПроверитьРавенство(1, КоличествоЗаписей);

КонецПроцедуры 

#КонецОбласти

#Область УзлыОбмена

Процедура Тест_СозданиеУзлаОбмена_НовыйИнтерфейс() Экспорт

	//ВызватьИсключение "Нет реализации метода";	

КонецПроцедуры

Процедура Тест_СозданиеУзлаОбмена_СтарыйИнтерфейс() Экспорт

	//ВызватьИсключение "Нет реализации метода";	

КонецПроцедуры

#КонецОбласти

#Область СозданиеСправочников

Процедура Тест_СозданиеЭлементовСправочников_НовыйИнтерфейс() Экспорт

	Данные.НачатьСоздание("Справочник.Справочник1")
	.Реквизит("Реквизит1", Перечисления.Перечисление1.ЗначениеПеречисления1)
	.Реквизит("РеквизитСтрока", "Строка")
	.ШапкаТабличнойЧасти("ТабличнаяЧасть1",
		"РеквизитЧисло", "РеквизитДата")
		.СтрокаТЧ(10, Дата(2,1,1))
		.СтрокаТЧ(20, Дата(3,1,1));
	ЭлементСправочника = Данные.Создать();	
		
	Утверждения.ПроверитьРавенство(Перечисления.Перечисление1.ЗначениеПеречисления1,ЭлементСправочника.Реквизит1);
	Утверждения.ПроверитьРавенство("Строка",ЭлементСправочника.РеквизитСтрока);
	Утверждения.ПроверитьРавенство(2,ЭлементСправочника.ТабличнаяЧасть1.Количество());
	
	Утверждения.ПроверитьРавенство(10,ЭлементСправочника.ТабличнаяЧасть1[0].РеквизитЧисло);
	Утверждения.ПроверитьРавенство(Дата(2,1,1),ЭлементСправочника.ТабличнаяЧасть1[0].РеквизитДата);
	
	Утверждения.ПроверитьРавенство(20,ЭлементСправочника.ТабличнаяЧасть1[1].РеквизитЧисло);
	Утверждения.ПроверитьРавенство(Дата(3,1,1),ЭлементСправочника.ТабличнаяЧасть1[1].РеквизитДата);
	
КонецПроцедуры

Процедура Тест_СозданиеЭлементовСправочников_СтарыйИнтерфейс() Экспорт

	ПараметрыСправочника = Новый Структура;
	ПараметрыСправочника.Вставить("Реквизит1",Перечисления.Перечисление1.ЗначениеПеречисления1);
	ПараметрыСправочника.Вставить("РеквизитСтрока","Строка");
	Данные.НачатьВводТабличнойЧасти(ПараметрыСправочника, "ТабличнаяЧасть1",
		"РеквизитЧисло", "РеквизитДата")
	.СтрокаТЧ(10, Дата(2,1,1))
	.СтрокаТЧ(20, Дата(3,1,1));
	
	ЭлементСправочника = Данные.СоздатьЭлементСправочника("Справочник1", ПараметрыСправочника);
	
	Утверждения.ПроверитьРавенство(Перечисления.Перечисление1.ЗначениеПеречисления1,ЭлементСправочника.Реквизит1);
	Утверждения.ПроверитьРавенство("Строка",ЭлементСправочника.РеквизитСтрока);
	Утверждения.ПроверитьРавенство(2,ЭлементСправочника.ТабличнаяЧасть1.Количество());
	
	Утверждения.ПроверитьРавенство(10,ЭлементСправочника.ТабличнаяЧасть1[0].РеквизитЧисло);
	Утверждения.ПроверитьРавенство(Дата(2,1,1),ЭлементСправочника.ТабличнаяЧасть1[0].РеквизитДата);
	
	Утверждения.ПроверитьРавенство(20,ЭлементСправочника.ТабличнаяЧасть1[1].РеквизитЧисло);
	Утверждения.ПроверитьРавенство(Дата(3,1,1),ЭлементСправочника.ТабличнаяЧасть1[1].РеквизитДата);

КонецПроцедуры

#КонецОбласти

#Область СозданиеДокументов

Процедура Тест_СозданиеДокумента_НовыйИнтерфейс() Экспорт

	ПростойСправочник = Данные.СоздатьЭлементСправочника("ПростойСправочник");
	
	Данные.НачатьСоздание("Документ.ДокументСДвижениями")
		.Реквизит("РеквизитПростойСправочник", ПростойСправочник)
		.ШапкаТабличнойЧасти("ТЧ","Реквизит1", "РесурсЧисло")
			.СтрокаТЧ("Элемент1", 10)
			.СтрокаТЧ("Элемент2", 15);
	Док = Данные.Создать();	
	
	Утверждения.ПроверитьРавенство(ПростойСправочник,Док.РеквизитПростойСправочник);

	Утверждения.ПроверитьРавенство(2,Док.ТЧ.Количество());
	
	Утверждения.ПроверитьРавенство("Элемент1",Док.ТЧ[0].Реквизит1);
	Утверждения.ПроверитьРавенство(10,Док.ТЧ[0].РесурсЧисло);
	
	Утверждения.ПроверитьРавенство("Элемент2",Док.ТЧ[1].Реквизит1);
	Утверждения.ПроверитьРавенство(15,Док.ТЧ[1].РесурсЧисло);

КонецПроцедуры

Процедура Тест_СозданиеДокумента_СтарыйИнтерфейс() Экспорт

	ПростойСправочник = Данные.СоздатьЭлементСправочника("ПростойСправочник");
	
	ПараметрыДокумента = Новый Структура;
	ПараметрыДокумента.Вставить("РеквизитПростойСправочник", ПростойСправочник);
	Данные.НачатьВводТабличнойЧасти(ПараметрыДокумента, "ТЧ",
		,"Реквизит1", "РесурсЧисло")
			.СтрокаТЧ("Элемент1", 10)
			.СтрокаТЧ("Элемент2", 15);
	Док = Данные.СоздатьДокумент("ДокументСДвижениями", ПараметрыДокумента);	
	
	Утверждения.ПроверитьРавенство(ПростойСправочник,Док.РеквизитПростойСправочник);

	Утверждения.ПроверитьРавенство(2,Док.ТЧ.Количество());
	
	Утверждения.ПроверитьРавенство("Элемент1",Док.ТЧ[0].Реквизит1);
	Утверждения.ПроверитьРавенство(10,Док.ТЧ[0].РесурсЧисло);
	
	Утверждения.ПроверитьРавенство("Элемент2",Док.ТЧ[1].Реквизит1);
	Утверждения.ПроверитьРавенство(15,Док.ТЧ[1].РесурсЧисло);

КонецПроцедуры


#КонецОбласти

#Область ПланыВидовХарактеристик

Процедура Тест_СозданиеЭлементовПлановВидовХарактеристик_НовыйИнтерфейс() Экспорт

	Данные.НачатьСоздание("ПланВидовХарактеристик.ВидыСубконто1")
	.Реквизит("РеквизитБулево", Истина);
	ЭлементСправочника = Данные.Создать();
	
	Утверждения.ПроверитьРавенство(Истина,ЭлементСправочника.РеквизитБулево);

КонецПроцедуры

Процедура Тест_СозданиеЭлементовПлановВидовХарактеристик_СтарыйИнтерфейс() Экспорт

	ПараметрыСправочника = Новый Структура;
	ПараметрыСправочника.Вставить("РеквизитБулево",Истина);
	ЭлементСправочника = Данные.СоздатьПланВидовХарактеристик("ВидыСубконто1", ПараметрыСправочника);
	
	Утверждения.ПроверитьРавенство(Истина,ЭлементСправочника.РеквизитБулево);

КонецПроцедуры

#КонецОбласти

#Область РегистрБухгалтерии

Процедура Тест_СоздаетЗаписиРегистраБухгалтерии() Экспорт

	//ВызватьИсключение "Нет реализации метода";	

КонецПроцедуры

#КонецОбласти

#Область АвтозаполнениеПараметров

Процедура Тест_РеквизитСправочникаАвтоматическиЗаполнился() Экспорт

	Данные.НачатьСоздание("Справочники.Справочник1")
		.Реквизит("Реквизит2");
	Объект = Данные.Создать();
	Утверждения.ПроверитьЗаполненность(Объект.Реквизит2);

КонецПроцедуры

Процедура Тест_ВызваноИСключениеДляСоставногоТипа() Экспорт

	Данные.НачатьСоздание("Справочники.Справочник1")
		.Реквизит("СоставнойРеквизит");
	Утверждения.ПроверитьМетодНеВыполнился(Данные, "Создать", "Автозаполнение не поддерживается в составных типах");
	
КонецПроцедуры


#КонецОбласти

Процедура Тест_ОшибкаОписаниеРеквизита() Экспорт

		

КонецПроцедуры 


//}
Кеш = Новый Структура;
