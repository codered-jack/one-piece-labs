-- Runs once, when Postgres starts with an empty data folder. A volume that
-- already holds data skips it, so editing this file changes nothing until the
-- volume is removed.
CREATE TABLE bounties (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 40),
  bounty BIGINT NOT NULL CHECK (bounty BETWEEN 0 AND 99999999999)
);

INSERT INTO bounties (name, bounty) VALUES
  ('Monkey D. Luffy', 3000000000),
  ('Roronoa Zoro', 1111000000),
  ('Sanji', 1032000000),
  ('Usopp', 500000000),
  ('Nami', 366000000);
