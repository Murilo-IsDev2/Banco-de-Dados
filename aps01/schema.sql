PRAGMA foreign_keys = ON;

CREATE TABLE participante(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    telefone TEXT
);

CREATE TABLE evento(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    descricao TEXT,
    local TEXT NOT NULL,
    data TEXT NOT NULL
);

CREATE TABLE pagamento(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_incricao INTEGER UNIQUE,
    valor REAL,
    data_pagamento TEXT,
    status TEXT,

    FOREIGN KEY (id_incricao) REFERENCES inscricao(id) ON DELETE CASCADE
);

CREATE TABLE inscricao(
    id INTEGER PRIMARY KEY,
    id_evento INTEGER NOT NULL,
    id_participante INTEGER NOT NULL,
    data_inscricao TEXT,
    status TEXT,

    FOREIGN KEY (id_evento) REFERENCES evento(id) ON DELETE CASCADE,
    FOREIGN KEY (id_participante) REFERENCES participante(id) ON DELETE CASCADE
);


INSERT INTO participante(nome, email, telefone) VALUES
('João Lucas', 'joaoLucas@gmail.com', '999121043'), 
('Italo', 'tintin@gmail.com', '999121044'),
('Maria Flor', 'mariaFlor@gmail.com', '999121033');

INSERT INTO evento(nome, descricao, local, data) VALUES
('Expotech', 'Evento de Sistemas de Informação', 'Pátio UNIPAM', '2025-11-12'),
('AgroEvento', 'Evento para apresentar novidades ao Agronegócio', 'Centro de Eventos UNIPAM', '2025-04-28');

INSERT INTO inscricao(id_evento, id_participante, data_inscricao, status) VALUES
(1, 1, '2025-03-20', 'confirmada'),
(2, 2, '2025-04-24', 'cancelada'),
(1, 3, '2025-06-26', 'cancelada'),
(2, 1, '2025-01-27', 'confirmada');


INSERT INTO pagamento(id_incricao, valor, data_pagamento, status) VALUES
(1, 40.50, '2025-03-21', 'confirmada'),
(2, 20.70, '2025-03-27', 'confirmada'),
(3, 40.50, '2025-03-22', 'confirmada'),
(4, 20.70, '2025-03-21', 'confirmada');