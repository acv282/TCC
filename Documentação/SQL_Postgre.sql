--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.3
-- Dumped by pg_dump version 9.5.3

-- Started on 2016-06-22 00:42:43 BRT

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12395)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2257 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 187 (class 1259 OID 17175)
-- Name: equipe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE equipe (
    u_id integer NOT NULL,
    p_id integer NOT NULL,
    pl_id integer NOT NULL,
    nome character varying(40) NOT NULL,
    descricao character varying(255),
    status_acesso smallint
);


ALTER TABLE equipe OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 17180)
-- Name: log_fasta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE log_fasta (
    id_fasta integer NOT NULL,
    descricao character varying(255) NOT NULL,
    stream character varying(255) NOT NULL,
    data timestamp without time zone NOT NULL,
    org_id integer
);


ALTER TABLE log_fasta OWNER TO postgres;

--
-- TOC entry 188 (class 1259 OID 17178)
-- Name: log_fasta_id_fasta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE log_fasta_id_fasta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE log_fasta_id_fasta_seq OWNER TO postgres;

--
-- TOC entry 2258 (class 0 OID 0)
-- Dependencies: 188
-- Name: log_fasta_id_fasta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE log_fasta_id_fasta_seq OWNED BY log_fasta.id_fasta;


--
-- TOC entry 191 (class 1259 OID 17189)
-- Name: log_gbk; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE log_gbk (
    id_gbk integer NOT NULL,
    descricao character varying(255) NOT NULL,
    stream character varying(255) NOT NULL,
    data timestamp without time zone NOT NULL,
    org_id integer
);


ALTER TABLE log_gbk OWNER TO postgres;

--
-- TOC entry 190 (class 1259 OID 17187)
-- Name: log_gbk_id_gbk_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE log_gbk_id_gbk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE log_gbk_id_gbk_seq OWNER TO postgres;

--
-- TOC entry 2259 (class 0 OID 0)
-- Dependencies: 190
-- Name: log_gbk_id_gbk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE log_gbk_id_gbk_seq OWNED BY log_gbk.id_gbk;


--
-- TOC entry 193 (class 1259 OID 17198)
-- Name: log_gff; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE log_gff (
    id_gff integer NOT NULL,
    descricao character varying(255) NOT NULL,
    stream character varying(255) NOT NULL,
    data timestamp without time zone NOT NULL,
    org_id integer
);


ALTER TABLE log_gff OWNER TO postgres;

--
-- TOC entry 192 (class 1259 OID 17196)
-- Name: log_gff_id_gff_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE log_gff_id_gff_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE log_gff_id_gff_seq OWNER TO postgres;

--
-- TOC entry 2260 (class 0 OID 0)
-- Dependencies: 192
-- Name: log_gff_id_gff_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE log_gff_id_gff_seq OWNED BY log_gff.id_gff;


--
-- TOC entry 197 (class 1259 OID 17213)
-- Name: organismo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE organismo (
    org_id integer NOT NULL,
    p_id integer NOT NULL,
    s_id integer NOT NULL,
    nome character varying(50) NOT NULL,
    descricao character varying(255) NOT NULL,
    idstatus integer NOT NULL,
    stream bytea NOT NULL,
    id_fasta integer,
    stream_fasta bytea,
    id_gbk integer,
    stream_gbk bytea,
    id_gff integer,
    stream_gff bytea
);


ALTER TABLE organismo OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 17211)
-- Name: organismo_org_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE organismo_org_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE organismo_org_id_seq OWNER TO postgres;

--
-- TOC entry 2261 (class 0 OID 0)
-- Dependencies: 196
-- Name: organismo_org_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE organismo_org_id_seq OWNED BY organismo.org_id;


--
-- TOC entry 182 (class 1259 OID 17156)
-- Name: papel_equipe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE papel_equipe (
    pl_eq_id integer NOT NULL,
    nivel character varying(20) NOT NULL,
    descricao character varying(255) NOT NULL
);


ALTER TABLE papel_equipe OWNER TO postgres;

--
-- TOC entry 181 (class 1259 OID 17154)
-- Name: papel_equipe_pl_eq_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE papel_equipe_pl_eq_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE papel_equipe_pl_eq_id_seq OWNER TO postgres;

--
-- TOC entry 2262 (class 0 OID 0)
-- Dependencies: 181
-- Name: papel_equipe_pl_eq_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE papel_equipe_pl_eq_id_seq OWNED BY papel_equipe.pl_eq_id;


--
-- TOC entry 198 (class 1259 OID 17220)
-- Name: papel_usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE papel_usuario (
    pl_us_id integer NOT NULL,
    nivel character varying(45),
    descricao character varying(45),
    "Usuario_u_id" integer NOT NULL,
    "Usuario_Usuario_u_id" integer NOT NULL
);


ALTER TABLE papel_usuario OWNER TO postgres;

--
-- TOC entry 186 (class 1259 OID 17168)
-- Name: projeto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE projeto (
    p_id integer NOT NULL,
    c_id integer NOT NULL,
    nome character varying(255) NOT NULL,
    descricao text,
    dt_ini date,
    status_ace smallint,
    status_and character(1),
    "Usuario_u_id" integer NOT NULL
);


ALTER TABLE projeto OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 17166)
-- Name: projeto_p_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE projeto_p_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE projeto_p_id_seq OWNER TO postgres;

--
-- TOC entry 2263 (class 0 OID 0)
-- Dependencies: 185
-- Name: projeto_p_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE projeto_p_id_seq OWNED BY projeto.p_id;


--
-- TOC entry 195 (class 1259 OID 17207)
-- Name: status_organismo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE status_organismo (
    s_id integer NOT NULL,
    descricao character varying(255) NOT NULL
);


ALTER TABLE status_organismo OWNER TO postgres;

--
-- TOC entry 194 (class 1259 OID 17205)
-- Name: status_organismo_s_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE status_organismo_s_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE status_organismo_s_id_seq OWNER TO postgres;

--
-- TOC entry 2264 (class 0 OID 0)
-- Dependencies: 194
-- Name: status_organismo_s_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE status_organismo_s_id_seq OWNED BY status_organismo.s_id;


--
-- TOC entry 184 (class 1259 OID 17162)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE usuario (
    u_id integer NOT NULL,
    "nomeUsuario" character varying(20) NOT NULL,
    "nomeExibicao" character varying(40) NOT NULL,
    senha character varying(40) NOT NULL,
    email character varying(50) NOT NULL,
    permissao character(1) NOT NULL,
    status_ace smallint,
    "Usuario_u_id" integer NOT NULL
);


ALTER TABLE usuario OWNER TO postgres;

--
-- TOC entry 183 (class 1259 OID 17160)
-- Name: usuario_u_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE usuario_u_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE usuario_u_id_seq OWNER TO postgres;

--
-- TOC entry 2265 (class 0 OID 0)
-- Dependencies: 183
-- Name: usuario_u_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE usuario_u_id_seq OWNED BY usuario.u_id;


--
-- TOC entry 2077 (class 2604 OID 17183)
-- Name: id_fasta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY log_fasta ALTER COLUMN id_fasta SET DEFAULT nextval('log_fasta_id_fasta_seq'::regclass);


--
-- TOC entry 2078 (class 2604 OID 17192)
-- Name: id_gbk; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY log_gbk ALTER COLUMN id_gbk SET DEFAULT nextval('log_gbk_id_gbk_seq'::regclass);


--
-- TOC entry 2079 (class 2604 OID 17201)
-- Name: id_gff; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY log_gff ALTER COLUMN id_gff SET DEFAULT nextval('log_gff_id_gff_seq'::regclass);


--
-- TOC entry 2081 (class 2604 OID 17216)
-- Name: org_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organismo ALTER COLUMN org_id SET DEFAULT nextval('organismo_org_id_seq'::regclass);


--
-- TOC entry 2074 (class 2604 OID 17159)
-- Name: pl_eq_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY papel_equipe ALTER COLUMN pl_eq_id SET DEFAULT nextval('papel_equipe_pl_eq_id_seq'::regclass);


--
-- TOC entry 2076 (class 2604 OID 17171)
-- Name: p_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projeto ALTER COLUMN p_id SET DEFAULT nextval('projeto_p_id_seq'::regclass);


--
-- TOC entry 2080 (class 2604 OID 17210)
-- Name: s_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY status_organismo ALTER COLUMN s_id SET DEFAULT nextval('status_organismo_s_id_seq'::regclass);


--
-- TOC entry 2075 (class 2604 OID 17165)
-- Name: u_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario ALTER COLUMN u_id SET DEFAULT nextval('usuario_u_id_seq'::regclass);


--
-- TOC entry 2238 (class 0 OID 17175)
-- Dependencies: 187
-- Data for Name: equipe; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY equipe (u_id, p_id, pl_id, nome, descricao, status_acesso) FROM stdin;
\.


--
-- TOC entry 2240 (class 0 OID 17180)
-- Dependencies: 189
-- Data for Name: log_fasta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY log_fasta (id_fasta, descricao, stream, data, org_id) FROM stdin;
\.


--
-- TOC entry 2266 (class 0 OID 0)
-- Dependencies: 188
-- Name: log_fasta_id_fasta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('log_fasta_id_fasta_seq', 1, false);


--
-- TOC entry 2242 (class 0 OID 17189)
-- Dependencies: 191
-- Data for Name: log_gbk; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY log_gbk (id_gbk, descricao, stream, data, org_id) FROM stdin;
\.


--
-- TOC entry 2267 (class 0 OID 0)
-- Dependencies: 190
-- Name: log_gbk_id_gbk_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('log_gbk_id_gbk_seq', 1, false);


--
-- TOC entry 2244 (class 0 OID 17198)
-- Dependencies: 193
-- Data for Name: log_gff; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY log_gff (id_gff, descricao, stream, data, org_id) FROM stdin;
\.


--
-- TOC entry 2268 (class 0 OID 0)
-- Dependencies: 192
-- Name: log_gff_id_gff_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('log_gff_id_gff_seq', 1, false);


--
-- TOC entry 2248 (class 0 OID 17213)
-- Dependencies: 197
-- Data for Name: organismo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY organismo (org_id, p_id, s_id, nome, descricao, idstatus, stream, id_fasta, stream_fasta, id_gbk, stream_gbk, id_gff, stream_gff) FROM stdin;
\.


--
-- TOC entry 2269 (class 0 OID 0)
-- Dependencies: 196
-- Name: organismo_org_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('organismo_org_id_seq', 1, false);


--
-- TOC entry 2233 (class 0 OID 17156)
-- Dependencies: 182
-- Data for Name: papel_equipe; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY papel_equipe (pl_eq_id, nivel, descricao) FROM stdin;
\.


--
-- TOC entry 2270 (class 0 OID 0)
-- Dependencies: 181
-- Name: papel_equipe_pl_eq_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('papel_equipe_pl_eq_id_seq', 1, false);


--
-- TOC entry 2249 (class 0 OID 17220)
-- Dependencies: 198
-- Data for Name: papel_usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY papel_usuario (pl_us_id, nivel, descricao, "Usuario_u_id", "Usuario_Usuario_u_id") FROM stdin;
\.


--
-- TOC entry 2237 (class 0 OID 17168)
-- Dependencies: 186
-- Data for Name: projeto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY projeto (p_id, c_id, nome, descricao, dt_ini, status_ace, status_and, "Usuario_u_id") FROM stdin;
\.


--
-- TOC entry 2271 (class 0 OID 0)
-- Dependencies: 185
-- Name: projeto_p_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('projeto_p_id_seq', 1, false);


--
-- TOC entry 2246 (class 0 OID 17207)
-- Dependencies: 195
-- Data for Name: status_organismo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY status_organismo (s_id, descricao) FROM stdin;
\.


--
-- TOC entry 2272 (class 0 OID 0)
-- Dependencies: 194
-- Name: status_organismo_s_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('status_organismo_s_id_seq', 1, false);


--
-- TOC entry 2235 (class 0 OID 17162)
-- Dependencies: 184
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY usuario (u_id, "nomeUsuario", "nomeExibicao", senha, email, permissao, status_ace, "Usuario_u_id") FROM stdin;
\.


--
-- TOC entry 2273 (class 0 OID 0)
-- Dependencies: 183
-- Name: usuario_u_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('usuario_u_id_seq', 1, false);


--
-- TOC entry 2083 (class 2606 OID 17224)
-- Name: primary key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY papel_equipe
    ADD CONSTRAINT "primary key" PRIMARY KEY (pl_eq_id);


--
-- TOC entry 2086 (class 2606 OID 17226)
-- Name: primary key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT "primary key1" PRIMARY KEY (u_id, "Usuario_u_id");


--
-- TOC entry 2089 (class 2606 OID 17229)
-- Name: primary key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projeto
    ADD CONSTRAINT "primary key2" PRIMARY KEY (p_id, "Usuario_u_id");


--
-- TOC entry 2093 (class 2606 OID 17232)
-- Name: primary key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY equipe
    ADD CONSTRAINT "primary key3" PRIMARY KEY (u_id, p_id, pl_id);


--
-- TOC entry 2095 (class 2606 OID 17236)
-- Name: primary key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY log_fasta
    ADD CONSTRAINT "primary key4" PRIMARY KEY (id_fasta);


--
-- TOC entry 2097 (class 2606 OID 17238)
-- Name: primary key5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY log_gbk
    ADD CONSTRAINT "primary key5" PRIMARY KEY (id_gbk);


--
-- TOC entry 2099 (class 2606 OID 17240)
-- Name: primary key6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY log_gff
    ADD CONSTRAINT "primary key6" PRIMARY KEY (id_gff);


--
-- TOC entry 2101 (class 2606 OID 17242)
-- Name: primary key7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY status_organismo
    ADD CONSTRAINT "primary key7" PRIMARY KEY (s_id);


--
-- TOC entry 2108 (class 2606 OID 17244)
-- Name: primary key8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organismo
    ADD CONSTRAINT "primary key8" PRIMARY KEY (org_id, s_id);


--
-- TOC entry 2111 (class 2606 OID 17251)
-- Name: primary key9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY papel_usuario
    ADD CONSTRAINT "primary key9" PRIMARY KEY (pl_us_id, "Usuario_u_id", "Usuario_Usuario_u_id");


--
-- TOC entry 2102 (class 1259 OID 17245)
-- Name: fk fasta_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fk fasta_idx" ON organismo USING btree (id_fasta);


--
-- TOC entry 2103 (class 1259 OID 17246)
-- Name: fk gff_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fk gff_idx" ON organismo USING btree (id_gff);


--
-- TOC entry 2090 (class 1259 OID 17234)
-- Name: fk p_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fk p_id_idx" ON equipe USING btree (p_id);


--
-- TOC entry 2104 (class 1259 OID 17247)
-- Name: fk p_id_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fk p_id_idx1" ON organismo USING btree (p_id);


--
-- TOC entry 2091 (class 1259 OID 17233)
-- Name: fk pl_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fk pl_id_idx" ON equipe USING btree (pl_id);


--
-- TOC entry 2105 (class 1259 OID 17248)
-- Name: fk s_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fk s_id_idx" ON organismo USING btree (s_id);


--
-- TOC entry 2109 (class 1259 OID 17252)
-- Name: fk_Papel_Usuario_Usuario1_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fk_Papel_Usuario_Usuario1_idx" ON papel_usuario USING btree ("Usuario_u_id", "Usuario_Usuario_u_id");


--
-- TOC entry 2087 (class 1259 OID 17230)
-- Name: fk_Projeto_Usuario1_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fk_Projeto_Usuario1_idx" ON projeto USING btree ("Usuario_u_id");


--
-- TOC entry 2084 (class 1259 OID 17227)
-- Name: fk_Usuario_Usuario1_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fk_Usuario_Usuario1_idx" ON usuario USING btree ("Usuario_u_id");


--
-- TOC entry 2106 (class 1259 OID 17249)
-- Name: fk_gbk_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_gbk_idx ON organismo USING btree (id_gbk);


--
-- TOC entry 2113 (class 2606 OID 17258)
-- Name: fk fasta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organismo
    ADD CONSTRAINT "fk fasta" FOREIGN KEY (id_fasta) REFERENCES log_fasta(id_fasta);


--
-- TOC entry 2114 (class 2606 OID 17263)
-- Name: fk gff; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organismo
    ADD CONSTRAINT "fk gff" FOREIGN KEY (id_gff) REFERENCES log_gff(id_gff);


--
-- TOC entry 2112 (class 2606 OID 17253)
-- Name: fk pl_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY equipe
    ADD CONSTRAINT "fk pl_id" FOREIGN KEY (pl_id) REFERENCES papel_equipe(pl_eq_id);


--
-- TOC entry 2115 (class 2606 OID 17268)
-- Name: fk s_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organismo
    ADD CONSTRAINT "fk s_id" FOREIGN KEY (s_id) REFERENCES status_organismo(s_id);


--
-- TOC entry 2117 (class 2606 OID 17278)
-- Name: fk_Papel_Usuario_Usuario1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY papel_usuario
    ADD CONSTRAINT "fk_Papel_Usuario_Usuario1" FOREIGN KEY ("Usuario_u_id", "Usuario_Usuario_u_id") REFERENCES usuario(u_id, "Usuario_u_id");


--
-- TOC entry 2116 (class 2606 OID 17273)
-- Name: fk_gbk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organismo
    ADD CONSTRAINT fk_gbk FOREIGN KEY (id_gbk) REFERENCES log_gbk(id_gbk);


--
-- TOC entry 2256 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2016-06-22 00:42:43 BRT

--
-- PostgreSQL database dump complete
--

