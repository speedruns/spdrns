-- +micrate Up
CREATE TABLE races(
  id          SERIAL PRIMARY KEY,
  name        VARCHAR(255),
  start_time  TIMESTAMP,
  end_time    TIMESTAMP,
  state       VARCHAR(16) NOT NULL,
  created_at  TIMESTAMP NOT NULL,
  updated_at  TIMESTAMP NOT NULL

);

-- +micrate Down
DROP TABLE races;
