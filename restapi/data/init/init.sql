--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0 (Debian 16.0-1.pgdg120+1)
-- Dumped by pg_dump version 16.2

-- Started on 2024-06-08 13:24:30

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

--
-- TOC entry 5 (class 2615 OID 16724)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 868 (class 1247 OID 16738)
-- Name: privasi_t; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.privasi_t AS ENUM (
    'PRIVATE',
    'PUBLIC'
);


ALTER TYPE public.privasi_t OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 16725)
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16847)
-- Name: _quizTotag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."_quizTotag" (
    "A" integer NOT NULL,
    "B" integer NOT NULL
);


ALTER TABLE public."_quizTotag" OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16744)
-- Name: catatanbelajar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.catatanbelajar (
    id integer NOT NULL,
    id_akun integer NOT NULL,
    judul_catatan text NOT NULL,
    isi_catatan text NOT NULL,
    privasi public.privasi_t NOT NULL,
    gambar text
);


ALTER TABLE public.catatanbelajar OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16743)
-- Name: catatanbelajar_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.catatanbelajar_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.catatanbelajar_id_seq OWNER TO postgres;

--
-- TOC entry 3523 (class 0 OID 0)
-- Dependencies: 216
-- Name: catatanbelajar_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.catatanbelajar_id_seq OWNED BY public.catatanbelajar.id;


--
-- TOC entry 223 (class 1259 OID 16772)
-- Name: catatanbelajar_tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.catatanbelajar_tag (
    id integer NOT NULL,
    id_catatanbelajar integer NOT NULL,
    id_tag integer NOT NULL
);


ALTER TABLE public.catatanbelajar_tag OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16771)
-- Name: catatanbelajar_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.catatanbelajar_tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.catatanbelajar_tag_id_seq OWNER TO postgres;

--
-- TOC entry 3524 (class 0 OID 0)
-- Dependencies: 222
-- Name: catatanbelajar_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.catatanbelajar_tag_id_seq OWNED BY public.catatanbelajar_tag.id;


--
-- TOC entry 225 (class 1259 OID 16779)
-- Name: comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comment (
    id integer NOT NULL,
    thread_id integer,
    user_id text NOT NULL,
    author text NOT NULL,
    content text NOT NULL,
    anonymous boolean DEFAULT false NOT NULL,
    verified boolean DEFAULT false NOT NULL,
    upvote integer DEFAULT 0 NOT NULL,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.comment OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16778)
-- Name: comment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.comment_id_seq OWNER TO postgres;

--
-- TOC entry 3525 (class 0 OID 0)
-- Dependencies: 224
-- Name: comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comment_id_seq OWNED BY public.comment.id;


--
-- TOC entry 227 (class 1259 OID 16792)
-- Name: comment_reply; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comment_reply (
    id integer NOT NULL,
    comment_id integer,
    user_id text NOT NULL,
    author text NOT NULL,
    content text NOT NULL,
    anonymous boolean DEFAULT false NOT NULL,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.comment_reply OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16791)
-- Name: comment_reply_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comment_reply_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.comment_reply_id_seq OWNER TO postgres;

--
-- TOC entry 3526 (class 0 OID 0)
-- Dependencies: 226
-- Name: comment_reply_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comment_reply_id_seq OWNED BY public.comment_reply.id;


--
-- TOC entry 240 (class 1259 OID 16926)
-- Name: discord_channels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.discord_channels (
    id integer NOT NULL,
    user_id text NOT NULL,
    server_id character varying(20) NOT NULL,
    channel_id character varying(20) NOT NULL,
    channel_name character varying(100) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    channel_image_url text,
    course_id text NOT NULL
);


ALTER TABLE public.discord_channels OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16925)
-- Name: discord_channels_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.discord_channels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.discord_channels_id_seq OWNER TO postgres;

--
-- TOC entry 3527 (class 0 OID 0)
-- Dependencies: 239
-- Name: discord_channels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.discord_channels_id_seq OWNED BY public.discord_channels.id;


--
-- TOC entry 238 (class 1259 OID 16915)
-- Name: follow_teman; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.follow_teman (
    id_follow integer NOT NULL,
    id_akun1 integer NOT NULL,
    id_akun2 integer NOT NULL,
    is_follow boolean DEFAULT true NOT NULL
);


ALTER TABLE public.follow_teman OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16914)
-- Name: follow_teman_id_follow_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.follow_teman_id_follow_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.follow_teman_id_follow_seq OWNER TO postgres;

--
-- TOC entry 3528 (class 0 OID 0)
-- Dependencies: 237
-- Name: follow_teman_id_follow_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.follow_teman_id_follow_seq OWNED BY public.follow_teman.id_follow;


--
-- TOC entry 229 (class 1259 OID 16803)
-- Name: quiz; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quiz (
    id integer NOT NULL,
    title text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    image text,
    "jumlahSoal" integer NOT NULL,
    link text NOT NULL,
    "userId" integer NOT NULL
);


ALTER TABLE public.quiz OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16802)
-- Name: quiz_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quiz_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.quiz_id_seq OWNER TO postgres;

--
-- TOC entry 3529 (class 0 OID 0)
-- Dependencies: 228
-- Name: quiz_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quiz_id_seq OWNED BY public.quiz.id;


--
-- TOC entry 231 (class 1259 OID 16813)
-- Name: report; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.report (
    id integer NOT NULL,
    user_id text NOT NULL,
    thread_id integer,
    comment_id integer,
    comment_reply_id integer,
    report_type text NOT NULL,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    status_review boolean DEFAULT false NOT NULL,
    quiz_id integer
);


ALTER TABLE public.report OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16812)
-- Name: report_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.report_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.report_id_seq OWNER TO postgres;

--
-- TOC entry 3530 (class 0 OID 0)
-- Dependencies: 230
-- Name: report_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.report_id_seq OWNED BY public.report.id;


--
-- TOC entry 221 (class 1259 OID 16763)
-- Name: tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tag (
    id integer NOT NULL,
    nama_tag text
);


ALTER TABLE public.tag OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16762)
-- Name: tag_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tag_id_seq OWNER TO postgres;

--
-- TOC entry 3531 (class 0 OID 0)
-- Dependencies: 220
-- Name: tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tag_id_seq OWNED BY public.tag.id;


--
-- TOC entry 219 (class 1259 OID 16753)
-- Name: tes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tes (
    id bigint NOT NULL,
    test_text text DEFAULT ''::text NOT NULL,
    test_number bigint NOT NULL
);


ALTER TABLE public.tes OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16752)
-- Name: tes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tes_id_seq OWNER TO postgres;

--
-- TOC entry 3532 (class 0 OID 0)
-- Dependencies: 218
-- Name: tes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tes_id_seq OWNED BY public.tes.id;


--
-- TOC entry 233 (class 1259 OID 16824)
-- Name: thread; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.thread (
    id integer NOT NULL,
    user_id text NOT NULL,
    author text NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    anonymous boolean DEFAULT false NOT NULL,
    comment_count integer DEFAULT 0 NOT NULL,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.thread OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16823)
-- Name: thread_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.thread_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.thread_id_seq OWNER TO postgres;

--
-- TOC entry 3533 (class 0 OID 0)
-- Dependencies: 232
-- Name: thread_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.thread_id_seq OWNED BY public.thread.id;


--
-- TOC entry 234 (class 1259 OID 16835)
-- Name: thread_tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.thread_tag (
    thread_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE public.thread_tag OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16840)
-- Name: user_upvote_comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_upvote_comment (
    user_id text NOT NULL,
    comment_id integer NOT NULL
);


ALTER TABLE public.user_upvote_comment OWNER TO postgres;

--
-- TOC entry 3274 (class 2604 OID 16747)
-- Name: catatanbelajar id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catatanbelajar ALTER COLUMN id SET DEFAULT nextval('public.catatanbelajar_id_seq'::regclass);


--
-- TOC entry 3278 (class 2604 OID 16775)
-- Name: catatanbelajar_tag id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catatanbelajar_tag ALTER COLUMN id SET DEFAULT nextval('public.catatanbelajar_tag_id_seq'::regclass);


--
-- TOC entry 3279 (class 2604 OID 16782)
-- Name: comment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment ALTER COLUMN id SET DEFAULT nextval('public.comment_id_seq'::regclass);


--
-- TOC entry 3284 (class 2604 OID 16795)
-- Name: comment_reply id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment_reply ALTER COLUMN id SET DEFAULT nextval('public.comment_reply_id_seq'::regclass);


--
-- TOC entry 3298 (class 2604 OID 16929)
-- Name: discord_channels id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discord_channels ALTER COLUMN id SET DEFAULT nextval('public.discord_channels_id_seq'::regclass);


--
-- TOC entry 3296 (class 2604 OID 16918)
-- Name: follow_teman id_follow; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.follow_teman ALTER COLUMN id_follow SET DEFAULT nextval('public.follow_teman_id_follow_seq'::regclass);


--
-- TOC entry 3287 (class 2604 OID 16806)
-- Name: quiz id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz ALTER COLUMN id SET DEFAULT nextval('public.quiz_id_seq'::regclass);


--
-- TOC entry 3289 (class 2604 OID 16816)
-- Name: report id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.report ALTER COLUMN id SET DEFAULT nextval('public.report_id_seq'::regclass);


--
-- TOC entry 3277 (class 2604 OID 16766)
-- Name: tag id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag ALTER COLUMN id SET DEFAULT nextval('public.tag_id_seq'::regclass);


--
-- TOC entry 3275 (class 2604 OID 16756)
-- Name: tes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tes ALTER COLUMN id SET DEFAULT nextval('public.tes_id_seq'::regclass);


--
-- TOC entry 3292 (class 2604 OID 16827)
-- Name: thread id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.thread ALTER COLUMN id SET DEFAULT nextval('public.thread_id_seq'::regclass);


--
-- TOC entry 3491 (class 0 OID 16725)
-- Dependencies: 215
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
53f1bb5f-b257-450d-8f40-bfec3daeb6f3	d61a105f3931353d7f90b59cdbafbe336fb455b4695406c3dbad099a86b231b5	2024-04-21 17:44:20.874052+00	20240421174420_	\N	\N	2024-04-21 17:44:20.679002+00	1
\.


--
-- TOC entry 3512 (class 0 OID 16847)
-- Dependencies: 236
-- Data for Name: _quizTotag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."_quizTotag" ("A", "B") FROM stdin;
2	7
2	8
3	7
3	8
7	8
7	7
8	7
8	8
9	8
9	7
10	8
10	7
11	7
15	21
16	25
16	26
15	25
17	7
17	8
19	26
20	8
21	8
23	8
24	21
24	25
26	64
27	73
28	21
28	7
29	21
38	21
39	21
39	25
40	7
41	7
\.


--
-- TOC entry 3493 (class 0 OID 16744)
-- Dependencies: 217
-- Data for Name: catatanbelajar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.catatanbelajar (id, id_akun, judul_catatan, isi_catatan, privasi, gambar) FROM stdin;
139	2	pepaya	<h1><strong class="ql-font-serif" style="color: rgb(255, 153, 0);">Pepaya </strong></h1><p><span style="color: rgb(255, 153, 0);" class="ql-font-serif">atau betik adalah tumbuhan yang diperkirakan berasal dari Meksiko bagian selatan dan bagian utara dari Amerika Selatan. Pepaya kini telah menyebar luas dan banyak ditanam di seluruh daerah tropis untuk diambil buahnya. C. </span><u class="ql-font-serif" style="color: rgb(255, 153, 0);">papaya </u><span class="ql-font-serif" style="color: rgb(255, 153, 0);">adalah satu-satunya jenis dalam genus </span><em class="ql-font-serif" style="color: rgb(255, 153, 0);">Carica</em><span class="ql-font-serif" style="color: rgb(255, 153, 0);">.</span></p>	PUBLIC	https://d1vbn70lmn1nqe.cloudfront.net/prod/wp-content/uploads/2022/07/20043718/Ketahui-X-Manfaat-Biji-Pepaya-bagi-Kesehatan-Tubuh-01.jpg.webp
137	2	SMOKE TESTING	<p><strong><em>smoke testing</em>&nbsp;adalah metode pengujian&nbsp;<em>software</em>&nbsp;yang biasanya dilakukan pada awal proses pengembangan untuk memastikan fungsi paling penting dari&nbsp;<em>software</em>&nbsp;bisa bekerja dengan stabil.&nbsp;</strong></p><p><em>Smoke testing</em>&nbsp;dilakukan oleh tim&nbsp;<em>Quality Assurance</em>&nbsp;(QA) untuk menguji fungsi dasar dan fitur utama dari&nbsp;<em>software</em>.&nbsp;<em>Smoke testing&nbsp;</em>bisa dilakukan dengan tiga cara yaitu:</p><ul><li><strong><em>Manual smoke testing:&nbsp;</em></strong>Pengujian dilakukan secara manual oleh tim QA, termasuk mengembangkan skrip&nbsp;<em>test case</em>&nbsp;dan memperbaruinya secara manual berdasarkan fitur&nbsp;<em>software</em>.&nbsp;</li><li><strong><em>Automated smoke testing:&nbsp;</em></strong>Pengujian dilakukan menggunakan alat sehingga proses pengujian berjalan secara otomatis.&nbsp;</li><li><strong><em>Hybrid smoke testing:&nbsp;</em></strong>Kombinasi dari manual dan&nbsp;<em>automated smoke testing</em>, di mana tim menulis&nbsp;<em>test case</em>&nbsp;dan pengujian dilakukan secara otomatis menggunakan alat.</li></ul><p>Jika&nbsp;<em>smoke testing</em>&nbsp;lulus, tim QA bisa melanjutkan ke tahap pengujian selanjutnya yaitu&nbsp;<em>functional testing</em>.</p>	PUBLIC	https://png.pngtree.com/png-vector/20230726/ourmid/pngtree-coloring-pages-free-kids-printable-teddy-bear-drawing-in-pencil-cartoon-png-image_6746133.png
\.


--
-- TOC entry 3499 (class 0 OID 16772)
-- Dependencies: 223
-- Data for Name: catatanbelajar_tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.catatanbelajar_tag (id, id_catatanbelajar, id_tag) FROM stdin;
127	137	10
128	139	12
\.


--
-- TOC entry 3501 (class 0 OID 16779)
-- Dependencies: 225
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comment (id, thread_id, user_id, author, content, anonymous, verified, upvote, created_at) FROM stdin;
21	30	admin	admin	<p>gatau</p>	f	t	1	2024-05-20 03:15:04.319
23	30	admin	admin	<p>ini anonim</p>	t	f	2	2024-05-20 03:16:01.906
22	30	rachmat	Rachmat Purwa Saputra	<p>kakkdkoj</p>	t	t	0	2024-05-20 03:15:45.207
24	31	gian	Gian Sandrova	Artikel ini sangat informatif! Saya setuju bahwa BDD dapat meningkatkan kualitas pengujian, terutama dalam pengujian API. Apakah ada contoh konkret dari implementasi BDD di dunia nyata yang bisa dibagikan?	f	f	0	2024-06-03 10:45:52.525
17	24	aininurulazizah	Aini Nurul Azizah	<p>In a microservice architecture, GraphQL can be used either by having a single GraphQL schema as an API Gateway or by using multiple GraphQL schemas for each microservice. The single schema approach centralizes API management and provides a consistent user experience, but can become a bottleneck and complicate scalability. The multiple schemas approach decentralizes management, allowing each microservice to handle its own schema and improving scalability, but increases complexity in managing multiple schemas and may require clients to handle data merging. Choosing the right approach depends on project needs, scale, and desired architecture. Cmiw.</p>	f	f	1	2024-05-18 08:28:29.147
14	22	admin	admin	<p>after step 2,</p><p>edit the repo.sh file on line 93 like this:</p><pre class="ql-syntax" spellcheck="false">cd $name\n git checkout open-release/${OPENEDX_RELEASE}\n cd ..\n</pre><p><span style="color: rgb(12, 13, 14);">You need to add 1 &amp; 3 line. And then follow further steps.</span></p>	f	f	1	2024-04-29 03:13:03.306
13	21	admin	admin	<p>Just deploy it</p>	f	f	2	2024-04-29 03:10:42.646
18	27	ReihanHF	Reihan Hadi Fauzan	<p>Sepertinya itu masalah lorem ipsum. Apakah sudah mencoba dolor sit amet?</p>	f	f	0	2024-05-19 03:18:42.285
20	27	proyek3b	Proyek 3B	<p>Mungkin terdapat kesalahan pada file pom.xml nya</p>	f	f	0	2024-05-19 05:38:50.596
\.


--
-- TOC entry 3503 (class 0 OID 16792)
-- Dependencies: 227
-- Data for Name: comment_reply; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comment_reply (id, comment_id, user_id, author, content, anonymous, created_at) FROM stdin;
12	13	admin	admin	<p>no, i need detailed explanation</p>	f	2024-04-29 03:10:58.967
15	18	proyek3b	Proyek 3B	<p>Betul, hal ini mungkin bisa terjadi. Bisa juga dicek pada bagian dependency nya</p>	f	2024-05-19 05:48:05.69
16	23	admin	admin	<p>abc</p>	f	2024-05-20 03:17:29.578
17	24	regi	Regi Purnama	Terima kasih, Gian! Salah satu contoh implementasi BDD di dunia nyata adalah di perusahaan X yang menggunakan framework Cucumber untuk pengujian API mereka. Dengan pendekatan ini, mereka mampu mendeteksi bug lebih awal dalam siklus pengembangan dan meningkatkan kolaborasi antara tim pengembang dan tim QA.	f	2024-06-03 10:52:34.792
\.


--
-- TOC entry 3516 (class 0 OID 16926)
-- Dependencies: 240
-- Data for Name: discord_channels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.discord_channels (id, user_id, server_id, channel_id, channel_name, created_at, updated_at, channel_image_url, course_id) FROM stdin;
5	23	1224973397726072863	1233330329754800168	Testing	2024-04-26 14:56:51.777+00	2024-04-26 14:56:51.777+00	/asset-v1:UniversityX+CS01+2024_TI+type@asset+block@tantangan2.png	course-v1:UniversityX+CS01+2024_TI
6	23	1224973397726072863	1233330617027133480	Study with Egi	2024-04-26 14:58:07.811+00	2024-04-26 14:58:07.811+00	/asset-v1:Polban+CS12+2024_SWE+type@asset+block@images_course_image.jpg	course-v1:Polban+CS12+2024_SWE
\.


--
-- TOC entry 3514 (class 0 OID 16915)
-- Dependencies: 238
-- Data for Name: follow_teman; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.follow_teman (id_follow, id_akun1, id_akun2, is_follow) FROM stdin;
26	11	3	t
23	11	4	t
27	11	5	t
25	11	6	t
28	11	7	t
29	11	8	t
30	11	9	t
31	11	10	t
32	11	12	t
33	11	13	t
34	11	14	t
35	11	15	t
36	11	16	t
24	11	17	t
\.


--
-- TOC entry 3505 (class 0 OID 16803)
-- Dependencies: 229
-- Data for Name: quiz; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quiz (id, title, "createdAt", image, "jumlahSoal", link, "userId") FROM stdin;
2	Quizz cuy nih2	2024-04-21 18:26:41.554	https://res.cloudinary.com/dbfzfuszc/image/upload/v1713724000/wsuocreg95zd1zmlwmxe.png	15	www.youtube.com	1
3	Quizz cuy nih3	2024-04-21 18:26:45.346	https://res.cloudinary.com/dbfzfuszc/image/upload/v1713724004/oe0pcbljowbgjgixpspt.png	15	www.youtube.com	1
19	tessss	2024-04-27 10:34:28.233	https://res.cloudinary.com/dbfzfuszc/image/upload/v1714214067/ecdpx8cbtpnuxsmmpnhi.png	10	www.google.com	1
20	tess	2024-04-27 10:42:46.919	https://res.cloudinary.com/dbfzfuszc/image/upload/v1714214566/upsjec7duuxnniaw6gwf.png	100	www.google.com	1
21	jsahda	2024-04-27 10:44:14.366	https://res.cloudinary.com/dbfzfuszc/image/upload/v1714214653/b79hlny8owld3tceujzp.png	10	www.google.com	1
8	QUIZ APPL2	2024-04-23 12:36:26.042	https://res.cloudinary.com/dbfzfuszc/image/upload/v1713875825/ffmuju60u8jqthdz98bf.png	19	WWW.YOUTUBE.COM	1
9	QUIZ APPL3	2024-04-23 13:12:45.236	https://res.cloudinary.com/dbfzfuszc/image/upload/v1713878073/xklicdxkmdhghdyp5y5c.png	10	WWW.YOUTUBE.COM	1
24	Quiz MoLe	2024-04-28 05:20:10.951	https://res.cloudinary.com/dbfzfuszc/image/upload/v1714281610/h1an9gqvnwzydpfwmxxq.png	10	https://quizizz.com/admin/quiz/661a4a699ca2c9a62856602b?source=quiz_share	3
11	Testt	2024-04-23 13:38:31.8	https://res.cloudinary.com/dbfzfuszc/image/upload/v1713879511/onbluhddkssannqgq8o4.png	1	google.com	1
10	Quiz editsss	2024-04-23 13:16:21.754	https://res.cloudinary.com/dbfzfuszc/image/upload/v1713880992/vnfuwpdkwamxchvgodvg.jpg	15	www.youtube.com	1
7	Quiz Mobile Legend2	2024-04-21 18:41:42.992	https://res.cloudinary.com/dbfzfuszc/image/upload/v1714192347/opoyqq0cznjroek9bbca.jpg	12	youtube.com	3
14	Tes tag baru	2024-04-27 04:37:07.013	https://res.cloudinary.com/dbfzfuszc/image/upload/v1714192626/oursgugwdh9zeinja7jk.png	2	google.com	1
38	Quiz Cuy	2024-05-12 17:07:08.617	https://res.cloudinary.com/dbfzfuszc/image/upload/v1715533628/lsogp71ac5f0ax3ftjdb.png	2	https://quizizz.com/admin/quiz/661a4a699ca2c9a62856602b?source=quiz_share	4
39	Mobile Legend	2024-05-12 17:07:42.774	https://res.cloudinary.com/dbfzfuszc/image/upload/v1715533662/oaknowipsj8av9cxlsen.png	50	https://quizizz.com/admin/quiz/661a4a699ca2c9a62856602b?source=quiz_share	4
26	QUIZ STATISTIKA	2024-04-29 00:36:58.518	https://res.cloudinary.com/dbfzfuszc/image/upload/v1714351017/l0jws4neok31ine5hjpz.png	10	https://quizizz.com/admin/quiz/661a4a699ca2c9a62856602b?source=quiz_share	3
27	QUIZ  NAMA ORANG	2024-04-29 01:31:06.838	https://res.cloudinary.com/dbfzfuszc/image/upload/v1714354266/kua27dglrnfbx6zfchur.jpg	20	https://quizizz.com/admin/quiz/abcdefghijk?source=quiz_share	3
23	Quizizzz	2024-04-28 05:19:13.644	https://res.cloudinary.com/dbfzfuszc/image/upload/v1714355722/rz0si4dsqy5cm7764i8l.jpg	4	youtube.com	2
28	Tst Quizzz	2024-04-29 02:19:40.508	https://res.cloudinary.com/dbfzfuszc/image/upload/v1714357180/m76tnxosb5mymduyrons.png	5	https://quizizz.com/admin/quiz/661a4a699ca2c9a62856602b?source=quiz_share	42
29	Quizs	2024-05-12 15:35:21.381	https://res.cloudinary.com/dbfzfuszc/image/upload/v1715528120/k1efl008pdkjfjes3ca5.png	2	https://quizizz.com/admin/quiz/661a4a699ca2c9a62856602b?source=quiz_share	2
15	Quizz MoLe	2024-04-27 04:42:52.3	https://res.cloudinary.com/dbfzfuszc/image/upload/v1714209180/rny8pghyirlkueo4hkpw.jpg	15	www.youtube.com	2
16	Quiz Point Blank	2024-04-27 09:11:13.818	https://res.cloudinary.com/dbfzfuszc/image/upload/v1714209390/txi3xzvfnmjxwmcs3zte.png	5	zepetto.com	3
40	Quez	2024-05-12 17:44:29.21	https://res.cloudinary.com/dbfzfuszc/image/upload/v1715535868/fhz003drkajf5x8myex2.png	2	https://quizizz.com/admin/quiz/661a4a699ca2c9a62856602b?source=quiz_share	5
17	Quiz Edit	2024-04-27 10:14:42.191	https://res.cloudinary.com/dbfzfuszc/image/upload/v1714213749/k6jiv9m757wjclgztpw1.png	15	www.youtube.com	2
41	Pengujian Perangkat Lunak	2024-05-19 01:51:17.809	https://res.cloudinary.com/dbfzfuszc/image/upload/v1716118188/naylh7hoygyxnayoyxgc.png	1	https://quizizz.com/join?gc=831663&source=liveDashboard	11
43	QUIZ PEMROGRAMAN	2024-06-03 10:53:03.182	\N	10	https://quizizz.com/?lng=en	1
44	QUIZ PEMROGRAMAN DASAR	2024-06-03 11:14:42.553	\N	20	https://quizizz.com/?lng=en	1
\.


--
-- TOC entry 3507 (class 0 OID 16813)
-- Dependencies: 231
-- Data for Name: report; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.report (id, user_id, thread_id, comment_id, comment_reply_id, report_type, created_at, status_review, quiz_id) FROM stdin;
6	2	\N	\N	\N	Penghinaan & Pelecehan secara Online	2024-04-27 08:36:42.008	f	15
7	2	\N	\N	\N	Plagiat	2024-04-27 08:37:03.253	f	9
8	2	\N	\N	\N	Privasi	2024-04-27 14:57:19.173	f	21
10	2	\N	\N	\N	Penghinaan & Pelecehan secara Online	2024-04-28 17:30:05.48	f	24
11	2	\N	\N	\N	Penghinaan & Pelecehan secara Online	2024-04-28 17:30:23.921	f	23
13	2	\N	\N	\N	Plagiat	2024-04-29 00:32:58.563	f	16
21	2	\N	\N	\N	Penghinaan & Pelecehan secara Online	2024-04-29 01:31:55.822	f	27
22	2	\N	\N	\N	Plagiat	2024-04-29 02:22:42.177	f	26
24	admin	22	\N	\N	spam	2024-04-29 04:13:42.691	f	\N
25	2	\N	\N	\N	Privasi	2024-04-29 04:40:55.247	f	28
27	sendist	24	\N	\N	kebencian	2024-05-18 08:29:57.707	f	\N
28	rachmat	\N	22	\N	bunuh-diri	2024-05-20 03:19:08.815	f	\N
29	2	\N	\N	\N	Plagiat	2024-06-03 12:26:36.566	f	40
\.


--
-- TOC entry 3497 (class 0 OID 16763)
-- Dependencies: 221
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tag (id, nama_tag) FROM stdin;
7	testing
8	dasar pemrograman
9	appl
10	ppl
11	Testing
12	biologi
13	Proyek
14	Agama
15	Umbi
16	QOT
17	mobile legend
18	game
19	mole
20	moba
21	MoLe
22	Mobile Legend
23	sastra
24	KDRAMA
25	Game
26	Point Blank
27	bahasa indonesia
28	lagu
29	pendidikan kewarganegaraan
30	kimia
31	fisika
32	matematika
33	seni musik
34	seni tari
35	sastra jepang
36	pkn
37	pbo
38	so
39	si
40	ddp
41	sda
42	pcd
43	kg
44	p
45	r
46	o
47	y
48	e
49	k
50	O
51	l
52	m
53	K
54	E
55	Y
56	DRAKOR
57	qot
58	Matematika
59	Fisika
60	pengolahan citra
61	tteknologi
62	citra digital
63	Tanya
64	statistika
65	arab
66	Lingkungan
67	Iklim
68	Limbah
69	Pendidikan
70	Belajar
71	Siswa
72	Teknologi
73	sosial
74	openedx
75	devstack
76	iOS
77	Xclode
78	architecture
79	react
80	quilljs
81	MySQL
82	Dasar-Dasar Pemrograman
83	Selenium
84	miscellaneous
85	dasardasarpemrograman
86	programming
87	
88	sql
89	pa
90	manajemen PROYEK
91	pplbo
92	a
93	n
94	arsitektur aplikasi
95	arsitektur
96	BDD
97	API
98	pengujian perangkat lunak
\.


--
-- TOC entry 3495 (class 0 OID 16753)
-- Dependencies: 219
-- Data for Name: tes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tes (id, test_text, test_number) FROM stdin;
\.


--
-- TOC entry 3509 (class 0 OID 16824)
-- Dependencies: 233
-- Data for Name: thread; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.thread (id, user_id, author, title, content, anonymous, comment_count, created_at) FROM stdin;
21	admin	admin	Openedx deployed locally	<p><span style="color: rgb(12, 13, 14);">After installing and deploying OpenEdx through tutor, I ran Openedx deployed locally and accessed the customized LMS and CMS domain names, and found the following situation. May I ask if my installation and deployment is correct? If so, may I ask what I should do next? If not, what went wrong? f Thank you very much for your answer</span></p>	f	1	2024-04-29 03:09:58.116
22	admin	admin	Openedx devstack installation	<p>I'm trying to install the openedx hawthorn release on my Mac. I followed the instructions, but when I ran&nbsp;<span style="color: var(--black-600); background-color: var(--black-200);">make dev.clone</span>, it gave me the error below:</p><p>fatal: not a git repository (or any of the parent directories): .git</p><p>make: *** [Makefile:41: dev.clone] Error 128</p>	f	1	2024-04-29 03:12:12.68
29	Dea	Dea Salma	Report pada pengujian tidak tergenerate	<p>saya sudah melakukan pengujian menggunakan cucumber namun tidak ada report yang tergenerate</p>	t	0	2024-05-19 05:17:31.612
24	sendist	sendi	When and How to use GraphQL with microservice architecture	<p>'m trying to understand where GraphQL is most suitable to use within a microservice architecture.</p><p>There is some debate about having only 1 GraphQL schema that works as API Gateway proxying the request to the targeted microservices and coercing their response. Microservices still would use REST / Thrift protocol for communication though.</p><p>Another approach is instead to have multiple GraphQL schemas one per microservice. Having a smaller API Gateway server that route the request to the targeted microservice with all the information of the request + the GraphQL query.</p><p><br></p><p><img src="https://i.stack.imgur.com/BrnFy.png"></p><p><br></p>	f	1	2024-04-29 04:09:09.647
28	proyek3b	Proyek 3B	How to use GraphSQL	<p>i'm trying to understand where GraphQL is most suitable to use within a microservice architecture.</p><p>There is some debate about having only 1 GraphQL schema that works as API Gateway proxying the request to the targeted microservices and coercing their response. Microservices still would use REST / Thrift protocol for communication though.</p><p>Another approach is instead to have multiple GraphQL schemas one per microservice. Having a smaller API Gateway server that route the request to the targeted microservice with all the information of the request + the GraphQL query.</p>	f	0	2024-05-19 05:15:47.528
27	aininurulazizah	Aini Nurul Azizah	Browser Driver Tidak Terbaca (Selenium)	<p>Saya membuat kode selenium untuk interaksi website otomatis dalam rangka melakukan pengujian web secara otomatis. Namun browser driver yang ditentukan tidak dapat terbaca padahal path to driver nya sudah sesuai. Ada yang pernah mengalami ini?</p><p><img src="data:image/png;base64,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"></p>	f	3	2024-05-18 08:23:00.651
30	rachmat	Rachmat Purwa Saputra	Apa itu PPLBO?	<p>fdsoa[fjwdjaj fefwjijiwda</p>	f	3	2024-05-20 03:14:48.668
31	regi	Regi Purnama	Meningkatkan Kualitas Pengujian Perangkat Lunak dengan BDD	<p>Behavior Driven Development (BDD) adalah pendekatan dalam pengembangan perangkat lunak yang membantu meningkatkan kualitas pengujian. Artikel ini akan menjelaskan bagaimana menulis test case dalam format BDD untuk operasi data pengguna dalam pengujian API.</p>	f	1	2024-06-03 10:35:02.374
\.


--
-- TOC entry 3510 (class 0 OID 16835)
-- Dependencies: 234
-- Data for Name: thread_tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.thread_tag (thread_id, tag_id) FROM stdin;
21	74
22	75
22	74
24	78
27	83
28	88
29	87
30	91
31	98
31	97
31	96
31	7
\.


--
-- TOC entry 3511 (class 0 OID 16840)
-- Dependencies: 235
-- Data for Name: user_upvote_comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_upvote_comment (user_id, comment_id) FROM stdin;
admin	13
aininurulazizah	17
aininurulazizah	14
ReihanHF	13
admin	23
admin	21
rachmat	23
\.


--
-- TOC entry 3534 (class 0 OID 0)
-- Dependencies: 216
-- Name: catatanbelajar_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.catatanbelajar_id_seq', 139, true);


--
-- TOC entry 3535 (class 0 OID 0)
-- Dependencies: 222
-- Name: catatanbelajar_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.catatanbelajar_tag_id_seq', 132, true);


--
-- TOC entry 3536 (class 0 OID 0)
-- Dependencies: 224
-- Name: comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comment_id_seq', 24, true);


--
-- TOC entry 3537 (class 0 OID 0)
-- Dependencies: 226
-- Name: comment_reply_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comment_reply_id_seq', 17, true);


--
-- TOC entry 3538 (class 0 OID 0)
-- Dependencies: 239
-- Name: discord_channels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.discord_channels_id_seq', 6, true);


--
-- TOC entry 3539 (class 0 OID 0)
-- Dependencies: 237
-- Name: follow_teman_id_follow_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.follow_teman_id_follow_seq', 36, true);


--
-- TOC entry 3540 (class 0 OID 0)
-- Dependencies: 228
-- Name: quiz_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quiz_id_seq', 44, true);


--
-- TOC entry 3541 (class 0 OID 0)
-- Dependencies: 230
-- Name: report_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.report_id_seq', 29, true);


--
-- TOC entry 3542 (class 0 OID 0)
-- Dependencies: 220
-- Name: tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tag_id_seq', 98, true);


--
-- TOC entry 3543 (class 0 OID 0)
-- Dependencies: 218
-- Name: tes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tes_id_seq', 1, false);


--
-- TOC entry 3544 (class 0 OID 0)
-- Dependencies: 232
-- Name: thread_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.thread_id_seq', 31, true);


--
-- TOC entry 3302 (class 2606 OID 16733)
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 3304 (class 2606 OID 16751)
-- Name: catatanbelajar catatanbelajar_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catatanbelajar
    ADD CONSTRAINT catatanbelajar_pk PRIMARY KEY (id);


--
-- TOC entry 3311 (class 2606 OID 16777)
-- Name: catatanbelajar_tag catatanbelajar_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catatanbelajar_tag
    ADD CONSTRAINT catatanbelajar_tag_pkey PRIMARY KEY (id);


--
-- TOC entry 3314 (class 2606 OID 16790)
-- Name: comment comment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id);


--
-- TOC entry 3316 (class 2606 OID 16801)
-- Name: comment_reply comment_reply_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment_reply
    ADD CONSTRAINT comment_reply_pkey PRIMARY KEY (id);


--
-- TOC entry 3334 (class 2606 OID 16936)
-- Name: discord_channels discord_channels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discord_channels
    ADD CONSTRAINT discord_channels_pkey PRIMARY KEY (id);


--
-- TOC entry 3330 (class 2606 OID 16921)
-- Name: follow_teman follow_teman_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.follow_teman
    ADD CONSTRAINT follow_teman_pkey PRIMARY KEY (id_follow);


--
-- TOC entry 3318 (class 2606 OID 16811)
-- Name: quiz quiz_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz
    ADD CONSTRAINT quiz_pkey PRIMARY KEY (id);


--
-- TOC entry 3320 (class 2606 OID 16822)
-- Name: report report_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.report
    ADD CONSTRAINT report_pkey PRIMARY KEY (id);


--
-- TOC entry 3309 (class 2606 OID 16770)
-- Name: tag tag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);


--
-- TOC entry 3306 (class 2606 OID 16761)
-- Name: tes test_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tes
    ADD CONSTRAINT test_pkey PRIMARY KEY (id);


--
-- TOC entry 3322 (class 2606 OID 16834)
-- Name: thread thread_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.thread
    ADD CONSTRAINT thread_pkey PRIMARY KEY (id);


--
-- TOC entry 3324 (class 2606 OID 16839)
-- Name: thread_tag thread_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.thread_tag
    ADD CONSTRAINT thread_tag_pkey PRIMARY KEY (thread_id, tag_id);


--
-- TOC entry 3332 (class 2606 OID 16923)
-- Name: follow_teman unique_id_akun1_id_akun2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.follow_teman
    ADD CONSTRAINT unique_id_akun1_id_akun2 UNIQUE (id_akun1, id_akun2);


--
-- TOC entry 3326 (class 2606 OID 16846)
-- Name: user_upvote_comment user_upvote_comment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_upvote_comment
    ADD CONSTRAINT user_upvote_comment_pkey PRIMARY KEY (user_id, comment_id);


--
-- TOC entry 3327 (class 1259 OID 16852)
-- Name: _quizTotag_AB_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "_quizTotag_AB_unique" ON public."_quizTotag" USING btree ("A", "B");


--
-- TOC entry 3328 (class 1259 OID 16853)
-- Name: _quizTotag_B_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "_quizTotag_B_index" ON public."_quizTotag" USING btree ("B");


--
-- TOC entry 3307 (class 1259 OID 16850)
-- Name: tag_nama_tag_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tag_nama_tag_key ON public.tag USING btree (nama_tag);


--
-- TOC entry 3312 (class 1259 OID 16851)
-- Name: unique_tag_per_catatan; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX unique_tag_per_catatan ON public.catatanbelajar_tag USING btree (id_catatanbelajar, id_tag);


--
-- TOC entry 3346 (class 2606 OID 16904)
-- Name: _quizTotag _quizTotag_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_quizTotag"
    ADD CONSTRAINT "_quizTotag_A_fkey" FOREIGN KEY ("A") REFERENCES public.quiz(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3347 (class 2606 OID 16909)
-- Name: _quizTotag _quizTotag_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_quizTotag"
    ADD CONSTRAINT "_quizTotag_B_fkey" FOREIGN KEY ("B") REFERENCES public.tag(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3335 (class 2606 OID 16854)
-- Name: catatanbelajar_tag catatanbelajar_tag_id_catatanbelajar_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catatanbelajar_tag
    ADD CONSTRAINT catatanbelajar_tag_id_catatanbelajar_fkey FOREIGN KEY (id_catatanbelajar) REFERENCES public.catatanbelajar(id);


--
-- TOC entry 3336 (class 2606 OID 16859)
-- Name: catatanbelajar_tag catatanbelajar_tag_id_tag_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catatanbelajar_tag
    ADD CONSTRAINT catatanbelajar_tag_id_tag_fkey FOREIGN KEY (id_tag) REFERENCES public.tag(id);


--
-- TOC entry 3338 (class 2606 OID 16869)
-- Name: comment_reply comment_reply_comment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment_reply
    ADD CONSTRAINT comment_reply_comment_id_fkey FOREIGN KEY (comment_id) REFERENCES public.comment(id) ON DELETE CASCADE;


--
-- TOC entry 3337 (class 2606 OID 16864)
-- Name: comment comment_thread_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_thread_id_fkey FOREIGN KEY (thread_id) REFERENCES public.thread(id) ON DELETE CASCADE;


--
-- TOC entry 3339 (class 2606 OID 16874)
-- Name: report report_comment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.report
    ADD CONSTRAINT report_comment_id_fkey FOREIGN KEY (comment_id) REFERENCES public.comment(id) ON DELETE CASCADE;


--
-- TOC entry 3340 (class 2606 OID 16879)
-- Name: report report_comment_reply_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.report
    ADD CONSTRAINT report_comment_reply_id_fkey FOREIGN KEY (comment_reply_id) REFERENCES public.comment_reply(id) ON DELETE CASCADE;


--
-- TOC entry 3341 (class 2606 OID 16948)
-- Name: report report_quiz_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.report
    ADD CONSTRAINT report_quiz_id_fkey FOREIGN KEY (quiz_id) REFERENCES public.quiz(id) ON DELETE CASCADE;


--
-- TOC entry 3342 (class 2606 OID 16884)
-- Name: report report_thread_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.report
    ADD CONSTRAINT report_thread_id_fkey FOREIGN KEY (thread_id) REFERENCES public.thread(id) ON DELETE CASCADE;


--
-- TOC entry 3343 (class 2606 OID 16889)
-- Name: thread_tag thread_tag_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.thread_tag
    ADD CONSTRAINT thread_tag_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tag(id) ON DELETE CASCADE;


--
-- TOC entry 3344 (class 2606 OID 16894)
-- Name: thread_tag thread_tag_thread_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.thread_tag
    ADD CONSTRAINT thread_tag_thread_id_fkey FOREIGN KEY (thread_id) REFERENCES public.thread(id) ON DELETE CASCADE;


--
-- TOC entry 3345 (class 2606 OID 16899)
-- Name: user_upvote_comment user_upvote_comment_comment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_upvote_comment
    ADD CONSTRAINT user_upvote_comment_comment_id_fkey FOREIGN KEY (comment_id) REFERENCES public.comment(id) ON DELETE CASCADE;


--
-- TOC entry 3522 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


-- Completed on 2024-06-08 13:24:34

--
-- PostgreSQL database dump complete
--

