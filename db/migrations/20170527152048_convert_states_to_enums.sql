-- +micrate Up
ALTER TABLE races RENAME COLUMN state TO state_string;
ALTER TABLE memberships RENAME COLUMN state TO state_string;
ALTER TABLE memberships RENAME COLUMN role TO role_string;

-- +micrate Down
ALTER TABLE races RENAME COLUMN state_string TO state;
ALTER TABLE memberships RENAME COLUMN state_string TO state;
ALTER TABLE memberships RENAME COLUMN role_string TO role;
