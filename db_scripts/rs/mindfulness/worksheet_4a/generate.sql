CREATE TABLE mindfulness_worksheet_4a (id INTEGER PRIMARY KEY, parent_id INTEGER, title TEXT, description TEXT, is_leaf INTEGER DEFAULT 0);
INSERT INTO mindfulness_worksheet_4a (title, description, parent_id, id) VALUES ('Ček lista za posmatranje, opisivanje i učestovanje', 'Radni list mindfulness 4a', NULL, 0);

INSERT INTO mindfulness_worksheet_4a (description, parent_id, id) VALUES

("Vežbanje posmatranja: Čekirajte vežbu svaki put kad je radite.", 0, 1),
("Šta vidite: Posmatrajte neutralno.", 1, 2),
("Zvukovi: Zvukovi oko vas, visina i zvuk nečijeg glasa, muzika.", 1, 3),
("Mirisi: Aroma hrane, sapun, vazduh dok hodate.", 1, 4),
("Ukusi dok jedete i postupak jedenja.", 1, 5),
("Porivi da nešto uradite: Surfovanje na porivima, primetite poriv da izbegavate nešto, primetite gde se u telu nalazi poriv.", 1, 6),
("Telesne senzacije: Skeniranje tela, senzacije hodanja, dodirivanje nečega.", 1, 7),
("Misli ulaze i izlaze iz vaše svesti: zamislite svest kao reku, kao pokretnu traku.", 1, 8),
("Vaše disanje: Pomeranje stomaka, senzacije vazduha pri udahu i izdahu u nozdravama.", 1, 9),
("Proširite svesnost: Na celo telo, prostor oko vas, grleći drvo.", 1, 10),
("Otvorite um: Svakoj senzaciji koja se pojavi, bez vezivanja, puštajući ih.", 1, 11),
("Vežbanje posmatranja: Čekirajte vežbu svaki put kad je radite.", 0, 12),
("Šta vidite van vašeg tela.", 12, 13),
("Misli, osećanja i telesne senzacije u vama.", 12, 14),
("Vaše disanje.", 12, 15),
("Vežbanje posmatranja: Čekirajte vežbu svaki put kad je radite.", 0, 16),
("Plešite uz muziku.", 16, 17),
("Pevajte dok slušate pesmu.", 16, 18),
("Pevajte dok se tuširate.", 16, 19),
("Pevajte i plešite dok gledate TV.", 16, 20),
("Iskočite iz kreveta i plešite, ili pevajte pre nego što se obučite.", 16, 21),
("Idite u crkvu gde se peva i uživajte u pevanju.", 16, 22),
("Pevajte karaoke sa svojim prijateljima ili u karaoke klubu.", 16, 23),
("U potpunosti se fokusirajte na to što govori druga osoba.", 16, 24),
("Trčite, vozite bicikl, jašite konja, skijajte, šetajte; postanite jedno sa aktivnošću.", 16, 25),
("Bavite se nekim sportom i u potpunosti se predajte igri.", 16, 26),
("Postanite broj dok brojite udahe, postajući samo “jedan” dok brojite 1, postajući samo “dva” dok brojite 2, i tako dalje.", 16, 27),
("Postanite reč dok polako izgovarate reč iznova i iznova.", 16, 28),
("Uključite se u neku društvenu ili radnu aktivnost.", 16, 29);
UPDATE mindfulness_worksheet_4a SET is_leaf = 1 WHERE id NOT IN (SELECT DISTINCT parent_id FROM mindfulness_worksheet_4a WHERE parent_id IS NOT NULL);

