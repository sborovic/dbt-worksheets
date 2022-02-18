CREATE TABLE mindfulness_worksheet_5a (id INTEGER PRIMARY KEY, parent_id INTEGER, title TEXT, description TEXT, is_leaf INTEGER DEFAULT 0);
INSERT INTO mindfulness_worksheet_5a (title, description, parent_id, id) VALUES ('Ček lista za neosuđivanje, potpunu svesnost i učinkovitost', 'Radni list mindfulness 5a', NULL, 0);
INSERT INTO mindfulness_worksheet_5a (description, parent_id, id) VALUES
("Vežbanje neosuđivanja", 0, 1),
("Izgovorite u sebi „pojavila mi se osuđujuća misao“.", 1, 2),
("Brojte osuđujuće misli i izjave.", 1, 3),
("Zamenite osuđujuće misli i izjave neosuđujućim mislima i izjavama.", 1, 4),
("Posmatrajte svoj izraz lica, držanje tela i ton glasa tokom vrednovanja.", 1, 5),
("Promenite vrednujuće izraze, držanje i ton glasa.", 1, 6),
("Budite konkretni i opišite svoj dan bez osuđivanja.", 1, 7),
("Zapišite, nevrednujući, opis nekog događaja koji je u vama podstakao neku emociju.", 1, 8),
("Napišite jedan veoma detaljan opis o jednom posebno važnom delu vašeg dana.", 1, 9),
("Zamislite osobu na koju ste ljuti. Zamislite da razumete tu osobu.", 1, 10),
("Kad osuđujete, vežbajte „poluosmeh“ i/ili „voljne ruke“.", 1, 11),
("Vežbanje potpune svesnosti", 0, 12),
("Svesnost dok pravite čaj ili kafu.", 12, 13),
("Svesnost dok perete sudove.", 12, 14),
("Svesnost dok ručno perete rublje.", 12, 15),
("Svesnost dok čistite kuću.", 12, 16),
("Svesnost dok se usporeno kupate.", 12, 17),
("Svesnost tokom meditacije.", 12, 18),
("Vežbanje učinkovitosti", 0, 19),
("Odustanite da uvek budete u pravu.", 19, 20),
("Odbacite tvrdoglavost.", 19, 21),
("Radite to što je učinkovito.", 19, 22);
UPDATE mindfulness_worksheet_5a SET is_leaf = 1 WHERE id NOT IN (SELECT DISTINCT parent_id FROM mindfulness_worksheet_5a WHERE parent_id IS NOT NULL);
