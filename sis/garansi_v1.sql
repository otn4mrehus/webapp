-- phpMyAdmin SQL Dump
-- Database: `garansi`

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

-- Tabel Guru
CREATE TABLE `guru` (
  `id_guru` int(11) NOT NULL AUTO_INCREMENT,
  `nama_guru` varchar(100) NOT NULL,
  PRIMARY KEY (`id_guru`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabel Jurusan
CREATE TABLE `jurusan` (
  `id_jurusan` int(11) NOT NULL AUTO_INCREMENT,
  `nama_jurusan` varchar(100) NOT NULL,
  PRIMARY KEY (`id_jurusan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabel Kelas
CREATE TABLE `kelas` (
  `id_kelas` int(11) NOT NULL AUTO_INCREMENT,
  `nama_kelas` varchar(100) NOT NULL,
  `id_jurusan` int(11) NOT NULL,
  PRIMARY KEY (`id_kelas`),
  FOREIGN KEY (`id_jurusan`) REFERENCES `jurusan`(`id_jurusan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabel Wali Kelas
CREATE TABLE `wali_kelas` (
  `id_wali_kelas` int(11) NOT NULL AUTO_INCREMENT,
  `id_guru` int(11) NOT NULL,
  `id_kelas` int(11) NOT NULL,
  PRIMARY KEY (`id_wali_kelas`),
  FOREIGN KEY (`id_guru`) REFERENCES `guru`(`id_guru`) ON DELETE CASCADE,
  FOREIGN KEY (`id_kelas`) REFERENCES `kelas`(`id_kelas`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabel Tahun Ajaran
CREATE TABLE `tahun_ajaran` (
  `id_tahun_ajaran` int(11) NOT NULL AUTO_INCREMENT,
  `tahun_ajaran` varchar(50) NOT NULL,
  `status` enum('aktif','non-aktif') NOT NULL,
  PRIMARY KEY (`id_tahun_ajaran`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabel Siswa
CREATE TABLE `siswa` (
  `id_siswa` int(11) NOT NULL AUTO_INCREMENT,
  `nama_siswa` varchar(100) NOT NULL,
  `nis` varchar(50) NOT NULL,
  `tahun_masuk` int(4) NOT NULL,
  `id_kelas` int(11) NOT NULL,
  `id_tahun_ajaran` int(11) NOT NULL,
  `status` enum('aktif','non-aktif') NOT NULL,
  PRIMARY KEY (`id_siswa`),
  FOREIGN KEY (`id_kelas`) REFERENCES `kelas`(`id_kelas`) ON DELETE CASCADE,
  FOREIGN KEY (`id_tahun_ajaran`) REFERENCES `tahun_ajaran`(`id_tahun_ajaran`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabel Pelanggaran
CREATE TABLE `pelanggaran` (
  `id_pelanggaran` int(11) NOT NULL AUTO_INCREMENT,
  `nama_pelanggaran` varchar(100) NOT NULL,
  `point_pelanggaran` int(11) NOT NULL,
  PRIMARY KEY (`id_pelanggaran`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabel Riwayat Pelanggaran
CREATE TABLE `riwayat_pelanggaran` (
  `id_riwayat` int(11) NOT NULL AUTO_INCREMENT,
  `id_siswa` int(11) NOT NULL,
  `id_pelanggaran` int(11) NOT NULL,
  `tanggal_pelanggaran` date NOT NULL,
  `catatan` text NOT NULL,
  PRIMARY KEY (`id_riwayat`),
  FOREIGN KEY (`id_siswa`) REFERENCES `siswa`(`id_siswa`) ON DELETE CASCADE,
  FOREIGN KEY (`id_pelanggaran`) REFERENCES `pelanggaran`(`id_pelanggaran`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabel Absensi
CREATE TABLE `absensi` (
  `id_absensi` int(11) NOT NULL AUTO_INCREMENT,
  `id_siswa` int(11) NOT NULL,
  `tanggal_absensi` date NOT NULL,
  `status` enum('hadir','tidak hadir','izin') NOT NULL,
  PRIMARY KEY (`id_absensi`),
  FOREIGN KEY (`id_siswa`) REFERENCES `siswa`(`id_siswa`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabel Penanganan Pelanggaran
CREATE TABLE `penanganan_pelanggaran` (
  `id_penanganan` int(11) NOT NULL AUTO_INCREMENT,
  `id_riwayat` int(11) NOT NULL,
  `id_guru` int(11) NOT NULL,
  `tindakan` text NOT NULL,
  `tanggal_tindakan` date NOT NULL,
  PRIMARY KEY (`id_penanganan`),
  FOREIGN KEY (`id_riwayat`) REFERENCES `riwayat_pelanggaran`(`id_riwayat`) ON DELETE CASCADE,
  FOREIGN KEY (`id_guru`) REFERENCES `guru`(`id_guru`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabel User
CREATE TABLE `user` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `nama_user` varchar(100)  NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NULL,
  `foto` varchar(255) NULL,
  `status` enum('aktif','non-aktif') NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dummy Data untuk Tabel Guru
INSERT INTO `guru` (`nama_guru`) VALUES
('Guru A'),
('Guru B'),
('Guru C');

-- Dummy Data untuk Tabel Jurusan
INSERT INTO `jurusan` (`nama_jurusan`) VALUES
('Teknik Komputer dan Jaringan'),
('Rekayasa Perangkat Lunak'),
('Multimedia');

-- Dummy Data untuk Tabel Kelas
INSERT INTO `kelas` (`nama_kelas`, `id_jurusan`) VALUES
('X TKJ 1', 1),
('XI RPL 1', 2),
('XII MM 1', 3);

-- Dummy Data untuk Tabel Wali Kelas
INSERT INTO `wali_kelas` (`id_guru`, `id_kelas`) VALUES
(1, 1),
(2, 2),
(3, 3);

-- Dummy Data untuk Tabel Tahun Ajaran
INSERT INTO `tahun_ajaran` (`tahun_ajaran`, `status`) VALUES
('2023/2024', 'aktif'),
('2024/2025', 'non-aktif'),
('2025/2026', 'non-aktif');

-- Dummy Data untuk Tabel Siswa
INSERT INTO `siswa` (`nama_siswa`, `nis`, `tahun_masuk`, `id_kelas`, `id_tahun_ajaran`, `status`) VALUES
('Siswa A', '123456', 2023, 1, 1, 'aktif'),
('Siswa B', '654321', 2023, 2, 1, 'aktif'),
('Siswa C', '789012', 2023, 3, 1, 'aktif');

-- Dummy Data untuk Tabel Pelanggaran
INSERT INTO `pelanggaran` (`nama_pelanggaran`, `point_pelanggaran`) VALUES
('Telat Masuk Kelas', 5),
('Tidak Mengerjakan PR', 3),
('Berbicara di Kelas', 2);

-- Dummy Data untuk Tabel Riwayat Pelanggaran
INSERT INTO `riwayat_pelanggaran` (`id_siswa`, `id_pelanggaran`, `tanggal_pelanggaran`, `catatan`) VALUES
(1, 1, '2023-09-01', 'Telat 15 menit'),
(2, 2, '2023-09-02', 'Tidak mengumpulkan PR'),
(3, 3, '2023-09-03', 'Berbicara dengan teman');

-- Dummy Data untuk Tabel Absensi
INSERT INTO `absensi` (`id_siswa`, `tanggal_absensi`, `status`) VALUES
(1, '2023-10-01', 'hadir'),
(2, '2023-10-01', 'tidak hadir'),
(3, '2023-10-01', 'izin');

-- Dummy Data untuk Tabel Penanganan Pelanggaran
INSERT INTO `penanganan_pelanggaran` (`id_riwayat`, `id_guru`, `tindakan`, `tanggal_tindakan`) VALUES
(1, 1, 'Peringatan Lisan', '2023-09-02'),
(2, 2, 'Tugas Tambahan', '2023-09-03'),
(3, 3, 'Dikeluarkan dari Kelas', '2023-09-04');

-- Dummy Data untuk Tabel User
INSERT INTO `user` (`nama_user`, `username`, `password`, `email`, `foto`,  `status`) VALUES
('Admin', 'admin', '$2y$10$7g6cVGuhWCJEd8uFf88Sg.C33VI1dNTqpuemBDGS849ok1UNKRtNO', '', '', 'aktif'),
('Guru', 'guru', '$2y$10$7g6cVGuhWCJEd8uFf88Sg.C33VI1dNTqpuemBDGS849ok1UNKRtNO', '', '', 'aktif'),
('Kepala Sekolah', 'kepsek', '$2y$10$7g6cVGuhWCJEd8uFf88Sg.C33VI1dNTqpuemBDGS849ok1UNKRtNO', '', '', 'aktif');

COMMIT;


-- Trigger untuk tabel siswa
DELIMITER $$

CREATE TRIGGER after_insert_siswa
AFTER INSERT ON siswa
FOR EACH ROW
BEGIN
  DECLARE user_username VARCHAR(100);
  DECLARE username_exists INT DEFAULT 1;
  DECLARE counter INT DEFAULT 0;

  -- Membuat username dengan huruf kecil dan tanpa spasi dari nama siswa
  SET user_username = LOWER(REPLACE(NEW.nama_siswa, ' ', ''));

  -- Cek apakah username sudah ada di tabel user
  WHILE username_exists > 0 DO
    SELECT COUNT(*) INTO username_exists FROM user WHERE username = user_username;

    -- Jika username sudah ada, tambahkan counter di akhir username
    IF username_exists > 0 THEN
      SET counter = counter + 1;
      SET user_username = CONCAT(LOWER(REPLACE(NEW.nama_siswa, ' ', '')), counter);
    END IF;
  END WHILE;

  -- Insert ke tabel user dengan username yang unik
  INSERT INTO user (nama_user, username, password)
  VALUES (NEW.nama_siswa, user_username, '$2y$10$7g6cVGuhWCJEd8uFf88Sg.C33VI1dNTqpuemBDGS849ok1UNKRtNO');
END$$

CREATE TRIGGER after_update_siswa
AFTER UPDATE ON siswa
FOR EACH ROW
BEGIN
  DECLARE user_username VARCHAR(100);
  DECLARE username_exists INT DEFAULT 1;
  DECLARE counter INT DEFAULT 0;

  -- Membuat username baru dengan huruf kecil dan tanpa spasi dari nama siswa
  SET user_username = LOWER(REPLACE(NEW.nama_siswa, ' ', ''));

  -- Cek apakah username sudah ada di tabel user, selain dari username yang lama
  WHILE username_exists > 0 DO
    SELECT COUNT(*) INTO username_exists FROM user WHERE username = user_username AND username != LOWER(REPLACE(OLD.nama_siswa, ' ', ''));

    -- Jika username sudah ada, tambahkan counter di akhir username
    IF username_exists > 0 THEN
      SET counter = counter + 1;
      SET user_username = CONCAT(LOWER(REPLACE(NEW.nama_siswa, ' ', '')), counter);
    END IF;
  END WHILE;

  -- Update data di tabel user yang terkait dengan siswa yang di-update
  UPDATE user
  SET nama_user = NEW.nama_siswa,
      username = user_username
  WHERE username = LOWER(REPLACE(OLD.nama_siswa, ' ', ''));
END$$

CREATE TRIGGER after_delete_siswa
AFTER DELETE ON siswa
FOR EACH ROW
BEGIN
  -- Menghapus data di tabel user yang terkait dengan siswa yang dihapus
  DELETE FROM user
  WHERE username = LOWER(REPLACE(OLD.nama_siswa, ' ', ''));
END$$

-- Trigger untuk tabel guru
CREATE TRIGGER after_insert_guru
AFTER INSERT ON guru
FOR EACH ROW
BEGIN
  DECLARE user_username VARCHAR(100);
  DECLARE username_exists INT DEFAULT 1;
  DECLARE counter INT DEFAULT 0;

  -- Membuat username dengan huruf kecil dan tanpa spasi dari nama guru
  SET user_username = LOWER(REPLACE(NEW.nama_guru, ' ', ''));

  -- Cek apakah username sudah ada di tabel user
  WHILE username_exists > 0 DO
    SELECT COUNT(*) INTO username_exists FROM user WHERE username = user_username;

    -- Jika username sudah ada, tambahkan counter di akhir username
    IF username_exists > 0 THEN
      SET counter = counter + 1;
      SET user_username = CONCAT(LOWER(REPLACE(NEW.nama_guru, ' ', '')), counter);
    END IF;
  END WHILE;

  -- Insert ke tabel user dengan username yang unik
  INSERT INTO user (nama_user, username, password)
  VALUES (NEW.nama_guru, user_username, '$2y$10$7g6cVGuhWCJEd8uFf88Sg.C33VI1dNTqpuemBDGS849ok1UNKRtNO');
END$$

CREATE TRIGGER after_update_guru
AFTER UPDATE ON guru
FOR EACH ROW
BEGIN
  DECLARE user_username VARCHAR(100);
  DECLARE username_exists INT DEFAULT 1;
  DECLARE counter INT DEFAULT 0;

  -- Membuat username baru dengan huruf kecil dan tanpa spasi dari nama guru
  SET user_username = LOWER(REPLACE(NEW.nama_guru, ' ', ''));

  -- Cek apakah username sudah ada di tabel user, selain dari username yang lama
  WHILE username_exists > 0 DO
    SELECT COUNT(*) INTO username_exists FROM user WHERE username = user_username AND username != LOWER(REPLACE(OLD.nama_guru, ' ', ''));

    -- Jika username sudah ada, tambahkan counter di akhir username
    IF username_exists > 0 THEN
      SET counter = counter + 1;
      SET user_username = CONCAT(LOWER(REPLACE(NEW.nama_guru, ' ', '')), counter);
    END IF;
  END WHILE;

  -- Update data di tabel user yang terkait dengan guru yang di-update
  UPDATE user
  SET nama_user = NEW.nama_guru,
      username = user_username
  WHERE username = LOWER(REPLACE(OLD.nama_guru, ' ', ''));
END$$

CREATE TRIGGER after_delete_guru
AFTER DELETE ON guru
FOR EACH ROW
BEGIN
  -- Menghapus data di tabel user yang terkait dengan guru yang dihapus
  DELETE FROM user
  WHERE username = LOWER(REPLACE(OLD.nama_guru, ' ', ''));
END$$

DELIMITER ;

