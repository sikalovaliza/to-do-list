Домашка 1:
1.Реализована верстка двух страниц


Главная страница:
1. Скролл списка дел(не более трех строк для одного дела), сжимание app_bar при скролле
2. Кнопка просмотра списка вместе с выполненными задачами(логика пока работает неправильно, но в этом задании не нужно было)
3. Кнопка редактирования каждой задачи и добавление новой
4. Свайп удаления задачи и свайп отметки "выполнено", здесь разместила иконки в центре строки(мне кажется визуально более логичным эффектом)
5. Кнопка "новое" в конце списка, пока без логики

Страница для редактирования/добавления задачи
1. Текстовое поле для ввода задачи
2. Настройка уровня важности
3. Переключатель с появляющимся календарем и заполнением даты дедлайна
4. Кнопки удалить, сохранить, 'х'


2. У приложения есть иконка под разные размеры(для андроида)
3. А так же реализованно логирования для свайпа пользователем влева и вправо задачи
4. Код отформатирован
5. Прикреплен apk-release файл


Домашка 2:
1. В качестве стейт-менеджмента был выбран подход "BloC" хранящий список заданий и все поля
2. В качестве хранения данных на диске выбран SharedPreferences, теперь при перезагрузке данные не теряются, хранится в отдельном слое(Организовано сохранение данных на диск при помощи одной из представленных библиотек, работа выделена в отдельный слой)
3. flutter analyze не выдает ошибок(Добавлен и работает flutter_lints, в коде нет необоснованных игноров правил)
4. Код отформатирован
5. Код разбит на слои layer-first


![внешний вид приложения](/screens/Снимок%20экрана%202024-06-23%20в%2001.35.05.png)
![внешний вид приложения](/screens/2.png)
![внешний вид приложения](/screens/3.png)
![внешний вид приложения](/screens/4.png)
