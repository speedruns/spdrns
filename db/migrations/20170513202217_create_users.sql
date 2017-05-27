-- +micrate Up
CREATE TABLE users(
  id          SERIAL PRIMARY KEY,
  name        VARCHAR(128),
  created_at  TIMESTAMP NOT NULL,
  updated_at  TIMESTAMP NOT NULL
);

-- +micrate Down
DROP TABLE users;
