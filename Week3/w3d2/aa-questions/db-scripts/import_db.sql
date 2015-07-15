-- users setup

DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Rafael', 'Nadal'),
  ('Roger', 'Federer'),
  ('Novak', 'Djokovic'),
  ('Ryan', 'Harris');

-- questions setup

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY, --is this useful?
  title VARCHAR(255) NOT NULL,
  body VARCHAR(255),
  user_id INTEGER REFERENCES users(id)
);

INSERT INTO
  questions(title, body, user_id)
VALUES
  ("Breakfast", "What is your favorite breakfast cereal?", 1),
  ("Lunch", "What is your favorite lunch spot?", 1),
  ("Dinner", "Can you cook meatloaf in the microwave?", 2),
  ("Snack", "Do coconuts have a lot of fat?", 3);

-- questions follows setup

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  question_id INTEGER REFERENCES questions(id)
);

INSERT INTO
  question_follows (user_id, question_id)
  SELECT
    users.id AS user_id,
    questions.id AS question_id
  FROM
    users
  INNER JOIN
    questions ON questions.user_id = users.id
  GROUP BY
    questions.user_id,
    users.id;

-- replies setup

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  parent_id INTEGER REFERENCES replies(id),
  question_id INTEGER REFERENCES questions(id),
  user_id INTEGER REFERENCES users(id),
  body VARCHAR(255)
);

INSERT INTO
  replies (parent_id, question_id, user_id, body)
VALUES
  (NULL, 1, 1, "Cheerios"),
  (1, 1, 2, "Frosted Flakes"),
  (NULL, 2, 2, "McDonalds");

-- question likes setup

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes(
  id INTEGER PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  question_id INTEGER REFERENCES questions(id)
);

INSERT INTO
  question_likes(user_id, question_id)
VALUES
  (1, 3),
  (1, 4),
  (2, 1),
  (3, 2);
