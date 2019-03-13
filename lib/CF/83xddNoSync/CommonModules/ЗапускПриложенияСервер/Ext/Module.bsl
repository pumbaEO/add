﻿
Функция СоздатьПервогоАдминистратораПриНеобходимости(Имя, ПараметрЗапуска) Экспорт
	
	Если ПользователиИнформационнойБазы.ПолучитьПользователей().Количество() > 0 Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Если Не (ПустаяСтрока(ПараметрЗапуска) Или ПараметрЗапуска = "AdminCreate" Или ПараметрЗапуска = "СоздатьАдминистратора") Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Администратор = ПользователиИнформационнойБазы.СоздатьПользователя();
	Администратор.Имя = Имя;
	Администратор.АутентификацияСтандартная = Истина;
	Администратор.ПоказыватьВСпискеВыбора = Истина;
	Администратор.ПолноеИмя = Имя;
	Администратор.Роли.Добавить(Метаданные.Роли.ПолныеПрава);
	Администратор.Язык = Метаданные.Языки.Русский;
	Администратор.Пароль = Имя;
	Администратор.Записать();
	
	Возврат Истина;
	
КонецФункции
