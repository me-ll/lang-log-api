CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    code VARCHAR(255) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT users_email_check CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
);

CREATE TABLE learning_categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE languages (
    id SERIAL PRIMARY KEY, 
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE learning_languages (
    id SERIAL PRIMARY KEY, 
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    language_id INTEGER REFERENCES languages(id) ON DELETE SET NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE material_types (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE learning_materials (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    material_type_id INTEGER REFERENCES material_types(id) ON DELETE SET NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE learning_logs (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    activity VARCHAR(255) NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    learning_time INTERVAL NOT NULL,
    language_id INTEGER REFERENCES languages(id) ON DELETE SET NULL,
    learning_category_id INTEGER REFERENCES learning_categories(id) ON DELETE SET NULL,
    material_id INTEGER REFERENCES learning_materials(id) ON DELETE SET NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Triggers
CREATE OR REPLACE FUNCTION update_timestamp() 
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER users_updated_at_trigger
BEFORE UPDATE ON users
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

CREATE TRIGGER learning_categories_updated_at_trigger
BEFORE UPDATE ON learning_categories
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

CREATE TRIGGER learning_languages_updated_at_trigger
BEFORE UPDATE ON learning_languages
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

CREATE TRIGGER learning_materials_updated_at_trigger
BEFORE UPDATE ON learning_materials
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

CREATE TRIGGER material_types_updated_at_trigger
BEFORE UPDATE ON material_types
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

CREATE TRIGGER learning_logs_updated_at_trigger
BEFORE UPDATE ON learning_logs
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

CREATE TRIGGER languages_updated_at_trigger
BEFORE UPDATE ON languages
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- seeders
INSERT INTO public.users
(id, code, "name", email, created_at, updated_at)
VALUES(nextval('users_id_seq'::regclass), 'mell', 'メル', 'test@example.com', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO public.languages
(id, name, created_at, updated_at)
VALUES(nextval('languages_id_seq'::regclass), 'English', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO public.languages
(id, name, created_at, updated_at)
VALUES(nextval('languages_id_seq'::regclass), 'Spanish', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO public.learning_categories
(id, , created_at, updated_at)
VALUES(nextval('learning_categories_id_seq'::regclass), 'listening', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO public.learning_categories
(id, name, created_at, updated_at)
VALUES(nextval('learning_categories_id_seq'::regclass), 'reading', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO public.learning_categories
(id, name, created_at, updated_at)
VALUES(nextval('learning_categories_id_seq'::regclass), 'grammar', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO public.learning_categories
(id, name, created_at, updated_at)
VALUES(nextval('learning_categories_id_seq'::regclass), 'writing', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO public.learning_languages
(id, user_id, language_id, is_active, created_at, updated_at)
VALUES(nextval('learning_languages_id_seq'::regclass), 1, 1, true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO public.learning_languages
(id, user_id, language_id, is_active, created_at, updated_at)
VALUES(nextval('learning_languages_id_seq'::regclass), 1, 2, true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO public.material_types
(id, name, created_at, updated_at)
VALUES(nextval('material_types_id_seq'::regclass), 'podcast', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO public.learning_materials
(id, name, material_type_id, is_active, created_at, updated_at)
VALUES(nextval('learning_materials_id_seq'::regclass), '7-minitues English', 1, true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO learning_logs (
    user_id,
    activity,
    start_time,
    end_time,
    learning_time,
    language_id,
    learning_category_id,
    material_id,
    created_at,
    updated_at
)
VALUES (
    1,
    'Chapter 1',
    '2025-02-15 10:00:00',
    '2025-02-15 11:00:00',
    '60 minutes',
    1,
    1,
    1,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
);