﻿//начало текста модуля

///////////////////////////////////////////////////
//Служебные функции и процедуры
///////////////////////////////////////////////////


// контекст фреймворка Vanessa-Behavior
Перем Ванесса;
 

// Структура, в которой хранится состояние сценария между выполнением шагов. Очищается перед выполнением каждого сценария.
Перем Контекст Экспорт;
 

// Структура, в которой можно хранить служебные данные между запусками сценариев. Существует, пока открыта форма Vanessa-Behavior.
Перем КонтекстСохраняемый Экспорт;


// Функция экспортирует список шагов, которые реализованы в данной внешней обработке.
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;

	//описание параметров
	//пример вызова Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,ОписаниеШага,ТипШага,Транзакция,Параметр);

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯУстановилВКонтекстСохраняемыйЗначениеРавное(Парам01,Парам02)","ЯУстановилВКонтекстСохраняемыйЗначениеРавное","И я установил в КонтекстСохраняемый значение ""СлужебнаяПеременная"" равное 0","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ВКонтекстСохраняемыйЕстьЗначениеРавное(Парам01,Парам02)","ВКонтекстСохраняемыйЕстьЗначениеРавное","Тогда В КонтекстСохраняемый есть значение ""СлужебнаяПеременная"" равное 6","","");

	Возврат ВсеТесты;
КонецФункции
	

// Служебная функция.
Функция ПолучитьМакетСервер(ИмяМакета)
	Возврат ПолучитьМакет(ИмяМакета);
КонецФункции
	

// Служебная функция для подключения библиотеки создания fixtures.
Функция ПолучитьМакетОбработки(ИмяМакета) Экспорт
	Возврат ПолучитьМакетСервер(ИмяМакета);
КонецФункции



///////////////////////////////////////////////////
//Работа со сценариями
///////////////////////////////////////////////////


// Процедура выполняется перед началом каждого сценария
Процедура ПередНачаломСценария() Экспорт
	
КонецПроцедуры


// Процедура выполняется перед окончанием каждого сценария
Процедура ПередОкончаниемСценария() Экспорт
	
КонецПроцедуры



///////////////////////////////////////////////////
//Реализация шагов
///////////////////////////////////////////////////


//И я установил в КонтекстСохраняемый значение "СлужебнаяПеременная" равное 0
//@ЯУстановилВКонтекстСохраняемыйЗначениеРавное(Парам01,Парам02)
Процедура ЯУстановилВКонтекстСохраняемыйЗначениеРавное(ИмяПеременной,Значение) Экспорт
	КонтекстСохраняемый.Вставить(ИмяПеременной,Значение);
КонецПроцедуры


//Тогда В КонтекстСохраняемый есть значение "СлужебнаяПеременная" равное 6
//@ВКонтекстСохраняемыйЕстьЗначениеРавное(Парам01,Парам02)
Процедура ВКонтекстСохраняемыйЕстьЗначениеРавное(ИмяПеременной,Значение) Экспорт
	Если КонтекстСохраняемый[ИмяПеременной] <> Значение Тогда
		ВызватьИсключение "Ожидали в КонтекстСохраняемый в переменной <" + ИмяПеременной + "> значение <" + Значение + ">";
	КонецЕсли;	 
КонецПроцедуры

//окончание текста модуля  