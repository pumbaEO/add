#Использовать asserts
#Использовать logos
#Использовать 1commands

Функция ПутьВанесса() Экспорт

	ФайлИсточника = Новый Файл(ТекущийСценарий().Источник);
	Возврат Новый Файл(ОбъединитьПути(ФайлИсточника.Путь, "..", "bddRunner.epf")).ПолноеИмя;

КонецФункции //ПутьВанесса()

Функция ПутьXDD() Экспорт
	
	ФайлИсточника = Новый Файл(ТекущийСценарий().Источник);
	Возврат Новый Файл(ОбъединитьПути(ФайлИсточника.Путь, "..", "xddTestRunner.epf")).ПолноеИмя;


КонецФункции // ПутьXDD()

Функция КаталогИнструментов() Экспорт

	ФайлИсточника = Новый Файл(ТекущийСценарий().Источник);
	Возврат Новый Файл(ОбъединитьПути(ФайлИсточника.Путь, "..")).ПолноеИмя;

КонецФункции //КаталогИнструментов()

Function GetBDD() Export

	return ПутьВанесса();
	
EndFunction // getBDD()

Function GetXDD() Export

	return ПутьXDD();
	
EndFunction // PathVanessa()


Function InstrumentsPath() Export
	
		return КаталогИнструментов();
		
EndFunction // InstrumentsPath()
	