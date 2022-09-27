﻿Процедура НастроитьРасширения() Экспорт
	
	НеПредупреждать = Новый ОписаниеЗащитыОтОпасныхДействий;
	НеПредупреждать.ПредупреждатьОбОпасныхДействиях = Ложь;	
	
	Массив = РасширенияКонфигурации.Получить();	
	Для Каждого Расширение Из Массив Цикл
		
		Расширение.БезопасныйРежим = Ложь;
		Расширение.ЗащитаОтОпасныхДействий = НеПредупреждать;
		Расширение.ИспользоватьОсновныеРолиДляВсехПользователей = Истина;
		Расширение.Записать();
		
	КонецЦикла;
	
КонецПроцедуры
