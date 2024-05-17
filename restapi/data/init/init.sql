--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0 (Debian 16.0-1.pgdg120+1)
-- Dumped by pg_dump version 16.2

-- Started on 2024-05-06 11:28:31

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
\.


--
-- TOC entry 3493 (class 0 OID 16744)
-- Dependencies: 217
-- Data for Name: catatanbelajar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.catatanbelajar (id, id_akun, judul_catatan, isi_catatan, privasi, gambar) FROM stdin;
12	2	bukber	<p><img src="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRofHh0aHBwgJC4nICIsIxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/2wBDAQkJCQwLDBgNDRgyIRwhMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjL/wgARCAUAAk8DASIAAhEBAxEB/8QAGgABAAMBAQEAAAAAAAAAAAAAAAECAwUEBv/EABgBAQEBAQEAAAAAAAAAAAAAAAABAgME/9oADAMBAAIQAxAAAALj+cAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHs8YAAHoPO93oOS3xIdXE8Doc8AAAAAAAAAAAAAAAAAAAAAAANYM1tDFrkHYnOOM62Wt85pmAAAJgdzy4ekvHm8x3MfFJ7eJ7/AAAAAAAAAAAAAAAAAAAAAAAez3eYdf571eEr3uB6z08u1T6Tfjzjj2ceNG+1PLegAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABr7ettHEdscR2xxHbHEdscR2xxHbHEdscR2xxHbHEdscR2xxHbHEdscR2xxHbHEdscR2xxHbHEdscR2xxHbHEdscR2xxHbHEdscR2xxHbHEdscR2xxHbHEdscR2xxHbHEdscR2xw/B9X5T12qNGY0eaT0MxozGjMaMxozGjMaMxozGjMaRQaVqLKiyosqLKiyosqLKiyosqLKiZqLKiyosqLKiyosqLKiyosqLKiyomAlIz4vs8ZTH0UNux817TtpExroedrJhO0FK6DO1hjaJJWGcXqQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkIvYyTsYJBI+fy93mKUiqxr5van0CQWsZykqsKrwVWgrNxRaxSt6kJuZrwVaQUWkovUhrQqsKrSUWFUiEiEiEiEiEiEiEiJCyotSRCRGldS3nvJkkSDDifRZnC8neHB+i11ALXyEzUaziLqDWtBozGlsRegNchozFrZi85jSkDStRozF5zCYAAAAAAAAAAAAFqgtUASkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEgkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEiEgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkQkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACsWVsBQBEZWRBYaAEIkUAAAAAAAAAAAAAAAIJIJAIiRQgkAgkACJiCYJiayylZUYqJtVLRJMGoSISIkoAAAAAAAAAAAAAAAABBEikTESKRMRJFTExEigEQxZiVVWZRMtSJKComJgKAAAAAAAAGBuzGjK5YAAAAAAAACJiJrYQmCRSJiJFImIkUAiaxJIiYJFBAVExMBQAAAAAAADy+rzl0itg0AAAAAAAAAiYJAiYiUTSJiJFKxnw3urbtgKrMxEikETWwAComJiJKAAAAAAAAY7YmrMXrGhIAAAAAAAAETBIEMuWtkT1yiYiRVUxy1MxPTIUgiRSJiJFBAVExMBQAAAAAAAHmvItWRS0XLgAAAAAAAARMRIqsS5aWrbcRMWSRVcvQ47rY64CkTETWwRMEigiJKiYmAoAAAAAAAAAAAAAAAAAAABExEiqV1z4bm6OuZiYskUAAAiYJAiYiUTUSAETk471Me3PZz0dBzx0Hh9lWCgAAAAADxp7HA9cnUcKsd94OfXfc3pWgoAAACCJFAAIUxdETuAAAImCQIiMW43AgKomOO78/oc/rz4htjli+kwuuF6PPMz9TPJ8uun0Dw+zVs+ftmd5yfNXfc/mn0T53sHqebjn0PP5msni6HP6Gc+Kl6J3fF6vBd9Doczx299x5rrvm947qng1ek+ezzn6LieaZPd1/NrOmqJ6AAKpjFmYnUCgAETESKyXefdh6MBBEmM6OO55/Q5/bnxL0tz5ezOa2+f38/1Hp5nS5p2Ohz+hvfy96Xxz9Xi9viXe/T1uvnfZ5NZmcV09Pn+m52t8Xoc/oZz4qXonW5PW5K9Hn9Dnj1+T6i35vLrcmTpc3p+Et2eBYvklPotfJe9vTMToFAVrpTnqbG8hQACJiJFZjzdNCPTzlEwFAOf0OfM8TfBz5/UV+Za3MTOcb+bqcu3r+/5u1ud4mZ9Xi9viXvaZ6b387tj6MYwtv5j6nm8yttOhz+hJ4qXonW5PW5K9Hn9Dnj6n5b6nWuXyetyc56Hmt5jf283Q6Hr4l7exfPadMLRtqa2z21a10Ga9SAAAAImIkUABE1ZtlePc9pxSdrzc6Ys9nrOQ66uT7vQWvL6w4nu9pObn1hz/P2BhbVbyNOmky5nYLxeh6qHL9HvJya9gePx+LLOe358/AdPrczqa14/J1y8bne7w45+3Wm915vF7/BM+r6DidvW8s/ZTV8dOdY+iCokZr0AAAEVYtxuAAZzLnqPmPp/mLyi1fpZn5yv1XzduX0PzvUOvTg+W36a/y0n1Ucje3oT8r7pO1X5qp9W4mC93T5XVPpnn5rXXpztOXaIxry69x5eP6vJ3tPldGZytXOOhz+hz16/R+fwt+m0+V6dvQ5fs48bvJMz7t/L1m9b8PCvp58vq3qtdOQnr9nF7MSLVbDNMAAFYlz1YdMgCTNTzcd+zh9fOzl6e/y3Pk8983Kevb3a1x9sfJJ3vnprI6vJ61cnfDpRtyPqfn7rzdX0bac2ejFvkeny8O8xM+fvjWLWX5fQ5/byev2X6HbHysa5Yx0Of0PBb6fbHR1r5i81znp5e3nXXTw8W+dV22vjXN8nQ8mufV6fk9XXU0ut4l/Xys4+ic/oa2ApeCgAM1456sOmQPP4Ohy8b3nHDh31tgX0xjsnl83W5Pbxez1cn3WeHo860n03zUxbTq8tJHS5vSOvlNOvStsnn1Git1Snryryxthw61i2c36vB6vLvj6uj870O/n8ft6C3PXxa2+l5d7dIzpnUeH37SUz9PLubX8uHJr5/R0Nz0p8d31L+D37jn9Acb1786Z6t/B77oCKaVKgAAAjjdrmY6ebG2XD0bPPNnrzpMvRvn7vR5PNrtnrOGW+cbXwvWF9CUvsXCq3LaukY3FK26XTK9S1bVzcPN78+O/N0PF0vRxw3r5unLwLZ4Rfyq0182s3v6fHbl39Vd/Nm6xWM256uvHm+jKrfpeWvPXs6HE21nuMdvTwjldarPE9vivnPac3oa3YFI0oQAAB5vTWXiRbPzevCvopuZb4bnv93h07eXTFvnWMY35demivo89sqvP2w2xy1LVvnjl7ppd1ynXLVi/nNbKTm+TWzn022ifZ5Odh7OexlNukce30EL8/XteSTmdHz+7l6K6rcutMPTjZHQ8Pv68uTaccdbRj6Cl2krt8L275dRE9+Hk4/0GUzxOp5fXJ7hraqoAAAByPD1uZx9EZ0iatfO+p04menH0+T3+fnrPTTxZ1vfwZ559W3P9je0RHPc+Po+P2ebTO9+G9KK535rUtOvopOW+c38PvreId+GNNrlk1llSS8SOdXpc3j2upbl1jP0SW1h6PPzoRx9HnrpnvO2nntLr7/H0dc/R6MNO3C4KXQTRAAAAABhxfoPnMdMaxWdNdPNrZ1bWTFLaePn0v5Pb5LmUUxy98+e831J8Ps9XO/i3w1OR6/ZdaX2ZuEejOa0jw+XWb4a7WefbXSHq8noNKWrmxKwlNT4Pdkcn0s+Hf0Why6LYuvPxWpm3vmoV2z3r0dHy+3r59JNYtbOxNYAAAAAADjdnwS8Gt889ZtWTseryRM9Pz1py344p5umJmk7zbNS59+7qNY56eCq4dvzM8z25dZY0ikWymJdYi1lYvTWcY9FY0Y7NRYiTKrYeTmWdfm17p877unxpepnfzZ1l5kc+4tTfD2XPR9WO/TzyAAAAAAAABWw5Pk7tJrk+7SI9Hg9G2p4PPtTn15lff498clLamnS8vYzraOfnz6e/yVwm+t5PN6Jl0ud7+mYteNYpXUsTFkjz+nz2WmFkeX11ly0vkX5vs5Jk9duPs8P0XA26+bvZ3tccCfX4JrGsxnraaWL9fmdu899K21gAAAAAAAAACuewwbSUtIryOya+f26Hlm8I1saV9HlxMPN7sOPoyjbTWMPVhWat0Od7rn22xv3894gWUmpyvS5iJgES7Wy5y+3yb3ueRpavH2Of7sLn3+jj9Hr5aeTtznXzcenDPWL1ue/q+X265XksAAAAAAAAAAAAAAARMGXj9vmlw2x08fq8s101rPbPTWfL6NK3HqvzcO3DtODFd5wMk+jcPpHqFis1aZzVPQzsZ83rRXG9ftiIlYpvA0yVlerz2G+etkgAAAAAAAAAAAAAAARMFM9czw628/n7eL3VzzrfO8r4/P0uP140rDpiUKvWqNPV4tTr+zne9ZmsmM6aWZTuMG8mFtpMr6SVmwzrsMLaiJAAAAAAAAAAAAAAAAACuetTHPahhHoZ1nl6OYV8XRrc8yYuYx6cik66mHtv6zWYhbTGlk6xoJSQkQkAAAAAAAAAAAAAAAAAAAAAAIkUprB542oUrapXL0Dmb+tHJ06Suf6toKykibXK6WsLJAAAAAAAAAAAAAAAAAAAAAAAAAAESKxeDOu0GFfRB528GDcYzrJlbSSl5kiZAAAAAAAAAAAAAAAADLXym0+HE6sc/wBROnmHptzYOnPP2NbeXE6Tl6nvr4KnTt4vaAAVnxYnUr4aHRebE6FfJidJ4dzeZESAEPJ5jp25ux658mB0Lcy50HN9xoBW0FJ8eJ0p8Gh6b831Gl+aOjPO2Lb+PI6ceGp0J546QAAESIkIR5D2Uw0NY81T2z5dS1pCJAAAFa6ZkKyaQxNEQWm8gAAFYvmJzkmL4msRUvpIAARIAMKHqjx+k0r4rHteP2ESCJAAAAAEeb1eUa40PVhf0Hm01AAAAADHYePP1+c2rhsee/vGWoAAAMdh4qdOTzYdAcuOqMptUAAAAyy9djw+nYeOvuHP9l6AAAAAAAEeT2eA4XQ9dTj/AE3P6BqiQAAAAADHh9rynj8HX2I6Pi9oAAAA0z2Hj9nirD0830m3r+b+nGWtIoQTEgITFq0iYrwaeL1lteP6DrxIxTEAAARJABEgVEgRMBREwFAETAURMIkBREwAFIlADTNW3n0kzrsM7yL5KkiAApMDaM7ng09Y8mm4tEUIEARMTQAiJFEISUiYJRMBUEwFIkETAUhMBSCJRIFITAUiYiUTQgmCJFRKITE0IJEBUSiJFCBJAVEoiRUTCExJAMa7UKzYKa1JpaSJroZTnrUL1hFqUstGVpkYeitVi8xnFxVeKtS6M11Vi6LZ3qQvFVjWpWLWKLIpa0mc2oTMSZtJMtFjNatQuii8la3Fr53JRJCYJiYpKIkVnS8RTWJrLSLGWkWjNdVa6RGTWazjapbO0xWV6pWyML7VqI0iIraTONq1bO8RS8zWNpRNbisXmsmsRRe1YWmYU1rUU2qZzdFNaqrNoiNomolEJiREqiYQkpBAkIBMCYEwAkQBMCYEwkgkQAEoAExMEwkgEoABMEwkgEoACUEokgEwACUCYkgEwCYCYCYABIgEwCYABMAEwkiYABMAAkgABMCYAkQAkhMCYAEwAkhMCYBMEwgkkgCYBMAAkRIgkCoTEJBWwgkCoTEJBW0CQCoi0RIpW0QkESqIlEioTEJBEhASKgQkESIJAqskJKRKIJAqspgKCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACBKBKBKBKBKBKBKBKBKBKBKBKBKBKBKBKBKBKBKBKBKBKBKBKBKBKBKBKBKBKBKBKBKBKBKBKAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAcjrgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACHCOKNAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFr0LTkNWQ1ZDVkNWQ1ZDVkNWQ1ZDVkNWQ1ZDVkNWQ1ZDVkNWQ1ZDVkNWQ1ZDVkNWQ0rWxVrkAAAAAAAAAANctDMBpueR6fOQ2yITATASIJISIAAAAAAAAAAAAAAAA0z0MwDrnjw9PtOd5ujU8AHow+jOG9nTPnsfpPmwAC9YuUB6Ovw7nq1wwPV7OTc6XE9PmOtpn4jq+TPE9Xs5mhevkGAAAAAAAAAAAAAAAAGmehmB2OPcrHc55l69uOAJgfReS2ZzswAAaZyQ1yAAAAAAAAAAAAAAAAAAAAAAABJGk5AAE+/ngAADbEAAAAGmY0ZjRmNGY0ZjRmNGY0ZjRmNGY0ZjRmNGY0ZjRmNGY0ZjRmNGY0ZjRmNGY0ZjRmNIoAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABYq6o5TqjlOqOU6o5TqjlOqOU6o5TqjlOqOU6o5TqjlOqOU6sHLAAAAAAAAAAAAejzgAAAAAAAAADbEfRT84Po3zg+jfOD6N84Po3zg+jfOD6N84Po3zg+jfOD6N84Po3zg+jfOD6OPnRaoAAAAAAAAAAD2H/9oADAMBAAIAAwAAACEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQwAAAAAAAAAAAAAAAAAAAAAAAAAAAAwoAAAAADAAQgAAAAAAAAAAAAAAAAAAAAABCjCghyAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADY4444444444444444444444444444444444557777777777756444444444464444444444447KJGrLJaJI7YLrLLLLLLLLLLLLLLLLLLLLJ77LAL6rBab7bqpJ7bbLbbL7rLDDDDDTDDJLLCKbIzwmYywwzxwwzyzyzyxyzzwwwwwwwwwwwwwwwzDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDjDDDDDDDDDjDDDjDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDAwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwzDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAUsAA8cAAsAAAAAAAAAAAAAAAAQQAYAQAQABaUAHPtkUEGAIIIIIIIIIIIIIIIIJ4AEJYAEII5j+OMCkIIIIIIIIIYIoIIIIIIIIJZLUJYAMIJVtUIIIsIIIIIIIIJI7YIIIIIIIIJQIEhYI4oLUJ9MIKkAIIIIIIIIYJIIIIIIIIIJQIIgYKIEJ8JUIICkIIIIIIIIL4qYIIIIIIIIJYIkpYBCMJYNUIKAkIIIIIIIIIIIIIIIIIIIIJYKaZYIIIJQJUiAAQU44kIIIIIIIUQYEEIIIIJ8IIJIgIIJQJUIIBZ73OmIE4Ag0FStU6IkIwOoeAIKcMIIJYDMAIoVa/8rfn3xqAHStX/APE03DJ1DCCWiCCCWC+EKCCXv+3eP18V8IbrV3/o/n3rLbCSCCCCCWCCCmKAWCBCyhhRRTiADREvZi7aKGpbDTmCCCaCCAsC74MNcRDMCoPBmZsdXXD6MOiqtKDDqCCeACA5iFNpUTZ8uHH1CXDTfTZ8CoBEvTRIDHKC0CCPciApI80k7lq3j9aI2GPwq5J6uyhQQoDWCCCCiSHOxsSQlu00IV8toR6SZJnvSsPCAxgMDiCCCCsQBxd/d1vcqgfdIgsxEbkMdThZglDJxDSCCCCRfBolWlmK89+0r5ic69SeuaxN/lpuDnSCCCCCn18W5yfxub5WklRLwLLWf3U1iGcEiuqCCCCCCHHHXLEUtgwTtVcdpXkKE8AcBIo0MCCCCCCCCCCgf4gGJJzQG41Qp+BWyPXO5bSBvKCCCCCCCCCCyYSABdSZ4tQFaARVVghWLND6GWiCCCCCCCCCCCCCCCWx5EUd/oRqbUDaQW6cx68CCCCCCCCCCCCCCCCWYrhlaWU2Q+mymYkQygyCCCCCCCCCCCCCCCCCC8cZeREoIJkoQqCyCCCCCCCCCCCCCCCCAAACAAQoAeUbgpMc0wACACCACACCCCCCAAAAAAAAAAAAQkAwgwMsswAAAAAAAAAAAAAAAAU0QwY0OAiAAAkYMU8ggAMkIiMAEciY8cMSMCAAQg4o8oAQAAAws4UwAAAgs48QAAQAEcMAgQAgAAAAoAgAAAAAQ4UQgAAAE+eegAAAA8wCkAAAAAAAkC6IAAAAAA4WoAAAAS4wA6EQCAMw88AAAAiCKAgKAKAAKAKSAKCASCAuO+sCCAA6+eyCCoAGAOgUKA6AQKAaAeKAaAWIEeAmoECAmAEiAmAuq/u6SyrsOomO06Sc+Qe+cU8mmKuqzAuWSOK2UjAXMgjMO0Qacf0mSQP8Wmw20+kMuMSgiqQvgf7L2rX6XjnT6X/G1WS/H92S/L/iC5a+iqZfvqPVC5OP1n1Lvlm3r/lnlrJjTnNZzTnFPLZvX5bDpAVCT7AFiViAVAVCQ9A1iSNAdiCpA9gCZApADDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999T99999999999999999999999999999999999/QwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQgAAAAAAAAAAAAAAAAAAAAAAkAAAAAAAAAAAIAMMEAIIMAAAAAAAAAAAAAAAAAwAQEAAEMAAAcAMQYQ8QcgAAAAAAAAAAAAAAAAAAAkgAQYgAAQEAAAAAAAAAAAAAAAAAAAAAAAAUAAgAAAwAAAAAQwwwwwwwwwwwwwwwwwwwwwwQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEEMMMMMMMMMMMMIAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAgAAAAAAAAAAA/9oADAMBAAIAAwAAABCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQgggAAAAAAAAAAAAAAAAAAAAAAAAAgA8AgAABARiggAAAAAAAAAAAAAAAAAAAAADzyRCbggAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABJLLLLLLJKLLJKLLLJJLKLJKLKKLLJKLLKJJKIwwIwwwwwwwwxxzzzzzzzzzzxzzzzzzzzzzzwwCH9YCKZYp5QCAAAAAAAAAAAAAAAAAAAAAAxgj7nzb6CQBwyjzDzzjTDTjjT77777r76yzz6Qjwz9Lwx57577444475555764wwwwwwwwwwwz56wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADzzzzzzzzzzzzzzzzzzzTzzzzzzzzzTzzzTzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDjDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDTzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzD7LTH7v/wC+w0+++++++++++++++98+7+8+9++r2Opb4hdue/8APPPPPPPPPPPPPPPPKevvK/fvPE/Xz4l0vPPPPPPPPONOPPPPPPPPPP76vK7vPPO5AvA/MPPPPPPPPPOPAPPPPPPPPPOfPvq/M/8AyXwjwPwN3zzzzzzzyjyDzzzzzzzzznzvXvyNbwrgLwPZLzzzzzzzzygCzzzzzzzzzzvyryv177ytwbwN2LzzzzzzzzzzzzzzzzzzzzzvxPSvzzzy3wL6Ho7/AO+08888888/5608888880888r+88898B8D/AJNOfOX/ADL3HbaGz1pDrLHGWhXzyxzzzy/6N4OeDyrM1Qen6bAHnz1fx9dssX7TzyRfzzyvwv0vzz2+7LW2n2qxinz1/wAXXsAVhA8z48888z888o296POevP8A3zjfHXfs6B7EMgc6Sa8kPPPK9PPoau3O5jMgZKjf/COTNfN4ameG6cSw0nPPEvvOj354uM32aznOLw7Shd8D6+fhFz4rrgxtPLnPIEXPhfPjMq2SyM28akj3snXrBCJ7KrZg4/PPPCG7Gby+rxsemRwlmJtbHjLDp+6oe4NVTgsfPPOUlJExv0ijnTOZHrfLXBIAhsYa+lBXrKwj/PPLMUsRPYButvQ6+HLyNoBliiBJ/CZUFQ9nfPPPPLXO0zrVicXMNaPOQb17rRCosfU66VIRfPPPPPOx1v34OU7qAJT7RhQ2IxOHIMonAe/PPPPPPPPKGWj/ADeOigXHyXhO8jwQHEHYYnmvzzzzzzzzzzzgrx0ONsZm0rXdofzeuQucb4WcvTzzzzzzzzzzzzzzyggnui4Qxeyd1ypSNTfIqbzzzzzzzzzzzzzzzzyO7a1MtTcFSuRy46ZTrTzzzzzzzzzzzzzzzzzz7JlETFJdUd/7zxxzzzzzzzzzzzzzzzz777z764JpWsZlwV5Yr7z7zz7z7zzzzzz777777zz777z775qb6parZ77z77z77777z77777b6Kp4D4Tb7666ZbbS7wZppzj65LAQaa7xbzyxyzbZ6pxx3zS64oKTz3yjr6CTzxwwBAY6xzh7n7WI477X6jT6Xq/brH72DDDB3bjT7NIA77D6FXAnNCzklGUCA3IhPUXAUzwRj73QOawhCzAVBGMMsHEsksEEsktMEstFOMX5r5cNMEEoJLCMOmEf4/G0vrleFvpnd9upnZd2/3aH+UP6HeXOqXZ+fguMu8wEd081Ul/HtUUM12km/uteh0ftMktX2Q+QnEJt2El+AQ4eeGRde9nfp/wBRTGxFvPdovkUEhUIV404Ir0sfuXRkKC/fEUovLW/Ztj2yMtM6xm1sAcqEuSFUkkiQGIW4kM+CIEIWUweIE6I6a8+34o92XuF90VW19s9GXvO9ef769M97at498c88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++0+++++++++++++++++++++++++++++++++++sAwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIEIMAAAAAAAAAAAAAAAAAAAEAEkEAkMIAAMAoEUIUsAMAAAAAAAAAAAAAAAAEgQAIAAMgAAQIAAAAAAAAAAAAAAAAAAAAAAAAYAAQAAAgAAAAAgAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAA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"></p><p><br></p><p>ini menu buat bukber gais</p>	PRIVATE	
92	2	sitiga bikin lg	<p>lloem inpkasdasm</p>	PUBLIC	
101	2	test_tambah	<p><span style="color: rgb(0, 0, 0);">isi catatan abcdef ghi 123</span></p>	PRIVATE	
103	2	mfe nih	<p>jiakh</p>	PUBLIC	
105	2	test_cover	<p><span style="color: rgb(0, 0, 0);">isi catatan abcdef ghi 123'</span></p>	PRIVATE	https://miro.medium.com/v2/resize:fit:1054/1*i8hFU86TqfhC0W28083U2w.png
107	2	test_heading	<h1><span style="color: rgb(0, 0, 0);">isi catatan abcdef ghi 123</span></h1>	PRIVATE	
109	2	test_italic	<p><em style="color: rgb(0, 0, 0);">isi catatan abcdef ghi 123</em></p>	PRIVATE	
6	2	White Box testing	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed accumsan justo et massa viverra, id sagittis nulla vehicula. Vestibulum id justo eu erat lobortis suscipit. Donec sed felis ut dui ullamcorper facilisis. Proin lacinia turpis nec libero dignissim, in hendrerit elit luctus. Vivamus vel turpis vel neque aliquet ultricies. Maecenas et sem vel libero porttitor volutpat. Vivamus laoreet lectus ac sapien tincidunt, at ultricies lorem eleifend. Vivamus et nisl sit amet tortor consequat interdum ac nec enim. Maecenas suscipit eros sit amet dui tincidunt aliquet. Ut sed justo eu purus sagittis bibendum. Maecenas quis mi ut risus volutpat feugiat.</p>	PRIVATE	data:image/jpeg;base64,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
96	2	asdada	<p>aaaa</p>	PUBLIC	
110	2	test_underline	<p><u style="color: rgb(0, 0, 0);">isi catatan abcdef ghi 123</u></p>	PRIVATE	
111	2	test_warna	<p><span style="color: rgb(230, 0, 0);">isi catatan abcdef ghi 123</span></p>	PRIVATE	
54	3	SITIGA NYOBA BIKIN CATATAN YANG JUDULNYA PANJANG	<p>aaaaa</p>	PRIVATE	
19	2	test 	<p>test lagi</p>	PRIVATE	
20	2	domba	<p>shaun the sheep, is shaun the sheep</p>	PUBLIC	
66	2	asa	<p>sas</p>	PRIVATE	
67	2	asa	<p>sas</p>	PRIVATE	
2	2	Catatan Proyek 3	<p>Proyek 3 kali ini menggunakan open edx sebagai teknologi yang akan digunakan serta diimplementasikan selama 1 semester kedepan</p>	PUBLIC	https://assets.kompasiana.com/statics/crawl/552c0d1d6ea8344c398b4567.jpeg?t=o&v=740&x=416
68	2	sas	<p>sas</p>	PRIVATE	
82	2	judul	<p>catatan</p>	PRIVATE	
3	2	APPL 2	<p><strong style="color: rgb(230, 0, 0);">design patern ada banyak</strong></p>	PRIVATE	https://miro.medium.com/v2/resize:fit:1054/1*i8hFU86TqfhC0W28083U2w.png
5	2	tengah	<p class="ql-align-center">waduh waduh waduh,</p><p class="ql-align-center">untung saya di tengah</p>	PRIVATE	
4	2	Proyek 3 Today	<p><strong style="color: rgb(2, 8, 23);">Proyek 3 </strong><span style="color: rgb(2, 8, 23);">kali ini menggunakan open edx sebagai teknologi yang akan digunakan serta diimplementasikan cuma susah banget ternyata ueueue</span></p>	PRIVATE	
56	2	hei	<p>test</p>	PRIVATE	
57	2	bismillah	<p>test huhuyy</p>	PRIVATE	
58	2	API testing	<h2>User Controller</h2><p><span style="color: rgb(107, 114, 128);">List of routes to get&nbsp;</span><strong style="color: rgb(107, 114, 128);">User</strong><span style="color: rgb(107, 114, 128);">&nbsp;data.</span></p><h3>Get List</h3><p>Get list of users sorted by registration date.</p><p>- Pagination query params available.</p><p>- Created query params available.</p><p>GET</p><p>/user</p><p><strong>Response:</strong>&nbsp;List(User Preview)</p><h3>Get User by id</h3><p>Get user full data by user id</p><p>GET</p><p>/user/:id</p><p><strong>Response:</strong>&nbsp;User</p><h3>Create User</h3><p>Create new user, return created user data.</p><p><strong>Body:&nbsp;</strong>User Create (firstName, lastName, email are required)</p><p>POST</p><p>/user/create</p><p><strong>Response:</strong>&nbsp;User</p><h3>Update User</h3><p>Update user by id, return updated User data</p><p><strong>Body:&nbsp;</strong>User data, only fields that should be updated. (email is forbidden to update)</p><p>PUT</p><p>/user/:id</p>	PUBLIC	
53	2	upnormal	<p class="ql-align-right">it's not just about ideas,</p><p class="ql-align-right">it's about making ideas happen do it!</p>	PRIVATE	
69	2	sas	<p>sas</p>	PRIVATE	
17	2	test	<p>test button yyy</p>	PRIVATE	
64	2	PUISI	<p class="ql-align-center">JIKA</p><p class="ql-align-center">MAKA</p><p>MENGAPA</p><p>TIDAK</p><p class="ql-align-right">KARENA</p><p class="ql-align-right">KENAPA</p><p class="ql-align-center">?!</p>	PUBLIC	
70	2	sas	<p>sas</p>	PRIVATE	
71	2	sas	<p>sas</p>	PRIVATE	
72	2	sas	<p>sas</p>	PRIVATE	
73	2	sas	<p>sas</p>	PRIVATE	
74	2	oalahh	<p>ppppp</p>	PRIVATE	
75	2	sekarang ada dialognya looo	<p>hehehehe</p>	PRIVATE	
76	2	cek dialognya muncul gakk	<p>coba cek</p>	PRIVATE	
77	2	aaaa	<p>aaaaa</p>	PRIVATE	
78	2	aaa	<p>aaa</p>	PRIVATE	
79	2	cobakk ke fetch ulang gak nihh	<p>cobain</p>	PRIVATE	
80	2	yayayayayayayaya	<p>testestes</p>	PRIVATE	
65	2	aseppp	<p>asas</p>	PRIVATE	
10	2	penyakit ginjal	<ol><li>kista</li><li>batu ginjal</li><li>gagal ginjal</li><li>tumor ginjal</li></ol>	PUBLIC	
81	2	aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa	<p>aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa</p>	PRIVATE	
87	2	hey	<p>hey</p>	PRIVATE	
83	2	test	<p>a</p>	PRIVATE	
84	2	judul	<p>isi</p>	PRIVATE	
86	2	test	<p>test</p>	PRIVATE	
85	2	test lagi	<p>isi</p>	PRIVATE	
15	2	Kentang	<p>kentang yaitu umbi akar yang hidup di darat. Kentang dapat disajikan secara mentah maupun sudah diolah</p>	PUBLIC	https://d1vbn70lmn1nqe.cloudfront.net/prod/wp-content/uploads/2023/03/30033712/Tak-Hanya-Meningkatkan-Fungsi-Otak-Ini-11-Manfaat-kentang-untuk-Kesehatan.jpg
16	2	Test Button Simpan	<p>apa aja lah</p>	PUBLIC	
11	2	CHAT GPT	<ol><li>Pastikan bahwa data <span style="color: var(--tw-prose-code);">nama_tag</span> telah benar-benar ada di objek <span style="color: var(--tw-prose-code);">catatan</span>. Anda dapat mengeceknya dengan menambahkan <span style="color: var(--tw-prose-code);">console.log(catatan)</span> sebelum pemanggilan <span style="color: var(--tw-prose-code);">map</span>.</li><li>Jika <span style="color: var(--tw-prose-code);">nama_tag</span> tidak ada di objek <span style="color: var(--tw-prose-code);">catatan</span>, Anda perlu memperbarui model <span style="color: var(--tw-prose-code);">CatatanData</span> agar mencakup properti <span style="color: var(--tw-prose-code);">nama_tag</span>.</li><li>Jika properti <span style="color: var(--tw-prose-code);">nama_tag</span> ada namun Anda masih mengalami masalah, pastikan bahwa data tag telah dimuat dengan benar dari backend. Anda dapat menggunakan <span style="color: var(--tw-prose-code);">console.log</span> atau tools debugging browser untuk memeriksa data yang diterima dari backend.</li><li>Jika data tag sudah benar-benar ada di objek <span style="color: var(--tw-prose-code);">catatan</span>, namun masih tidak muncul, pastikan bahwa kode untuk menampilkan tag seperti yang Anda tunjukkan sudah berada di tempat yang tepat dalam komponen <span style="color: var(--tw-prose-code);">CardCatatan</span>. Pastikan juga bahwa tidak ada kesalahan sintaks atau logika dalam kode tersebut.</li></ol>	PRIVATE	
88	2	coba tag	<p>isiiiiiii</p>	PRIVATE	
89	2	PROYEK	<p>PROYEK!!!!!!!</p>	PUBLIC	
90	2	test egi	<p>apa aja dah</p>	PRIVATE	
93	2	test egi	<p>asdasdasdasds</p>	PRIVATE	
94	2	adasdasd	<p>asdasdad</p>	PRIVATE	
95	2	egi	<p>dadasdas</p>	PRIVATE	
97	2	ada aja	<p>apa aja</p>	PUBLIC	
98	2	bikin apa	<p>bikin lagi</p>	PRIVATE	
99	2	coba	<p>apa aja</p>	PRIVATE	
100	2	apa aja	<p>apaaa ajaaa</p>	PUBLIC	
102	2	test	<p>test</p>	PRIVATE	
104	2	test_gambar	<p><span style="color: rgb(0, 0, 0);">isi catatan abcdef ghi 123</span></p><p><span style="color: rgb(0, 0, 0);"><span class="ql-cursor">﻿</span></span><img src="data:image/png;base64,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QpYyJCIvClwwPB/5n59YerUu/KjnLX5Pf/12iCgsOE1KREShx2BIREShx2BIREShx2BIREShx2BIREShx2BIREShx2BIREShx2BIREShx2BIREShx2BIREShx2BIREShx2BIREShx2BIREShx2BIREShx2BIREShx2BIREShx2BIREShx2BIREShx2BIREShx2BIREShx2BIREShx2BIREShx2BIREShx2BIREShx2BIREShx2BIREShx2BIREShx2BIREShx2BIREShx2BIREShx2BIREShx2BIREShx2BIREShx2BIREShx2BIREShx2BIREShx2BIREShx2BIREShx2BIREShx2BIREShx2BIREShx2BIREShx2BI6XLbTTdE/q+wviJyVrk7bpOCefPoKyLnMBgSEVHoMRgSEVHoMRgSEVHoMRgSEVHoBS4YZoj8z08svVqXftQMFr6vv347RBQWgQuG5yP/8xNLr9alH/W8he/rr98OEYVF4IJhxgz++pEy+nCYZeUlW/p5iXwiQ8boP+cZDN8jVr+f6dfrlMAFw3Pnz+mvovOfcZNl5Iy5cuzESd3irHM+HGZZecmWfl4inzh/LvrP+XlD9wj6OPR16POsMPV6nRa4YGjV2XPnJGX5Ghkw+G2Zv3p9YH7RRESAPm3eqvWRPu4t1dehzyMGwys6fOyYDJuSIk+9/r7s2PuNbiUi8i/0ZejTPpqaEunjjutWAgbDa/jul33y/z4YJUNHT5R9Bw7qViIi/0DfhT4MfRn6NPqzwAVDpxZz127fJY+88qaMnb1QTp46rVuts/R6XVq3tvKSuYGGwsDafW3fPYK+Cn0W+i70YY4IyC0duGDo9BrftMUrZOCQt2XJ+s2R76UbLbD0el1azrTykrmBhsLA2n1t/R7BP7E40kcNiPRV6LMcFZBbmtOkUfj98BF5Z+J0+fvbw+Tzb3/QrURE7kOfhL7p3UgfdSDSV1HaMBhasPf7n+SZd4fLW+OnqgBJROQW9EFvjp8iT78zXPVNlD6BC4Y5smXTX5mB6Yhlm7aqbcqfLVgip8+c0X+TNlwzJAoek2uG6HPQ96APWr5pm241J3u2rPorfwtcMKxQ/HZ5tl9PKXrj9brFjFOnz8jE+Utk0NB3ZdWWHbr12rhmSBQ8ptYMV27ZLgMjfQ76HvRBJqGPRV+LPjcIAjlN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"></p>	PRIVATE	
106	2	test_edit	<p><span style="color: rgb(0, 0, 0);">judul = 'test_gambar'</span></p><p><span style="color: rgb(0, 0, 0);">isi = 'isi catatan abcdef ghi 123'</span></p><p><span style="color: rgb(0, 0, 0);">privasi = 'PRIVATE'</span></p>	PRIVATE	
108	2	test_bold	<p><strong style="color: rgb(0, 0, 0);">isi catatan abcdef ghi 123</strong></p>	PRIVATE	
112	2	TEST	<p>ABD</p><p><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAA08AAAH1CAYAAAAu8MUgAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAEnQAABJ0Ad5mH3gAADZsSURBVHhe7d19rF1ZQTf+Pb8nvqCGazvFKkb/8NJoYBBJCom2anyhJBpSoySVRkmjiWhvUFJC1EgppTFqyDQY0xKNQkVsrY6RhvAHHaMT6TAGmmgioJfSP8SITwXauUFh9FHn53d3r87umXPuXeflnp57+/kkJ+fsfd72OXvtfdZ3r7XXeeDp/9VM4OMf/3jzohe9qJtiK7IOtz7rcOuzDrc+63Drsw63Putw69sq6/D/664BAABYxwNPPvnkRC1Pn/nMZ5rnP//53RRbkXW49VmHW591uPVZh1ufdbj1WYdb31ZZhw+srq5OFJ4AAADuJ2142rFjR/PlX/7l3SwAAAD6/vM///N2eNq9e3eztLTUzQYAAKBvbW3NgBEAAAA1hCcAAIAKwhMAAEAF4QkAAKCC8AQAAFBBeAIAAKggPAEAAFQQngAAACoITwAAABWEJwAAgArCEwAAQAXhCQAAoILwBAAAUEF4AgAAqCA8AQAAVBCeAAAAKghPAAAAFYQnAACACsITAABABeEJAACgwgOrq6tP7969u1laWupmAdz2q7/6q83HP/7x5iu/8iubd73rXd3c0S5cuNC8//3vb2+/6U1val760pe2t4t3vvOdzYc+9KH29X7qp36q2b9/f3cP21nW9VNPPdW86EUvan7lV36lmzvauOXufuV7ApivtbU1LU/AaKnw9q838h//8R/drab593//9+7WMz7zmc+013m9T33qU+1ttr9xy9G4j79f+Z4A5k94Aubm+c9/fnudI+UveclL2tvTunTpUnP48OH28jd/8zfdXGCR2W6BrUp4Aubm537u55rz58+3XYwGu/RN6tatW92t4a1dwOKx3QJblfAEAABQQXgCAACoYLQ9YKTjx483169fb2+nu91Gzp0711y+fLm9ffTo0WeNpldG48s5T7/8y7/c7Nmzp7vnGTkX4urVq3feN49dXl5uHnrooebgwYPtvFhZWbmr688wr3rVq5rXvOY13dQzrl271vz5n/95O2jFv/zLv3Rzm/Z9XvjCFzY/+IM/2Dzvec/r5j7bZz/72eYDH/hA83d/93d3PX+Y/qiD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"></p>	PUBLIC	https://blog-static.mamikos.com/wp-content/uploads/2022/05/Jurusan-Statistika.jpg
\.


--
-- TOC entry 3499 (class 0 OID 16772)
-- Dependencies: 223
-- Data for Name: catatanbelajar_tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.catatanbelajar_tag (id, id_catatanbelajar, id_tag) FROM stdin;
101	54	16
102	54	24
103	54	56
104	54	57
106	97	7
107	100	7
108	112	64
15	6	11
23	58	7
24	58	10
25	64	23
39	11	13
40	11	9
41	11	10
42	11	12
43	11	30
44	11	31
45	11	32
46	11	33
47	11	34
48	11	35
49	88	43
50	88	42
51	88	41
52	88	40
53	88	39
54	88	38
55	88	37
56	88	36
57	88	10
89	89	49
90	89	48
91	89	47
92	89	46
93	89	45
94	89	44
95	89	51
96	89	52
97	89	53
98	89	54
99	89	55
\.


--
-- TOC entry 3501 (class 0 OID 16779)
-- Dependencies: 225
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comment (id, thread_id, user_id, author, content, anonymous, verified, upvote, created_at) FROM stdin;
13	21	admin	admin	<p>Just deploy it</p>	f	f	1	2024-04-29 03:10:42.646
14	22	admin	admin	<p>after step 2,</p><p>edit the repo.sh file on line 93 like this:</p><pre class="ql-syntax" spellcheck="false">cd $name\n git checkout open-release/${OPENEDX_RELEASE}\n cd ..\n</pre><p><span style="color: rgb(12, 13, 14);">You need to add 1 &amp; 3 line. And then follow further steps.</span></p>	f	f	0	2024-04-29 03:13:03.306
16	26	admin	admin123	<p><strong>apa itu?</strong></p>	t	t	1	2024-04-29 05:00:08.651
\.


--
-- TOC entry 3503 (class 0 OID 16792)
-- Dependencies: 227
-- Data for Name: comment_reply; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comment_reply (id, comment_id, user_id, author, content, anonymous, created_at) FROM stdin;
12	13	admin	admin	<p>no, i need detailed explanation</p>	f	2024-04-29 03:10:58.967
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
2	7	10	f
7	4	5	t
6	4	3	f
8	4	16	t
14	32	3	f
15	6	11	t
16	15	3	t
17	15	11	t
19	28	4	t
20	28	5	t
21	28	11	t
18	28	3	f
1	4	10	f
10	10	4	f
4	4	8	f
3	4	11	t
11	4	7	t
12	4	6	t
13	4	25	t
5	4	26	t
9	4	4	f
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
26	QUIZ STATISTIKA	2024-04-29 00:36:58.518	https://res.cloudinary.com/dbfzfuszc/image/upload/v1714351017/l0jws4neok31ine5hjpz.png	10	https://quizizz.com/admin/quiz/661a4a699ca2c9a62856602b?source=quiz_share	3
27	QUIZ  NAMA ORANG	2024-04-29 01:31:06.838	https://res.cloudinary.com/dbfzfuszc/image/upload/v1714354266/kua27dglrnfbx6zfchur.jpg	20	https://quizizz.com/admin/quiz/abcdefghijk?source=quiz_share	3
23	Quizizzz	2024-04-28 05:19:13.644	https://res.cloudinary.com/dbfzfuszc/image/upload/v1714355722/rz0si4dsqy5cm7764i8l.jpg	4	youtube.com	2
28	Tst Quizzz	2024-04-29 02:19:40.508	https://res.cloudinary.com/dbfzfuszc/image/upload/v1714357180/m76tnxosb5mymduyrons.png	5	https://quizizz.com/admin/quiz/661a4a699ca2c9a62856602b?source=quiz_share	42
15	Quizz MoLe	2024-04-27 04:42:52.3	https://res.cloudinary.com/dbfzfuszc/image/upload/v1714209180/rny8pghyirlkueo4hkpw.jpg	15	www.youtube.com	2
16	Quiz Point Blank	2024-04-27 09:11:13.818	https://res.cloudinary.com/dbfzfuszc/image/upload/v1714209390/txi3xzvfnmjxwmcs3zte.png	5	zepetto.com	3
17	Quiz Edit	2024-04-27 10:14:42.191	https://res.cloudinary.com/dbfzfuszc/image/upload/v1714213749/k6jiv9m757wjclgztpw1.png	15	www.youtube.com	2
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
24	sendist	sendi	When and How to use GraphQL with microservice architecture	<p>'m trying to understand where GraphQL is most suitable to use within a microservice architecture.</p><p>There is some debate about having only 1 GraphQL schema that works as API Gateway proxying the request to the targeted microservices and coercing their response. Microservices still would use REST / Thrift protocol for communication though.</p><p>Another approach is instead to have multiple GraphQL schemas one per microservice. Having a smaller API Gateway server that route the request to the targeted microservice with all the information of the request + the GraphQL query.</p><p><br></p><p><img src="https://i.stack.imgur.com/BrnFy.png"></p><p><br></p>	f	0	2024-04-29 04:09:09.647
21	admin	admin	Openedx deployed locally	<p><span style="color: rgb(12, 13, 14);">After installing and deploying OpenEdx through tutor, I ran Openedx deployed locally and accessed the customized LMS and CMS domain names, and found the following situation. May I ask if my installation and deployment is correct? If so, may I ask what I should do next? If not, what went wrong? f Thank you very much for your answer</span></p>	f	1	2024-04-29 03:09:58.116
22	admin	admin	Openedx devstack installation	<p>I'm trying to install the openedx hawthorn release on my Mac. I followed the instructions, but when I ran&nbsp;<span style="color: var(--black-600); background-color: var(--black-200);">make dev.clone</span>, it gave me the error below:</p><p>fatal: not a git repository (or any of the parent directories): .git</p><p>make: *** [Makefile:41: dev.clone] Error 128</p>	f	1	2024-04-29 03:12:12.68
26	admin	admin123	Pertanyaan 1	<p>Uraian 1 <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAATsAAACICAYAAACY9UyoAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAH3SURBVHhe7dihEcMwEEVBK/13amBkZyZEMVAVervkfgUP3JivA2Bzn3UBtiZ2QILYAQliBySIHZAgdkCC2AEJYgckiB2QIHZAgtgBCWIHJIgdkCB2QILYAQliBySIHZAgdkCC2AEJYgckiB2QIHZAgtgBCWIHJIgdkCB2QILYAQliBySIHZAgdkCC2AEJYgckiB2QIHZAgtgBCWIHJIgdkCB2QILYAQliBySIHZAgdkCC2AEJYgckiB2QIHZAgtgBCWIHJIgdkCB2QILYAQliBySIHZAgdkCC2AEJYgckiB2QIHZAgtgBCWIHJIzzuufaANsaz/cndsD2xnytDbAtPzsgQeyABLEDEsQOSBA7IEHsgASxAxLEDkgQOyBB7IAEsQMSxA5IEDsgQeyABLEDEsQOSBA7IEHsgASxAxLEDkgQOyBB7IAEsQMSxA5IEDsgQeyABLEDEsQOSBA7IEHsgASxAxLEDkgQOyBB7IAEsQMSxA5IEDsgQeyABLEDEsQOSBA7IEHsgASxAxLEDkgQOyBB7ICEcV73XBtgW+P5/sQO2N6Yr7UBtuVnBySIHZAgdkCC2AEJYgckiB2QIHZAgtgBCWIHJIgdkCB2QILYAQliBySIHZAgdkCC2AEJYgckiB2QIHZAgtgBCWIHJIgdkCB2QMBx/AFXcBxmrIxAvgAAAABJRU5ErkJggg=="></p>	f	1	2024-04-29 04:59:43.332
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
26	81
26	72
\.


--
-- TOC entry 3511 (class 0 OID 16840)
-- Dependencies: 235
-- Data for Name: user_upvote_comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_upvote_comment (user_id, comment_id) FROM stdin;
admin	13
admin	16
\.


--
-- TOC entry 3534 (class 0 OID 0)
-- Dependencies: 216
-- Name: catatanbelajar_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.catatanbelajar_id_seq', 112, true);


--
-- TOC entry 3535 (class 0 OID 0)
-- Dependencies: 222
-- Name: catatanbelajar_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.catatanbelajar_tag_id_seq', 108, true);


--
-- TOC entry 3536 (class 0 OID 0)
-- Dependencies: 224
-- Name: comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comment_id_seq', 16, true);


--
-- TOC entry 3537 (class 0 OID 0)
-- Dependencies: 226
-- Name: comment_reply_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comment_reply_id_seq', 14, true);


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

SELECT pg_catalog.setval('public.follow_teman_id_follow_seq', 21, true);


--
-- TOC entry 3540 (class 0 OID 0)
-- Dependencies: 228
-- Name: quiz_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quiz_id_seq', 28, true);


--
-- TOC entry 3541 (class 0 OID 0)
-- Dependencies: 230
-- Name: report_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.report_id_seq', 26, true);


--
-- TOC entry 3542 (class 0 OID 0)
-- Dependencies: 220
-- Name: tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tag_id_seq', 81, true);


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

SELECT pg_catalog.setval('public.thread_id_seq', 26, true);


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


-- Completed on 2024-05-06 11:28:35

--
-- PostgreSQL database dump complete
--


