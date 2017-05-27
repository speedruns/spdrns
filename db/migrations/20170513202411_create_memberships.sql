-- +micrate Up
CREATE TABLE memberships(
  id          SERIAL PRIMARY KEY,
  user_id     INT NOT NULL REFERENCES users(id),
  race_id     INT NOT NULL REFERENCES races(id),
  role        VARCHAR(16) NOT NULL,
  state       VARCHAR(16) NOT NULL,
  time        TIMESTAMP,
  created_at  TIMESTAMP NOT NULL,
  updated_at  TIMESTAMP NOT NULL
);

-- +micrate Down
DROP TABLE memberships;
