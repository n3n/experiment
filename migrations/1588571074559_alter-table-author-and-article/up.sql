
CREATE TABLE "public"."author"("id" serial NOT NULL, "first_name" text, "last_name" text, "created_at" timestamptz DEFAULT now(), "updated_at" timestamptz DEFAULT now(), PRIMARY KEY ("id") ); COMMENT ON TABLE "public"."author" IS E'Author';
CREATE OR REPLACE FUNCTION "public"."set_current_timestamp_updated_at"()
RETURNS TRIGGER AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER "set_public_author_updated_at"
BEFORE UPDATE ON "public"."author"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_author_updated_at" ON "public"."author" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';


CREATE TABLE "public"."article"("id" serial NOT NULL, "name" text, "published_date" date DEFAULT now(), "active" boolean DEFAULT TRUE, "created_at" timestamptz DEFAULT now(), "updated_at" timestamptz DEFAULT now(), "author_id" integer NOT NULL, PRIMARY KEY ("id") , FOREIGN KEY ("author_id") REFERENCES "public"."author"("id") ON UPDATE cascade ON DELETE cascade);
CREATE OR REPLACE FUNCTION "public"."set_current_timestamp_updated_at"()
RETURNS TRIGGER AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER "set_public_article_updated_at"
BEFORE UPDATE ON "public"."article"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_article_updated_at" ON "public"."article" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
