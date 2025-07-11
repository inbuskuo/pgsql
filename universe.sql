--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    is_observable boolean DEFAULT true NOT NULL,
    distance integer NOT NULL,
    image_url character varying(255) NOT NULL
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(100) NOT NULL,
    diameter double precision NOT NULL,
    is_habitable boolean DEFAULT false NOT NULL,
    planet_id integer
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    diameter double precision NOT NULL,
    star_id integer
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(100) NOT NULL,
    type character varying(50) NOT NULL,
    mass double precision NOT NULL,
    galaxy_id integer
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: viewer; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.viewer (
    viewer_id integer NOT NULL,
    name character varying(100) NOT NULL,
    age integer,
    times numeric(5,2) DEFAULT 0.0 NOT NULL,
    email character varying(100) NOT NULL
);


ALTER TABLE public.viewer OWNER TO freecodecamp;

--
-- Name: viewer_viewer_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.viewer_viewer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.viewer_viewer_id_seq OWNER TO freecodecamp;

--
-- Name: viewer_viewer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.viewer_viewer_id_seq OWNED BY public.viewer.viewer_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Name: viewer viewer_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.viewer ALTER COLUMN viewer_id SET DEFAULT nextval('public.viewer_viewer_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', 'The galaxy that contains our Solar System.', true, 0, 'https://example.com/milky_way.jpg');
INSERT INTO public.galaxy VALUES (2, 'Andromeda', 'The nearest spiral galaxy to the Milky Way.', true, 2537000, 'https://example.com/andromeda.jpg');
INSERT INTO public.galaxy VALUES (3, 'Triangulum', 'A spiral galaxy located in the constellation Triangulum.', true, 3000000, 'https://example.com/triangulum.jpg');
INSERT INTO public.galaxy VALUES (4, 'Whirlpool', 'A classic spiral galaxy in the constellation Canes Venatici.', true, 23000000, 'https://example.com/whirlpool.jpg');
INSERT INTO public.galaxy VALUES (5, 'Sombrero', 'A spiral galaxy in the constellation Virgo.', true, 28000000, 'https://example.com/sombrero.jpg');
INSERT INTO public.galaxy VALUES (6, 'Pinwheel', 'A face-on spiral galaxy in the constellation Ursa Major.', true, 21000000, 'https://example.com/pinwheel.jpg');
INSERT INTO public.galaxy VALUES (7, 'Cartwheel', 'A ring galaxy in the constellation Sculptor.', true, 50000000, 'https://example.com/cartwheel.jpg');
INSERT INTO public.galaxy VALUES (8, 'Centaurus A', 'A giant elliptical galaxy in the constellation Centaurus.', true, 13000000, 'https://example.com/centaurus_a.jpg');
INSERT INTO public.galaxy VALUES (9, 'Messier 87', 'A giant elliptical galaxy in the Virgo cluster.', true, 55000000, 'https://example.com/messier_87.jpg');
INSERT INTO public.galaxy VALUES (10, 'Large Magellanic Cloud', 'A satellite galaxy of the Milky Way.', true, 163000, 'https://example.com/large_magellanic_cloud.jpg');
INSERT INTO public.galaxy VALUES (11, 'Small Magellanic Cloud', 'Another satellite galaxy of the Milky Way.', true, 200000, 'https://example.com/small_magellanic_cloud.jpg');


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Luna', 3474.8, true, 1);
INSERT INTO public.moon VALUES (2, 'Phobos', 22.4, false, 2);
INSERT INTO public.moon VALUES (3, 'Deimos', 12.4, false, 2);
INSERT INTO public.moon VALUES (4, 'Io', 3642.6, false, 3);
INSERT INTO public.moon VALUES (5, 'Callisto', 4820.6, false, 3);
INSERT INTO public.moon VALUES (6, 'Titania', 1577.8, false, 5);
INSERT INTO public.moon VALUES (7, 'Oberon', 1522.8, false, 5);
INSERT INTO public.moon VALUES (8, 'Triton', 2706.8, false, 6);
INSERT INTO public.moon VALUES (9, 'Charon', 1212, false, 9);
INSERT INTO public.moon VALUES (10, 'Enceladus', 252.1, false, 4);
INSERT INTO public.moon VALUES (11, 'Rhea', 1527.6, false, 4);
INSERT INTO public.moon VALUES (12, 'Iapetus', 1469, false, 4);
INSERT INTO public.moon VALUES (13, 'Miranda', 471.6, false, 7);
INSERT INTO public.moon VALUES (14, 'Ariel', 1162.8, false, 7);
INSERT INTO public.moon VALUES (15, 'Umbriel', 1169.4, false, 7);
INSERT INTO public.moon VALUES (16, 'Mimas', 396.4, false, 4);
INSERT INTO public.moon VALUES (17, 'Dione', 1123.8, false, 4);
INSERT INTO public.moon VALUES (18, 'Tethys', 1062, false, 4);
INSERT INTO public.moon VALUES (19, 'Phoebe', 218, false, 4);
INSERT INTO public.moon VALUES (20, 'Hyperion', 270, false, 4);
INSERT INTO public.moon VALUES (21, 'Janus', 178, false, 4);
INSERT INTO public.moon VALUES (22, 'Epimetheus', 116, false, 4);
INSERT INTO public.moon VALUES (23, 'Atlas', 30, false, 4);
INSERT INTO public.moon VALUES (24, 'Pandora', 81, false, 4);
INSERT INTO public.moon VALUES (25, 'Prometheus', 86, false, 4);
INSERT INTO public.moon VALUES (26, 'Pan', 28, false, 4);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Earth', 'The third planet from the Sun and the only astronomical object known to harbor life.', 12742, 1);
INSERT INTO public.planet VALUES (2, 'Mars', 'The fourth planet from the Sun, known for its red color.', 6779, 1);
INSERT INTO public.planet VALUES (3, 'Jupiter', 'The largest planet in our Solar System.', 139820, 1);
INSERT INTO public.planet VALUES (4, 'Saturn', 'Known for its prominent ring system.', 116460, 1);
INSERT INTO public.planet VALUES (5, 'Venus', 'The second planet from the Sun, similar in size to Earth.', 12104, 1);
INSERT INTO public.planet VALUES (6, 'Neptune', 'The eighth and farthest planet from the Sun in our Solar System.', 49528, 1);
INSERT INTO public.planet VALUES (7, 'Uranus', 'The seventh planet from the Sun, known for its blue-green color.', 50724, 1);
INSERT INTO public.planet VALUES (8, 'Mercury', 'The closest planet to the Sun.', 4879, 1);
INSERT INTO public.planet VALUES (9, 'Pluto', 'A dwarf planet in the Kuiper belt.', 2376, 1);
INSERT INTO public.planet VALUES (10, 'Titan', 'The largest moon of Saturn, known for its dense atmosphere.', 5150, 4);
INSERT INTO public.planet VALUES (11, 'Europa', 'A moon of Jupiter, believed to have a subsurface ocean.', 3121, 3);
INSERT INTO public.planet VALUES (12, 'Ganymede', 'The largest moon in the Solar System, orbiting Jupiter.', 5268, 3);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Sirius', 'Main Sequence', 2.02, 1);
INSERT INTO public.star VALUES (2, 'Betelgeuse', 'Red Supergiant', 18.5, 1);
INSERT INTO public.star VALUES (3, 'Rigel', 'Blue Supergiant', 21, 1);
INSERT INTO public.star VALUES (4, 'Proxima Centauri', 'Red Dwarf', 0.12, 2);
INSERT INTO public.star VALUES (5, 'Alpha Centauri A', 'Main Sequence', 1.1, 2);
INSERT INTO public.star VALUES (6, 'Alpha Centauri B', 'Main Sequence', 0.9, 2);


--
-- Data for Name: viewer; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.viewer VALUES (1, 'Alice Johnson', 28, 5.00, 'alice.johnson@example.com');
INSERT INTO public.viewer VALUES (2, 'Bob Smith', 34, 10.00, 'bob.smith@example.com');
INSERT INTO public.viewer VALUES (3, 'Charlie Brown', 22, 3.50, 'charlie.brown@example.com');
INSERT INTO public.viewer VALUES (4, 'David Wilson', 45, 8.00, 'david.wilson@example.com');
INSERT INTO public.viewer VALUES (5, 'Eva Green', 30, 6.00, 'eva.green@example.com');
INSERT INTO public.viewer VALUES (6, 'Frank White', 50, 12.00, 'frank.white@example.com');
INSERT INTO public.viewer VALUES (7, 'Grace Lee', 27, 4.00, 'grace.lee@example.com');
INSERT INTO public.viewer VALUES (8, 'Hannah Adams', 31, 7.00, 'hannah.adams@example.com');


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 11, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 26, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 12, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 6, true);


--
-- Name: viewer_viewer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.viewer_viewer_id_seq', 8, true);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: viewer viewer_email_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.viewer
    ADD CONSTRAINT viewer_email_key UNIQUE (email);


--
-- Name: viewer viewer_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.viewer
    ADD CONSTRAINT viewer_pkey PRIMARY KEY (viewer_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

