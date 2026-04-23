--
-- PostgreSQL database dump
--

\restrict x6wxRrTzThGkGwqFgMgJUL6ISy5iHZ6rqXg2kMmQZkfiupaF7reATIEdaGzlyUy

-- Dumped from database version 17.6
-- Dumped by pg_dump version 18.0

-- Started on 2026-04-23 13:44:15 WIB

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3852 (class 1262 OID 71154)
--




\unrestrict x6wxRrTzThGkGwqFgMgJUL6ISy5iHZ6rqXg2kMmQZkfiupaF7reATIEdaGzlyUy
\restrict x6wxRrTzThGkGwqFgMgJUL6ISy5iHZ6rqXg2kMmQZkfiupaF7reATIEdaGzlyUy

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- TOC entry 233 (class 1259 OID 71260)
-- Name: agamas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.agamas (
    id bigint NOT NULL,
    nama character varying(20) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);



--
-- TOC entry 232 (class 1259 OID 71259)
-- Name: agamas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.agamas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



--
-- TOC entry 3854 (class 0 OID 0)
-- Dependencies: 232
-- Name: agamas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.agamas_id_seq OWNED BY public.agamas.id;


--
-- TOC entry 221 (class 1259 OID 71175)
-- Name: cache; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration bigint NOT NULL
);



--
-- TOC entry 222 (class 1259 OID 71183)
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration bigint NOT NULL
);



--
-- TOC entry 229 (class 1259 OID 71221)
-- Name: employees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employees (
    id bigint NOT NULL,
    nip character varying(20) NOT NULL,
    nama character varying(100) NOT NULL,
    tempat_lahir character varying(50) NOT NULL,
    tanggal_lahir date NOT NULL,
    jenis_kelamin character varying(255) NOT NULL,
    alamat text NOT NULL,
    golongan character varying(5) NOT NULL,
    eselon character varying(5),
    jabatan character varying(150) NOT NULL,
    tempat_tugas character varying(100) NOT NULL,
    agama character varying(20) NOT NULL,
    unit_kerja character varying(100) NOT NULL,
    no_hp character varying(20),
    npwp character varying(25),
    foto character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    agama_id bigint,
    unit_kerja_id bigint,
    golongan_id bigint,
    eselon_id bigint,
    CONSTRAINT employees_jenis_kelamin_check CHECK (((jenis_kelamin)::text = ANY ((ARRAY['L'::character varying, 'P'::character varying])::text[])))
);



--
-- TOC entry 228 (class 1259 OID 71220)
-- Name: employees_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.employees_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



--
-- TOC entry 3859 (class 0 OID 0)
-- Dependencies: 228
-- Name: employees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.employees_id_seq OWNED BY public.employees.id;


--
-- TOC entry 237 (class 1259 OID 71278)
-- Name: eselons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eselons (
    id bigint NOT NULL,
    nama character varying(5) NOT NULL,
    keterangan character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);



--
-- TOC entry 236 (class 1259 OID 71277)
-- Name: eselons_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.eselons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



--
-- TOC entry 3862 (class 0 OID 0)
-- Dependencies: 236
-- Name: eselons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.eselons_id_seq OWNED BY public.eselons.id;


--
-- TOC entry 227 (class 1259 OID 71209)
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);



--
-- TOC entry 226 (class 1259 OID 71208)
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



--
-- TOC entry 3865 (class 0 OID 0)
-- Dependencies: 226
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- TOC entry 239 (class 1259 OID 71287)
-- Name: golongans; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.golongans (
    id bigint NOT NULL,
    nama character varying(5) NOT NULL,
    grade character varying(10),
    keterangan character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);



--
-- TOC entry 238 (class 1259 OID 71286)
-- Name: golongans_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.golongans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



--
-- TOC entry 3868 (class 0 OID 0)
-- Dependencies: 238
-- Name: golongans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.golongans_id_seq OWNED BY public.golongans.id;


--
-- TOC entry 225 (class 1259 OID 71201)
-- Name: job_batches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_batches (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text NOT NULL,
    options text,
    cancelled_at integer,
    created_at integer NOT NULL,
    finished_at integer
);



--
-- TOC entry 224 (class 1259 OID 71192)
-- Name: jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);



--
-- TOC entry 223 (class 1259 OID 71191)
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



--
-- TOC entry 3872 (class 0 OID 0)
-- Dependencies: 223
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- TOC entry 218 (class 1259 OID 71156)
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);



--
-- TOC entry 217 (class 1259 OID 71155)
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



--
-- TOC entry 3875 (class 0 OID 0)
-- Dependencies: 217
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- TOC entry 231 (class 1259 OID 71233)
-- Name: personal_access_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personal_access_tokens (
    id bigint NOT NULL,
    tokenable_type character varying(255) NOT NULL,
    tokenable_id bigint NOT NULL,
    name text NOT NULL,
    token character varying(64) NOT NULL,
    abilities text,
    last_used_at timestamp(0) without time zone,
    expires_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);



--
-- TOC entry 230 (class 1259 OID 71232)
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personal_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



--
-- TOC entry 3878 (class 0 OID 0)
-- Dependencies: 230
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personal_access_tokens_id_seq OWNED BY public.personal_access_tokens.id;


--
-- TOC entry 235 (class 1259 OID 71269)
-- Name: unit_kerjas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.unit_kerjas (
    id bigint NOT NULL,
    nama character varying(100) NOT NULL,
    kode character varying(20),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);



--
-- TOC entry 234 (class 1259 OID 71268)
-- Name: unit_kerjas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.unit_kerjas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



--
-- TOC entry 3881 (class 0 OID 0)
-- Dependencies: 234
-- Name: unit_kerjas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.unit_kerjas_id_seq OWNED BY public.unit_kerjas.id;


--
-- TOC entry 220 (class 1259 OID 71163)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(255) NOT NULL,
    role character varying(255) DEFAULT 'viewer'::character varying NOT NULL,
    unit_kerja character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT users_role_check CHECK (((role)::text = ANY ((ARRAY['admin'::character varying, 'operator'::character varying, 'viewer'::character varying])::text[])))
);



--
-- TOC entry 219 (class 1259 OID 71162)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



--
-- TOC entry 3884 (class 0 OID 0)
-- Dependencies: 219
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 3622 (class 2604 OID 71263)
-- Name: agamas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agamas ALTER COLUMN id SET DEFAULT nextval('public.agamas_id_seq'::regclass);


--
-- TOC entry 3620 (class 2604 OID 71224)
-- Name: employees id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees ALTER COLUMN id SET DEFAULT nextval('public.employees_id_seq'::regclass);


--
-- TOC entry 3624 (class 2604 OID 71281)
-- Name: eselons id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eselons ALTER COLUMN id SET DEFAULT nextval('public.eselons_id_seq'::regclass);


--
-- TOC entry 3618 (class 2604 OID 71212)
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- TOC entry 3625 (class 2604 OID 71290)
-- Name: golongans id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.golongans ALTER COLUMN id SET DEFAULT nextval('public.golongans_id_seq'::regclass);


--
-- TOC entry 3617 (class 2604 OID 71195)
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- TOC entry 3614 (class 2604 OID 71159)
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- TOC entry 3621 (class 2604 OID 71236)
-- Name: personal_access_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.personal_access_tokens_id_seq'::regclass);


--
-- TOC entry 3623 (class 2604 OID 71272)
-- Name: unit_kerjas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unit_kerjas ALTER COLUMN id SET DEFAULT nextval('public.unit_kerjas_id_seq'::regclass);


--
-- TOC entry 3615 (class 2604 OID 71166)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3840 (class 0 OID 71260)
-- Dependencies: 233
-- Data for Name: agamas; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.agamas VALUES (1, 'Islam', '2026-04-23 04:39:21', '2026-04-23 04:39:21');
INSERT INTO public.agamas VALUES (2, 'Kristen', '2026-04-23 04:39:21', '2026-04-23 04:39:21');
INSERT INTO public.agamas VALUES (3, 'Katolik', '2026-04-23 04:39:21', '2026-04-23 04:39:21');
INSERT INTO public.agamas VALUES (4, 'Hindu', '2026-04-23 04:39:21', '2026-04-23 04:39:21');
INSERT INTO public.agamas VALUES (5, 'Buddha', '2026-04-23 04:39:21', '2026-04-23 04:39:21');
INSERT INTO public.agamas VALUES (6, 'Konghucu', '2026-04-23 04:39:21', '2026-04-23 04:39:21');


--
-- TOC entry 3828 (class 0 OID 71175)
-- Dependencies: 221
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3829 (class 0 OID 71183)
-- Dependencies: 222
-- Data for Name: cache_locks; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3836 (class 0 OID 71221)
-- Dependencies: 229
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.employees VALUES (6, '197810202003012005', 'Eko Prasetyo', 'Semarang', '1978-10-20', 'L', 'Jl. Pemuda No. 150, Semarang', 'III/d', 'IV', 'Kepala Bidang Restorasi', 'Semarang', 'Islam', 'Pusat Restorasi', '081234567894', '12.345.678.9-005.000', NULL, '2026-04-23 04:14:39', '2026-04-23 04:39:34', NULL, 1, 5, 12, 4);
INSERT INTO public.employees VALUES (1, '3603010406000004', 'Rizqi Reza Ardiansyah', 'Tangerang', '2000-06-04', 'L', 'Villa Balaraja Blok L3 No.06 RT/RW 001/006, Desa Saga, Kecamatan Balaraja, Kabupaten Tangerang. Banten 15610', 'I/a', 'I', 'Direktur Jenderal', 'Tangerang', 'Islam', 'Direktorat', '085142008386', '92.821.055.8-451.000', 'http://localhost:8000/storage/photos/05e109a8-be34-4fa8-a610-c2b48bdbd45c.jpg', '2026-04-23 04:10:00', '2026-04-23 04:14:09', '2026-04-23 04:14:09', NULL, NULL, NULL, NULL);
INSERT INTO public.employees VALUES (2, '197503152000031001', 'Budi Santoso', 'Jakarta', '1975-03-15', 'L', 'Jl. Merdeka No. 10, Jakarta Pusat', 'IV/e', 'I', 'Kepala Sekretariat Utama', 'Jakarta', 'Islam', 'Sekretariat Utama', '081234567890', '12.345.678.9-001.000', NULL, '2026-04-23 04:14:39', '2026-04-23 04:39:34', NULL, 1, 1, 17, 1);
INSERT INTO public.employees VALUES (3, '198008122002022002', 'Siti Aminah', 'Bandung', '1980-08-12', 'P', 'Jl. Asia Afrika No. 25, Bandung', 'IV/d', 'II', 'Kepala Bidang Pengembangan Standar', 'Bandung', 'Islam', 'Pusat Pengembangan Standar', '081234567891', '12.345.678.9-002.000', NULL, '2026-04-23 04:14:39', '2026-04-23 04:39:34', NULL, 1, 3, 16, 2);
INSERT INTO public.employees VALUES (4, '198512152005011003', 'Ahmad Rizky', 'Surabaya', '1985-12-15', 'L', 'Jl. Tunjungan No. 45, Surabaya', 'III/c', 'III', 'Kepala Bagian Data Geospasial', 'Surabaya', 'Islam', 'Pusat Data Geospasial', '081234567892', '12.345.678.9-003.000', NULL, '2026-04-23 04:14:39', '2026-04-23 04:39:34', NULL, 1, 2, 11, 3);
INSERT INTO public.employees VALUES (5, '198205102008022004', 'Dewi Sartika', 'Medan', '1982-05-10', 'P', 'Jl. Gatot Subroto No. 100, Medan', 'IV/c', 'II', 'Kepala Bidang Informasi Geospasial', 'Medan', 'Kristen', 'Pusat Informasi Geospasial', '081234567893', '12.345.678.9-004.000', NULL, '2026-04-23 04:14:39', '2026-04-23 04:39:34', NULL, 2, 4, 15, 2);
INSERT INTO public.employees VALUES (7, '198302252010122006', 'Fitri Handayani', 'Makassar', '1983-02-25', 'P', 'Jl. Pettarani No. 80, Makassar', 'III/b', 'III', 'Kepala Seksi Survei Kependudukan', 'Makassar', 'Islam', 'Pusat Survei Kependudukan', '081234567895', '12.345.678.9-006.000', NULL, '2026-04-23 04:14:39', '2026-04-23 04:39:34', NULL, 1, 6, 10, 3);
INSERT INTO public.employees VALUES (8, '198809152012032007', 'Gunawan Wijaya', 'Yogyakarta', '1988-09-15', 'L', 'Jl. Malioboro No. 55, Yogyakarta', 'III/a', 'IV', 'Kepala Seksi Pemetaan Dasar', 'Yogyakarta', 'Islam', 'Pusat Pemetaan Dasar', '081234567896', '12.345.678.9-007.000', NULL, '2026-04-23 04:14:39', '2026-04-23 04:39:34', NULL, 1, 7, 9, 4);
INSERT INTO public.employees VALUES (9, '197612122005012008', 'Hartono Gunawan', 'Denpasar', '1976-12-12', 'L', 'Jl. Raya Denpasar No. 200, Denpasar', 'IV/e', 'I', 'Deputi Bidang Pengembangan Standar', 'Denpasar', 'Hindu', 'Pusat Pengembangan Standar', '081234567897', '12.345.678.9-008.000', NULL, '2026-04-23 04:14:39', '2026-04-23 04:39:34', NULL, 4, 3, 17, 1);
INSERT INTO public.employees VALUES (10, '198406182008022009', 'Indah Permata', 'Jakarta', '1984-06-18', 'P', 'Jl. Sudirman No. 120, Jakarta Selatan', 'IV/a', 'II', 'Kepala Bidang Data Geospasial', 'Jakarta', 'Katolik', 'Pusat Data Geospasial', '081234567898', '12.345.678.9-009.000', NULL, '2026-04-23 04:14:39', '2026-04-23 04:39:34', NULL, 3, 2, 13, 2);
INSERT INTO public.employees VALUES (11, '198903122012011010', 'Joko Widodo', 'Surakarta', '1989-03-12', 'L', 'Jl. Solo Raya No. 75, Surakarta', 'III/c', 'IV', 'Kepala Seksi Informasi Geospasial', 'Surakarta', 'Islam', 'Pusat Informasi Geospasial', '081234567899', '12.345.678.9-010.000', NULL, '2026-04-23 04:14:39', '2026-04-23 04:39:34', NULL, 1, 4, 11, 4);
INSERT INTO public.employees VALUES (12, '197907202003102011', 'Kartika Sari', 'Bandung', '1979-07-20', 'P', 'Jl. Dago Atas No. 30, Bandung', 'IV/b', 'III', 'Kepala Bagian Restorasi', 'Bandung', 'Islam', 'Pusat Restorasi', '081234567900', '12.345.678.9-011.000', NULL, '2026-04-23 04:14:39', '2026-04-23 04:39:34', NULL, 1, 5, 14, 3);
INSERT INTO public.employees VALUES (13, '198611182010122012', 'Lukman Hakim', 'Medan', '1986-11-18', 'L', 'Jl. Gatot Subroto No. 150, Medan', 'III/b', 'IV', 'Kepala Seksi Survei Kependudukan', 'Medan', 'Islam', 'Pusat Survei Kependudukan', '081234567901', '12.345.678.9-012.000', NULL, '2026-04-23 04:14:39', '2026-04-23 04:39:34', NULL, 1, 6, 10, 4);
INSERT INTO public.employees VALUES (14, '198804052012032013', 'Maria Kristina', 'Manado', '1988-04-05', 'P', 'Jl. Piere Tendean No. 90, Manado', 'III/a', 'IV', 'Kepala Seksi Pemetaan Dasar', 'Manado', 'Kristen', 'Pusat Pemetaan Dasar', '081234567902', '12.345.678.9-013.000', NULL, '2026-04-23 04:14:39', '2026-04-23 04:39:34', NULL, 2, 7, 9, 4);
INSERT INTO public.employees VALUES (15, '197709182005012014', 'Novi Anggraini', 'Padang', '1977-09-18', 'P', 'Jl. Khatib Sulaiman No. 60, Padang', 'IV/c', 'II', 'Kepala Bidang Informasi Geospasial', 'Padang', 'Islam', 'Pusat Informasi Geospasial', '081234567903', '12.345.678.9-014.000', NULL, '2026-04-23 04:14:39', '2026-04-23 04:39:34', NULL, 1, 4, 15, 2);
INSERT INTO public.employees VALUES (16, '198501202008022015', 'Oscar Kurniawan', 'Palembang', '1985-01-20', 'L', 'Jl. Jendral Sudirman No. 200, Palembang', 'IV/a', 'II', 'Kepala Bagian Data Geospasial', 'Palembang', 'Islam', 'Pusat Data Geospasial', '081234567904', '12.345.678.9-015.000', NULL, '2026-04-23 04:14:39', '2026-04-23 04:39:34', NULL, 1, 2, 13, 2);
INSERT INTO public.employees VALUES (17, '198710252012032016', 'Putri Ayu', 'Pekanbaru', '1987-10-25', 'P', 'Jl. Tuanku Tambusai No. 120, Pekanbaru', 'III/c', 'IV', 'Kepala Seksi Informasi Geospasial', 'Pekanbaru', 'Islam', 'Pusat Informasi Geospasial', '081234567905', '12.345.678.9-016.000', NULL, '2026-04-23 04:14:39', '2026-04-23 04:39:34', NULL, 1, 4, 11, 4);
INSERT INTO public.employees VALUES (18, '197406122005102017', 'Qodar Salim', 'Banda Aceh', '1974-06-12', 'L', 'Jl. Teuku Umar No. 180, Banda Aceh', 'IV/e', 'I', 'Kepala Bidang Restorasi', 'Banda Aceh', 'Islam', 'Pusat Restorasi', '081234567906', '12.345.678.9-017.000', NULL, '2026-04-23 04:14:39', '2026-04-23 04:39:34', NULL, 1, 5, 17, 1);
INSERT INTO public.employees VALUES (19, '198308202010122018', 'Ratna Sari', 'Bogor', '1983-08-20', 'P', 'Jl. Ir. H. Juanda No. 90, Bogor', 'IV/b', 'III', 'Kepala Bagian Restorasi', 'Bogor', 'Islam', 'Pusat Restorasi', '081234567907', '12.345.678.9-018.000', NULL, '2026-04-23 04:14:39', '2026-04-23 04:39:34', NULL, 1, 5, 14, 3);
INSERT INTO public.employees VALUES (20, '199005152012032019', 'Sandi Pratama', 'Cirebon', '1990-05-15', 'L', 'Jl. Siliwangi No. 45, Cirebon', 'III/a', 'IV', 'Kepala Seksi Pemetaan Dasar', 'Cirebon', 'Islam', 'Pusat Pemetaan Dasar', '081234567908', '12.345.678.9-019.000', NULL, '2026-04-23 04:14:39', '2026-04-23 04:39:34', NULL, 1, 7, 9, 4);
INSERT INTO public.employees VALUES (21, '19730305200012020', 'Taufik Hidayat', 'Malang', '1973-03-05', 'L', 'Jl. Basuki Rahmat No. 110, Malang', 'IV/e', 'I', 'Kepala Sekretariat Utama', 'Malang', 'Islam', 'Sekretariat Utama', '081234567909', '12.345.678.9-020.000', NULL, '2026-04-23 04:14:39', '2026-04-23 04:39:34', NULL, 1, 1, 17, 1);
INSERT INTO public.employees VALUES (22, '0384394834343', 'dsfjfsdfjsd', 'sdfdsfdf', '2026-04-04', 'L', 'sdjflksadlfakdsjflkj', 'I/b', 'I', 'sjljssdf', 'sdfdsf', 'Islam', 'Pusat Data Geospasial', '087646564', '23.223.232.3-232.323', NULL, '2026-04-23 04:49:41', '2026-04-23 04:55:18', '2026-04-23 04:55:18', NULL, NULL, NULL, NULL);
INSERT INTO public.employees VALUES (23, '38473747384', 'sdjfljsdfjsdlkj', 'skdjflksdjfkds', '2026-03-21', 'L', 'kldsjflskdjfsjdlfsd', 'I/b', 'II', 'nfns.dfsdf', 'dfdsfds', 'Islam', 'Pusat Pemetaan Dasar', '08384734773', '34.729.473.9-287.498', NULL, '2026-04-23 04:57:42', '2026-04-23 04:58:22', '2026-04-23 04:58:22', NULL, NULL, NULL, NULL);


--
-- TOC entry 3844 (class 0 OID 71278)
-- Dependencies: 237
-- Data for Name: eselons; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.eselons VALUES (1, 'I', 'Pejabat Pimpinan Tinggi Madya', '2026-04-23 04:39:22', '2026-04-23 04:39:22');
INSERT INTO public.eselons VALUES (2, 'II', 'Pejabat Pimpinan Tinggi Pratama', '2026-04-23 04:39:22', '2026-04-23 04:39:22');
INSERT INTO public.eselons VALUES (3, 'III', 'Pejabat Administrator', '2026-04-23 04:39:22', '2026-04-23 04:39:22');
INSERT INTO public.eselons VALUES (4, 'IV', 'Pejabat Pengawas', '2026-04-23 04:39:22', '2026-04-23 04:39:22');


--
-- TOC entry 3834 (class 0 OID 71209)
-- Dependencies: 227
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3846 (class 0 OID 71287)
-- Dependencies: 239
-- Data for Name: golongans; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.golongans VALUES (1, 'I/a', '1a', 'Golongan I/a', '2026-04-23 04:39:21', '2026-04-23 04:39:21');
INSERT INTO public.golongans VALUES (2, 'I/b', '1b', 'Golongan I/b', '2026-04-23 04:39:21', '2026-04-23 04:39:21');
INSERT INTO public.golongans VALUES (3, 'I/c', '1c', 'Golongan I/c', '2026-04-23 04:39:21', '2026-04-23 04:39:21');
INSERT INTO public.golongans VALUES (4, 'I/d', '1d', 'Golongan I/d', '2026-04-23 04:39:21', '2026-04-23 04:39:21');
INSERT INTO public.golongans VALUES (5, 'II/a', '2a', 'Golongan II/a', '2026-04-23 04:39:21', '2026-04-23 04:39:21');
INSERT INTO public.golongans VALUES (6, 'II/b', '2b', 'Golongan II/b', '2026-04-23 04:39:21', '2026-04-23 04:39:21');
INSERT INTO public.golongans VALUES (7, 'II/c', '2c', 'Golongan II/c', '2026-04-23 04:39:21', '2026-04-23 04:39:21');
INSERT INTO public.golongans VALUES (8, 'II/d', '2d', 'Golongan II/d', '2026-04-23 04:39:21', '2026-04-23 04:39:21');
INSERT INTO public.golongans VALUES (9, 'III/a', '3a', 'Golongan III/a', '2026-04-23 04:39:21', '2026-04-23 04:39:21');
INSERT INTO public.golongans VALUES (10, 'III/b', '3b', 'Golongan III/b', '2026-04-23 04:39:21', '2026-04-23 04:39:21');
INSERT INTO public.golongans VALUES (11, 'III/c', '3c', 'Golongan III/c', '2026-04-23 04:39:21', '2026-04-23 04:39:21');
INSERT INTO public.golongans VALUES (12, 'III/d', '3d', 'Golongan III/d', '2026-04-23 04:39:21', '2026-04-23 04:39:21');
INSERT INTO public.golongans VALUES (13, 'IV/a', '4a', 'Golongan IV/a', '2026-04-23 04:39:21', '2026-04-23 04:39:21');
INSERT INTO public.golongans VALUES (14, 'IV/b', '4b', 'Golongan IV/b', '2026-04-23 04:39:21', '2026-04-23 04:39:21');
INSERT INTO public.golongans VALUES (15, 'IV/c', '4c', 'Golongan IV/c', '2026-04-23 04:39:21', '2026-04-23 04:39:21');
INSERT INTO public.golongans VALUES (16, 'IV/d', '4d', 'Golongan IV/d', '2026-04-23 04:39:21', '2026-04-23 04:39:21');
INSERT INTO public.golongans VALUES (17, 'IV/e', '4e', 'Golongan IV/e', '2026-04-23 04:39:21', '2026-04-23 04:39:21');


--
-- TOC entry 3832 (class 0 OID 71201)
-- Dependencies: 225
-- Data for Name: job_batches; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3831 (class 0 OID 71192)
-- Dependencies: 224
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3825 (class 0 OID 71156)
-- Dependencies: 218
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.migrations VALUES (1, '0001_01_01_000000_create_users_table', 1);
INSERT INTO public.migrations VALUES (2, '0001_01_01_000001_create_cache_table', 1);
INSERT INTO public.migrations VALUES (3, '0001_01_01_000002_create_jobs_table', 1);
INSERT INTO public.migrations VALUES (4, '2026_04_22_110404_create_employees_table', 1);
INSERT INTO public.migrations VALUES (5, '2026_04_22_111642_create_personal_access_tokens_table', 1);
INSERT INTO public.migrations VALUES (6, '2026_04_23_043040_create_agamas_table', 2);
INSERT INTO public.migrations VALUES (7, '2026_04_23_043042_create_unit_kerjas_table', 2);
INSERT INTO public.migrations VALUES (8, '2026_04_23_043043_create_eselons_table', 2);
INSERT INTO public.migrations VALUES (9, '2026_04_23_043043_create_golongans_table', 2);
INSERT INTO public.migrations VALUES (10, '2026_04_23_043143_modify_employees_table_add_foreign_keys', 2);


--
-- TOC entry 3838 (class 0 OID 71233)
-- Dependencies: 231
-- Data for Name: personal_access_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.personal_access_tokens VALUES (16, 'App\Models\User', 1, 'auth_token', '003358871fcaead7f1668b7f656d0474bd54339ca33122ff58a239cd139b2e12', '["*"]', '2026-04-23 03:35:12', NULL, '2026-04-23 03:33:08', '2026-04-23 03:35:12');
INSERT INTO public.personal_access_tokens VALUES (22, 'App\Models\User', 1, 'auth_token', '7733a67011b0d9b8a2c8ae4d88609a90554c09c27a0b6a138a19d74b0867af2e', '["*"]', '2026-04-23 04:47:18', NULL, '2026-04-23 04:46:55', '2026-04-23 04:47:18');
INSERT INTO public.personal_access_tokens VALUES (23, 'App\Models\User', 1, 'auth_token', '34a4eee2ddf7d01daca7234545581b65d56e52cc20249d9d6b3da7990a45d211', '["*"]', '2026-04-23 05:53:05', NULL, '2026-04-23 05:00:59', '2026-04-23 05:53:05');
INSERT INTO public.personal_access_tokens VALUES (17, 'App\Models\User', 1, 'auth_token', 'ea55813178f94f30dd768b4b2c79a211eb93c6cf4f6226cf80effb10fae02662', '["*"]', '2026-04-23 03:55:30', NULL, '2026-04-23 03:35:22', '2026-04-23 03:55:30');
INSERT INTO public.personal_access_tokens VALUES (15, 'App\Models\User', 1, 'swagger-test', '96483ccff8037b963a938e8068d8b9e8aa80c8e0785c27f581cf43c042a071e4', '["*"]', '2026-04-23 03:28:17', NULL, '2026-04-23 03:27:47', '2026-04-23 03:28:17');


--
-- TOC entry 3842 (class 0 OID 71269)
-- Dependencies: 235
-- Data for Name: unit_kerjas; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.unit_kerjas VALUES (1, 'Sekretariat Utama', 'SET', '2026-04-23 04:39:21', '2026-04-23 04:39:21');
INSERT INTO public.unit_kerjas VALUES (2, 'Pusat Data Geospasial', 'PDG', '2026-04-23 04:39:21', '2026-04-23 04:39:21');
INSERT INTO public.unit_kerjas VALUES (3, 'Pusat Pengembangan Standar', 'PPS', '2026-04-23 04:39:21', '2026-04-23 04:39:21');
INSERT INTO public.unit_kerjas VALUES (4, 'Pusat Informasi Geospasial', 'PIG', '2026-04-23 04:39:21', '2026-04-23 04:39:21');
INSERT INTO public.unit_kerjas VALUES (5, 'Pusat Restorasi', 'PR', '2026-04-23 04:39:21', '2026-04-23 04:39:21');
INSERT INTO public.unit_kerjas VALUES (6, 'Pusat Survei Kependudukan', 'PSK', '2026-04-23 04:39:21', '2026-04-23 04:39:21');
INSERT INTO public.unit_kerjas VALUES (7, 'Pusat Pemetaan Dasar', 'PPD', '2026-04-23 04:39:21', '2026-04-23 04:39:21');


--
-- TOC entry 3827 (class 0 OID 71163)
-- Dependencies: 220
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES (1, 'Administrator', 'admin', '$2y$12$XEUDLO491ZDvwA70TeHmMeJLvURbxUatctHWw5VPgQN2xJJhWXotq', 'admin', 'Semua Unit', '2026-04-23 01:45:22', '2026-04-23 01:45:22');


--
-- TOC entry 3886 (class 0 OID 0)
-- Dependencies: 232
-- Name: agamas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.agamas_id_seq', 6, true);


--
-- TOC entry 3887 (class 0 OID 0)
-- Dependencies: 228
-- Name: employees_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employees_id_seq', 23, true);


--
-- TOC entry 3888 (class 0 OID 0)
-- Dependencies: 236
-- Name: eselons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.eselons_id_seq', 4, true);


--
-- TOC entry 3889 (class 0 OID 0)
-- Dependencies: 226
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- TOC entry 3890 (class 0 OID 0)
-- Dependencies: 238
-- Name: golongans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.golongans_id_seq', 17, true);


--
-- TOC entry 3891 (class 0 OID 0)
-- Dependencies: 223
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jobs_id_seq', 1, false);


--
-- TOC entry 3892 (class 0 OID 0)
-- Dependencies: 217
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 10, true);


--
-- TOC entry 3893 (class 0 OID 0)
-- Dependencies: 230
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personal_access_tokens_id_seq', 23, true);


--
-- TOC entry 3894 (class 0 OID 0)
-- Dependencies: 234
-- Name: unit_kerjas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.unit_kerjas_id_seq', 7, true);


--
-- TOC entry 3895 (class 0 OID 0)
-- Dependencies: 219
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- TOC entry 3660 (class 2606 OID 71267)
-- Name: agamas agamas_nama_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agamas
    ADD CONSTRAINT agamas_nama_unique UNIQUE (nama);


--
-- TOC entry 3662 (class 2606 OID 71265)
-- Name: agamas agamas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agamas
    ADD CONSTRAINT agamas_pkey PRIMARY KEY (id);


--
-- TOC entry 3639 (class 2606 OID 71189)
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- TOC entry 3636 (class 2606 OID 71181)
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- TOC entry 3650 (class 2606 OID 71231)
-- Name: employees employees_nip_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_nip_unique UNIQUE (nip);


--
-- TOC entry 3652 (class 2606 OID 71229)
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);


--
-- TOC entry 3668 (class 2606 OID 71285)
-- Name: eselons eselons_nama_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eselons
    ADD CONSTRAINT eselons_nama_unique UNIQUE (nama);


--
-- TOC entry 3670 (class 2606 OID 71283)
-- Name: eselons eselons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eselons
    ADD CONSTRAINT eselons_pkey PRIMARY KEY (id);


--
-- TOC entry 3646 (class 2606 OID 71217)
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- TOC entry 3648 (class 2606 OID 71219)
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- TOC entry 3672 (class 2606 OID 71294)
-- Name: golongans golongans_nama_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.golongans
    ADD CONSTRAINT golongans_nama_unique UNIQUE (nama);


--
-- TOC entry 3674 (class 2606 OID 71292)
-- Name: golongans golongans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.golongans
    ADD CONSTRAINT golongans_pkey PRIMARY KEY (id);


--
-- TOC entry 3644 (class 2606 OID 71207)
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- TOC entry 3641 (class 2606 OID 71199)
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- TOC entry 3629 (class 2606 OID 71161)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 3655 (class 2606 OID 71240)
-- Name: personal_access_tokens personal_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 3657 (class 2606 OID 71243)
-- Name: personal_access_tokens personal_access_tokens_token_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_token_unique UNIQUE (token);


--
-- TOC entry 3664 (class 2606 OID 71276)
-- Name: unit_kerjas unit_kerjas_nama_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unit_kerjas
    ADD CONSTRAINT unit_kerjas_nama_unique UNIQUE (nama);


--
-- TOC entry 3666 (class 2606 OID 71274)
-- Name: unit_kerjas unit_kerjas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unit_kerjas
    ADD CONSTRAINT unit_kerjas_pkey PRIMARY KEY (id);


--
-- TOC entry 3631 (class 2606 OID 71172)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3633 (class 2606 OID 71174)
-- Name: users users_username_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_unique UNIQUE (username);


--
-- TOC entry 3634 (class 1259 OID 71182)
-- Name: cache_expiration_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cache_expiration_index ON public.cache USING btree (expiration);


--
-- TOC entry 3637 (class 1259 OID 71190)
-- Name: cache_locks_expiration_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cache_locks_expiration_index ON public.cache_locks USING btree (expiration);


--
-- TOC entry 3642 (class 1259 OID 71200)
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- TOC entry 3653 (class 1259 OID 71244)
-- Name: personal_access_tokens_expires_at_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX personal_access_tokens_expires_at_index ON public.personal_access_tokens USING btree (expires_at);


--
-- TOC entry 3658 (class 1259 OID 71241)
-- Name: personal_access_tokens_tokenable_type_tokenable_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX personal_access_tokens_tokenable_type_tokenable_id_index ON public.personal_access_tokens USING btree (tokenable_type, tokenable_id);


--
-- TOC entry 3675 (class 2606 OID 71295)
-- Name: employees employees_agama_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_agama_id_foreign FOREIGN KEY (agama_id) REFERENCES public.agamas(id) ON DELETE SET NULL;


--
-- TOC entry 3676 (class 2606 OID 71310)
-- Name: employees employees_eselon_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_eselon_id_foreign FOREIGN KEY (eselon_id) REFERENCES public.eselons(id) ON DELETE SET NULL;


--
-- TOC entry 3677 (class 2606 OID 71305)
-- Name: employees employees_golongan_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_golongan_id_foreign FOREIGN KEY (golongan_id) REFERENCES public.golongans(id) ON DELETE SET NULL;


--
-- TOC entry 3678 (class 2606 OID 71300)
-- Name: employees employees_unit_kerja_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_unit_kerja_id_foreign FOREIGN KEY (unit_kerja_id) REFERENCES public.unit_kerjas(id) ON DELETE SET NULL;


--
-- TOC entry 3853 (class 0 OID 0)
-- Dependencies: 233
-- Name: TABLE agamas; Type: ACL; Schema: public; Owner: postgres
--



--
-- TOC entry 3855 (class 0 OID 0)
-- Dependencies: 232
-- Name: SEQUENCE agamas_id_seq; Type: ACL; Schema: public; Owner: postgres
--



--
-- TOC entry 3856 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE cache; Type: ACL; Schema: public; Owner: postgres
--



--
-- TOC entry 3857 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE cache_locks; Type: ACL; Schema: public; Owner: postgres
--



--
-- TOC entry 3858 (class 0 OID 0)
-- Dependencies: 229
-- Name: TABLE employees; Type: ACL; Schema: public; Owner: postgres
--



--
-- TOC entry 3860 (class 0 OID 0)
-- Dependencies: 228
-- Name: SEQUENCE employees_id_seq; Type: ACL; Schema: public; Owner: postgres
--



--
-- TOC entry 3861 (class 0 OID 0)
-- Dependencies: 237
-- Name: TABLE eselons; Type: ACL; Schema: public; Owner: postgres
--



--
-- TOC entry 3863 (class 0 OID 0)
-- Dependencies: 236
-- Name: SEQUENCE eselons_id_seq; Type: ACL; Schema: public; Owner: postgres
--



--
-- TOC entry 3864 (class 0 OID 0)
-- Dependencies: 227
-- Name: TABLE failed_jobs; Type: ACL; Schema: public; Owner: postgres
--



--
-- TOC entry 3866 (class 0 OID 0)
-- Dependencies: 226
-- Name: SEQUENCE failed_jobs_id_seq; Type: ACL; Schema: public; Owner: postgres
--



--
-- TOC entry 3867 (class 0 OID 0)
-- Dependencies: 239
-- Name: TABLE golongans; Type: ACL; Schema: public; Owner: postgres
--



--
-- TOC entry 3869 (class 0 OID 0)
-- Dependencies: 238
-- Name: SEQUENCE golongans_id_seq; Type: ACL; Schema: public; Owner: postgres
--



--
-- TOC entry 3870 (class 0 OID 0)
-- Dependencies: 225
-- Name: TABLE job_batches; Type: ACL; Schema: public; Owner: postgres
--



--
-- TOC entry 3871 (class 0 OID 0)
-- Dependencies: 224
-- Name: TABLE jobs; Type: ACL; Schema: public; Owner: postgres
--



--
-- TOC entry 3873 (class 0 OID 0)
-- Dependencies: 223
-- Name: SEQUENCE jobs_id_seq; Type: ACL; Schema: public; Owner: postgres
--



--
-- TOC entry 3874 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE migrations; Type: ACL; Schema: public; Owner: postgres
--



--
-- TOC entry 3876 (class 0 OID 0)
-- Dependencies: 217
-- Name: SEQUENCE migrations_id_seq; Type: ACL; Schema: public; Owner: postgres
--



--
-- TOC entry 3877 (class 0 OID 0)
-- Dependencies: 231
-- Name: TABLE personal_access_tokens; Type: ACL; Schema: public; Owner: postgres
--



--
-- TOC entry 3879 (class 0 OID 0)
-- Dependencies: 230
-- Name: SEQUENCE personal_access_tokens_id_seq; Type: ACL; Schema: public; Owner: postgres
--



--
-- TOC entry 3880 (class 0 OID 0)
-- Dependencies: 235
-- Name: TABLE unit_kerjas; Type: ACL; Schema: public; Owner: postgres
--



--
-- TOC entry 3882 (class 0 OID 0)
-- Dependencies: 234
-- Name: SEQUENCE unit_kerjas_id_seq; Type: ACL; Schema: public; Owner: postgres
--



--
-- TOC entry 3883 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE users; Type: ACL; Schema: public; Owner: postgres
--



--
-- TOC entry 3885 (class 0 OID 0)
-- Dependencies: 219
-- Name: SEQUENCE users_id_seq; Type: ACL; Schema: public; Owner: postgres
--



-- Completed on 2026-04-23 13:44:15 WIB

--
-- PostgreSQL database dump complete
--

\unrestrict x6wxRrTzThGkGwqFgMgJUL6ISy5iHZ6rqXg2kMmQZkfiupaF7reATIEdaGzlyUy

