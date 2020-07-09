SELECT load_extension("./extension-functions");

CREATE TABLE test(x REAL);

INSERT INTO test (x) VALUES
  (1),
  (2),
  (3),
  (4),
  (5);
SELECT stdev(x) FROM test;

SELECT "HELLLO WORLD";