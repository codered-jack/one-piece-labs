-- Sets up the Bounty Board's database. Postgres runs this file only once, when
-- it starts with an empty data folder. A volume that already holds data skips
-- it, so editing this file changes nothing until the volume is removed, with
-- docker compose down -v.

-- The table of bounties: one row per pirate.
CREATE TABLE bounties (
  -- A number for each row, counted up by Postgres: 1, 2, 3, and so on.
  id SERIAL PRIMARY KEY,
  -- The pirate's name: text, from 1 to 40 characters.
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 40),
  -- The bounty in berries: a whole number, up to 99,999,999,999.
  bounty BIGINT NOT NULL CHECK (bounty BETWEEN 0 AND 99999999999)
);

-- The first five bounties. Each row is (name, bounty); the last ends with ;
INSERT INTO bounties (name, bounty) VALUES
  ('Monkey D. Luffy', 3000000000),
  ('Roronoa Zoro', 1111000000),
  ('Sanji', 1032000000),
  ('Usopp', 500000000),
  ('Nami', 366000000);
