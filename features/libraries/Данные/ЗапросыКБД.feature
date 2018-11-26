# language: ru

@Tree

Функционал: Работа с данными информационной базы
	Как разработчик
	Я хочу управлять данными информационной базы
	Чтобы выполнять сложные бизнес-процессы

Сценарий: Работа со справочниками
		Когда в метаданных есть Справочник "Справочник1"
	
		И я работаю с элементами справочника
			И я удаляю все элементы Справочника "Справочник1"
			И в базе нет элементов Справочника "Справочник1"
		
			И я создаю сам один элемент справочника "Справочник1"
			И В базе появился хотя бы один элемент справочника "Справочник1"

		И я работаю с группами элементов справочника
			Когда в базе нет элементов справочника "Справочник1" с указанными в таблице наименованиями
			| Элемент1 |
			| Элемент2 |
			И  Я создаю элементы справочника "Справочник1" с указанными в таблице наименованиями
			| Элемент1 |
			| Элемент2 |
			И в базе есть элементы справочника "Справочник1" с указанными в таблице наименованиями
			| Элемент1 |
			| Элемент2 |
