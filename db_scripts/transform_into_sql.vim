" nalepi tekst
:normal "*p
" izbrisi kvacice
:%s/\v\W{5}\ze\d/\r/g
" izbrisi donje crtice
:%s/\v_//g
" izbrisi razmake na kraju linije
:%s/\s$//g
" izbrisi prazne linije
:g/^$/d
" sastavi linije koje pocinju malim slovom sa prethodnom
:g/^\l/normal -J
" obrisi visestruke razmake
:%s/\v\s{2,}/ /g
" obrisi nepotrebne redove
:g/Ostalo/d
" definisi parent id i id roditelja
:g/^\D/execute "normal I(\"" | execute "normal A\", 0, ".line(".")."),"
" dodaj granicnik
:normal Go(
" dopisi parent id listovima
:g/^([^)]/execute "+1;/^(/-1s/$/\", ".matchstr(getline('.'), '\v\d+\ze\)').", "
" formatiraj pocetak listova
:%s/\v^\d+.\s/(\"/
" formatiraj kraj listova
:%s/\s$/\=" ".line(".")."),"/
:normal Gdd
"dodaj insert
:normal ggiINSERT INTO mindfulness_worksheet_4a (description, parent_id, id) VALUES
"dodaj cvor 0
:normal ggiINSERT INTO mindfulness_worksheet_4a (title, description, parent_id, id) VALUES ('Ček lista za posmatranje, opisivanje i učestovanje', 'Radni list mindfulness 4a', NULL, 0);
"zameni poslednji zarez
:$s/,$/;/
"kreiraj tabelu
:normal ggiCREATE TABLE mindfulness_worksheet_4a (id INTEGER PRIMARY KEY, parent_id INTEGER, title TEXT, description TEXT, is_leaf INTEGER DEFAULT 0, is_deleted INTEGER DEFAULT 0);
"generisi vrednost is_leaf gde treba
:normal GoUPDATE mindfulness_worksheet_4a SET is_leaf = 1 WHERE id NOT IN (SELECT DISTINCT parent_id FROM mindfulness_worksheet_4a WHERE parent_id IS NOT NULL);
