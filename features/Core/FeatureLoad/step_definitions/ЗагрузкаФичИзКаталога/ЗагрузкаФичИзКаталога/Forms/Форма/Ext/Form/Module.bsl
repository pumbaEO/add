﻿//начало текста модуля
&НаКлиенте
Перем Ванесса;

&НаКлиенте
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;

	ВсеТесты = Новый Массив;

	// описание шагов
	//пример вызова Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,Транзакция,Параметр);

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯСоздалСлужебныйФайлВОтноситекльномКаталогеСИменем(Парам01,Парам02)","ЯСоздалСлужебныйФайлВОтноситекльномКаталогеСИменем","я создал служебный файл в относитекльном каталоге ""features\Core"" с именем ""TestFile""");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯЗагрузилФичиИзОтносительногоКаталога(Парам01)","ЯЗагрузилФичиИзОтносительногоКаталога","я загрузил фичи из относительного каталога ""features\Core""");

	Возврат ВсеТесты;
КонецФункции

&НаКлиенте
Процедура ПередНачаломСценария() Экспорт

КонецПроцедуры

&НаКлиенте
Процедура ПередОкончаниемСценария() Экспорт
	Попытка
		Если Контекст.Свойство("ОткрытаяФормаVanessaADD") Тогда
			ОткрытаяФормаVanessaADD = Контекст.ОткрытаяФормаVanessaADD;
			ОткрытаяФормаVanessaADD.Закрыть();
		КонецЕсли;
	Исключение

	КонецПопытки;

КонецПроцедуры


&НаКлиенте
Процедура ЗаписатьСлужебныйФайл()
	ЗТ = Новый ЗаписьТекста(Контекст.ИмяСлужебногоФайла,"UTF-8",,Истина);
	ЗТ.ЗаписатьСтроку("");
	ЗТ.Закрыть();
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьУдалениеФайлов(ДополнительныеПараметры) Экспорт
	ХостФорма = Ванесса;
	ХостФорма.ПродолжитьВыполнениеШагов();
КонецПроцедуры

&НаКлиенте
//я создал служебный файл в относитекльном каталоге "features\Core" с именем "TestFile"
//@ЯСоздалСлужебныйФайлВОтноситекльномКаталогеСИменем(Парам01,Парам02)
Процедура ЯСоздалСлужебныйФайлВОтноситекльномКаталогеСИменем(ОтносительныйКаталог,ИмяФайла) Экспорт
	ИмяСлужебногоФайла = Ванесса.Объект.КаталогИнструментов + "\" + ОтносительныйКаталог + "\" + ИмяФайла;
	Контекст.Вставить("ИмяСлужебногоФайла",ИмяСлужебногоФайла);

	Если НЕ Ванесса.ЕстьПоддержкаАсинхронныхВызовов Тогда
		УдалитьФайлы(ИмяСлужебногоФайла);
		ЗаписатьСлужебныйФайл();
	Иначе
		ХостФорма = Ванесса;
		ХостФорма.ЗапретитьВыполнениеШагов();
		ОписаниеОповещения = Вычислить("Новый ОписаниеОповещения(""ОбработатьУдалениеФайлов"", ЭтаФорма)");
		Выполнить("НачатьУдалениеФайлов(ОписаниеОповещения,ИмяСлужебногоФайла)");
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
//я загрузил фичи из относительного каталога "features\Core"
//@ЯЗагрузилФичиИзОтносительногоКаталога(Парам01)
Процедура ЯЗагрузилФичиИзОтносительногоКаталога(ОтносительныйКаталог) Экспорт
	Контекст.ОткрытаяФормаVanessaADD.Объект.КаталогФич = Ванесса.Объект.КаталогИнструментов + "\" + ОтносительныйКаталог;
	Контекст.ОткрытаяФормаVanessaADD.ЗагрузитьФичи();

	ИмяСлужебногоФайла = Контекст.ИмяСлужебногоФайла;

	Если НЕ Ванесса.ЕстьПоддержкаАсинхронныхВызовов Тогда
		УдалитьФайлы(ИмяСлужебногоФайла);
	Иначе
		ХостФорма = Ванесса;
		ХостФорма.ЗапретитьВыполнениеШагов();
		ОписаниеОповещения = Вычислить("Новый ОписаниеОповещения(""ОбработатьУдалениеФайлов"", ЭтаФорма)");
		Выполнить("НачатьУдалениеФайлов(ОписаниеОповещения,ИмяСлужебногоФайла)");
	КонецЕсли;
КонецПроцедуры


//окончание текста модуля