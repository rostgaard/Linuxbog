-- $Id$
-- Gæstebog
-- af Hans Schou

-- Installeres med kommandoen:
--  psql nobody < gaest.sql

--DROP TABLE gaest;
--DROP SEQUENCE gaest_gid_seq;
--DROP INDEX gaest_opdat;

CREATE TABLE gaest(
  gid     serial,
  opdat   timestamp NOT NULL DEFAULT 'now',
  vises   bool NOT NULL DEFAULT 'f',
  navn    text NOT NULL,
  email   text,
  hilsen  text
);

CREATE INDEX gaest_opdat ON gaest(opdat);

COMMENT ON TABLE gaest IS 'Gæstebogen er et eksempel til bøgerne Friheden til at vælge.
Med kun een tabel er dette en lille simpel demonstration af hvordan man kan bruge
databaser sammen med web.';

COMMENT ON COLUMN gaest.gid IS 'GæstID er et unikt ID for hver record';
COMMENT ON COLUMN gaest.opdat IS 'Automatisk variabel der bliver opdateret ved ændringer.';
COMMENT ON COLUMN gaest.vises IS 'Kun godkendte skrivninger i gæstebogen skal vises.
Administrator kan nemt finde dem der ikke vises, og dernæst validere dem.';
COMMENT ON COLUMN gaest.navn IS 'Navnet på den der har skrevet sig ind i gæstebogen.
F.eks. "Jens Jensen"';
COMMENT ON COLUMN gaest.email IS 'E-mail adresse';
COMMENT ON COLUMN gaest.hilsen IS 'En hilsen fra personen';

COMMENT ON INDEX gaest_opdat IS 'Et index der gør det hurtigere at sortere på dato.';

INSERT INTO gaest(vises,navn,email,hilsen)
VALUES('t', 'Mig Selv', 'joe@aol.com', 'Hej mig selv, så er vi igang');

SELECT * FROM gaest WHERE vises ORDER BY opdat DESC;

-- EOF
