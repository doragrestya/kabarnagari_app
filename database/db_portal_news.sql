-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 10 Agu 2020 pada 11.18
-- Versi server: 10.3.16-MariaDB
-- Versi PHP: 7.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_portal_news`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_news`
--

CREATE TABLE `tb_news` (
  `id_news` int(11) NOT NULL,
  `title_news` text NOT NULL,
  `image_news` text NOT NULL,
  `content_news` text NOT NULL,
  `description_news` text NOT NULL,
  `date_news` date NOT NULL,
  `category_news` varchar(150) NOT NULL,
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_news`
--

INSERT INTO `tb_news` (`id_news`, `title_news`, `image_news`, `content_news`, `description_news`, `date_news`, `category_news`, `id_user`) VALUES
(2, 'DPR Minta TNI Siaga Bantu Penanganan Virus Corona', 'tentara.jpeg', 'Jakarta, CNN Indonesia -- Anggota Komisi I DPR RI Bobby Adhityo Rizaldi meminta Tentara Nasional Indonesia (TNI) menyiapkan diri untuk membantu penanganan penyebaran virus corona (Covid-19).', 'Menurutnya, langkah ini bisa ditempuh pemerintah lewat Badan Usaha Milik Negara Industri Strategis (BUMNIS) demi memenuhi kebutuhan dan menstabilkan harga masker di pasar yang melonjak seiring dengan mewabahnya virus corona.\r\n\r\n\"Pemerintah melalui BUMNIS untuk segera memproduksi masker untuk memenuhi kebutuhan dalam negeri dan menstabilkan harga di pasaran agar dapat terjangkau oleh masyarakat,\" kata Bobby.\r\n\r\nDia menambahkan bahwa negara harus hadir memberikan pelayanan dan rasa aman bagi masyarakat yang tengah dirundung kekhawatiran pada penyebaran virus corona.\r\n\r\nWabah virus corona telah masuk ke Indonesia. Dua WNI yang bertempat tinggal di Depok, Jawa Barat, dinyatakan positif virus corona setelah kontak dengan warga Jepang.\r\n\r\n\"[WN Jepang] ini teman dekatnya. Ketemunya di sini, di rumahnya, daerah Depok, Jabar,\" ungkap Menteri Kesehatan Terawan, di Istana Negara, Jakarta, Senin (2/3).', '2020-03-07', 'politik', 1),
(3, 'Messi Dikritik Keras, Disebut Seperti Pemain Pensiun', 'mu.jpeg', 'Jakarta, CNN Indonesia -- Kapten Barcelona Lionel Messi mendapat kritikan keras dari legenda timnas Argentina Hugo Gatti setelah tampil buruk pada El Clasico Liga Spanyol melawan Real Madrid, Minggu (1/3).', 'Messi tidak mampu mengangkat Barcelona saat dikalahkan Madrid 0-2 pada pertandingan El Clasico. Kekalahan itu membuat Barcelona tertinggal satu poin dari Madrid di puncak klasemen sementara Liga Spanyol.\r\nGatti mengaku kecewa melihat penampilan Messi di El Clasico. Kiper timnas Argentina era 1966 hingga 1977 itu menganggap Messi seperti pemain yang sudah pensiun.\r\n\r\n\r\n\"Anda tidak bisa membela [Messi]. Anda mungkin bisa membela Messi dari level sepak bola, tapi Messi terlihat seperti pemain veteran, itu harus diungkap,\" ujar Gatti melalui El Chiringuito de Jugones dikutip dari Marca.\r\n\r\n\"Messi belakangan terlihat seperti pemain yang sudah pensiun, itu sejujurnya. Messi seperti mantan pemain [di El Clasico],\" ucap Gatti.\r\n\r\nDikutip dari WhoScored, Messi melepaskan tiga usaha tembakan dengan dua tepat sasaran. Dari empat usaha melewati lawan, penyerang 32 tahun itu hanya sukses satu kali.\r\nPenurunan performa Messi musim ini juga berimbas ke prestasi Barcelona. Meski begitu, Gatti tetap menganggap La Pulga sebagai pesepakbola terbaik di dunia saat ini.\r\n\r\n\"Meski terlihat seperti pemain yang sudah pensiun, Messi tetap pemain terbaik di dunia saat ini bersama Cristiano Ronaldo,\" ujar Gatti.\r\nMenariknya sejak Ronaldo meninggalkan Real Madrid pada 2018, Messi tidak mampu mencetak gol dari lima pertandingan El Clasico.\r\n\r\nBarcelona selanjutnya akan menjamu Real Sociedad pada lanjutan Liga Spanyol di Camp Nou, Sabtu (7/3).', '2020-02-11', 'olahraga', 8),
(4, 'Bos UFC: McGregor Belum Tentu Mau Tunggu Khabib', 'vaksin.jpeg', 'Jakarta, CNN Indonesia -- Presiden UFC Dana White belum tahu pasti sikap Conor McGregor terhadap rencana rematch lawan Khabib Nurmagomedov.\r\n\r\nKhabib saat ini tengah fokus dalam duel lawan Tony Ferguson yang bakal berlangsung pada 18 April. White sudah menjanjikan pengaturan rematch setelah laga tersebut namun ia juga tak yakin McGregor bakal bersabar menanti.', '\"Bila Khabib menang [mengatur jadwal rematch]. Namun saya tak tahu kemungkinan Conor McGregor ingin menunggu dirinya. Kami akan melihat situasi yang terjadi karena mungkin Conor McGregor tak ingin menunggu,\" ujar White seperti dikutip dari MMA News.\r\n\r\n\r\nKhabib sempat menyatakan bakal fokus pada bulan Ramadan untuk berpuasa setelah laga lawan Ferguson. Dengan demikian, pembicaraan pertarungan baru bisa dibahas setelah momen itu, yang berarti kemungkinan laga baru bisa digelar setelah bulan September.\r\n\r\nSementara itu  di bulan Januari sudah tak sabar untuk kembali tampil di octagon. Dengan target tampil lebih aktif, McGregor memang harus kembali berlaga di pertengahan tahun bila berharap bisa tiga kali berlaga tahun ini.\r\nJika McGregor memutuskan untuk tampil di pertengahan tahun, ia tidak akan menghadapi Khabib. Dua lawan yang disebut bakal menghadapi McGregor adalah Nate Diaz dan Justin Gaethje. (ptr/har)', '2020-03-25', 'olahraga', 9),
(36, 'Padang Negeriku', '1_18881_021.jpg', 'Jejak kaki si anak rantau', 'perjalanan', '2020-03-09', 'pendidikan', 8),
(49, 'Sekitar 250 Orang Bersaing Ketat Perebutkan Kuliah Gratis dan Jaminan Kerja Kelas Kerjasama PNP-P.T. Trakindo', 'pend.jpg', 'PNP News. Di tengah kondisi luar biasa pandemi Covid-19, Politeknik Negeri Padang (PNP) bekerjasama dengan P.T. Trakindo Utama menggelar Ujian Masuk Politeknik Negeri Padang (UMPNP) Program Studi D-3 Teknik Alat Berat, di Kampus PNP, Limau Manis, Padang, 27 Juni 2020.', 'Menurut Direktur, peserta yang mendaftar mencapai 252 orang dan yang diterima untuk kerjasama Trakindo hanya 1 kelas, dengan jumlah 24 orang. Setelah tes tertulis berbasis komputer ini mereka yang dinyatakan lulus tahap awal akan menjalani beberapa tes kelanjutan yang diselenggarakan langsung oleh Trakindo.', '2020-07-02', 'pendidikan', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_user`
--

CREATE TABLE `tb_user` (
  `id_user` int(11) NOT NULL,
  `fullname_user` varchar(125) NOT NULL,
  `photo_user` text NOT NULL,
  `email_user` varchar(125) NOT NULL,
  `password_user` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_user`
--

INSERT INTO `tb_user` (`id_user`, `fullname_user`, `photo_user`, `email_user`, `password_user`) VALUES
(1, 'Dora Grestyaaa', '1_18881_028.jpg', 'doragrestyaa@gmail.com', '4297f44b13955235245b2497399d7a93'),
(9, 'Dora Grestya', '1_18881_027.jpg', 'dora@gmail.com', '4297f44b13955235245b2497399d7a93'),
(10, 'Dora Grestyaaa', 'IMG-20200309-WA00131.jpg', 'oya@gmail.com', '4297f44b13955235245b2497399d7a93'),
(11, 'Oya', '', 'oya@gmail.co.', '4297f44b13955235245b2497399d7a93'),
(12, 'oya', '', 'oy@gmail.com', '4297f44b13955235245b2497399d7a93'),
(13, 'Dora', '', 'doraa@gmail.com', '4297f44b13955235245b2497399d7a93'),
(14, 'Udacoding', '', 'udacoding@gmail.com', '4297f44b13955235245b2497399d7a93'),
(15, 'oya', '', 'oya@yahoo.com', '4297f44b13955235245b2497399d7a93'),
(16, 'Dora', '', 'dora26@gmail.com', '4297f44b13955235245b2497399d7a93'),
(17, 'oyaaa', '', 'oyaaa@yahoo.com', '4297f44b13955235245b2497399d7a93'),
(18, 'vina', '', 'vina@gmail.com', '4297f44b13955235245b2497399d7a93');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `tb_news`
--
ALTER TABLE `tb_news`
  ADD PRIMARY KEY (`id_news`);

--
-- Indeks untuk tabel `tb_user`
--
ALTER TABLE `tb_user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `tb_news`
--
ALTER TABLE `tb_news`
  MODIFY `id_news` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT untuk tabel `tb_user`
--
ALTER TABLE `tb_user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
