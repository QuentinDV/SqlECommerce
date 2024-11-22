-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : ven. 22 nov. 2024 à 20:55
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `e-commerce`
--

-- --------------------------------------------------------

--
-- Structure de la table `address`
--

CREATE TABLE `address` (
  `address_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `street` varchar(255) NOT NULL,
  `city` varchar(100) NOT NULL,
  `postal_code` varchar(20) NOT NULL,
  `country` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `address`
--

INSERT INTO `address` (`address_id`, `user_id`, `street`, `city`, `postal_code`, `country`) VALUES
(1, 1, 'rue de Barre', 'Bailly', '54076', ''),
(2, 2, '222, place Petit', 'Hoareau-la-Forêt', '53323', ''),
(3, 3, '99, rue Merle', 'BonninVille', '51629', ''),
(4, 4, '34, chemin de Paris', 'Parent-la-Forêt', '09338', ''),
(5, 5, '246, rue Chevallier', 'Vincentnec', '49922', ''),
(6, 6, '16, impasse Pascal', 'Levy', '71289', ''),
(7, 7, '854, place Frédéric Fouquet', 'Ferreira', '70574', ''),
(8, 8, '7, avenue Mathilde Pierre', 'Renaud-sur-Evrard', '77077', ''),
(9, 9, '96, chemin Patrick Nguyen', 'Pottier', '61576', ''),
(10, 10, 'impasse de Lecomte', 'Milletdan', '32963', '');

-- --------------------------------------------------------

--
-- Structure de la table `cart`
--

CREATE TABLE `cart` (
  `cart_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `cart`
--

INSERT INTO `cart` (`cart_id`, `user_id`, `created_date`) VALUES
(1, 1, '0000-00-00'),
(2, 2, '0000-00-00'),
(3, 3, '0000-00-00'),
(4, 4, '0000-00-00'),
(5, 5, '0000-00-00'),
(6, 6, '0000-00-00'),
(7, 7, '0000-00-00'),
(8, 8, '0000-00-00'),
(9, 9, '0000-00-00'),
(10, 10, '0000-00-00');

-- --------------------------------------------------------

--
-- Structure de la table `command`
--

CREATE TABLE `command` (
  `command_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `cart_id` int(11) NOT NULL,
  `status` enum('processing','shipped','delivered','') NOT NULL,
  `created_date` date NOT NULL,
  `total` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `command`
--

INSERT INTO `command` (`command_id`, `user_id`, `cart_id`, `status`, `created_date`, `total`) VALUES
(1, 1, 1, 'processing', '0000-00-00', 72.00),
(2, 2, 2, 'processing', '0000-00-00', 78.00),
(3, 3, 3, 'processing', '0000-00-00', 37.00),
(4, 4, 4, 'processing', '0000-00-00', 73.00),
(5, 5, 5, 'processing', '0000-00-00', 42.00),
(6, 6, 6, 'processing', '0000-00-00', 67.00),
(7, 7, 7, 'processing', '0000-00-00', 75.00),
(8, 8, 8, 'processing', '0000-00-00', 40.00),
(9, 9, 9, 'processing', '0000-00-00', 74.00),
(10, 10, 10, 'processing', '0000-00-00', 70.00);

-- --------------------------------------------------------

--
-- Structure de la table `invoices`
--

CREATE TABLE `invoices` (
  `invoice_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `command_id` int(11) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `created_date` date NOT NULL,
  `payment_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `invoices`
--

INSERT INTO `invoices` (`invoice_id`, `user_id`, `command_id`, `total`, `created_date`, `payment_id`) VALUES
(1, 1, 1, 80.00, '2009-06-21', 1),
(2, 2, 2, 95.00, '2005-01-27', 2),
(3, 3, 3, 60.00, '1973-02-04', 3),
(4, 4, 4, 60.00, '1997-02-16', 4),
(5, 5, 5, 39.00, '1976-06-06', 5),
(6, 6, 6, 89.00, '2008-06-22', 6),
(7, 7, 7, 39.00, '1980-10-13', 7),
(8, 8, 8, 49.00, '1998-12-13', 8),
(9, 9, 9, 83.00, '2022-09-15', 9),
(10, 10, 10, 66.00, '2008-05-30', 10);

-- --------------------------------------------------------

--
-- Structure de la table `payment`
--

CREATE TABLE `payment` (
  `payment_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `payment_method` enum('credit_card','paypal','iban') NOT NULL,
  `payment_info` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `payment`
--

INSERT INTO `payment` (`payment_id`, `user_id`, `payment_method`, `payment_info`, `created_at`) VALUES
(1, 1, 'credit_card', '377779713232076', '2024-11-22 19:54:35'),
(2, 2, 'credit_card', '4024007185604245', '2024-11-22 19:54:35'),
(3, 3, 'paypal', 'KZ52524K3G41KGC2D33I', '2024-11-22 19:54:35'),
(4, 4, 'credit_card', '5517701776872309', '2024-11-22 19:54:35'),
(5, 5, 'paypal', 'LI91613449S5N14X186E9', '2024-11-22 19:54:35'),
(6, 6, 'credit_card', '6011091206021969', '2024-11-22 19:54:35'),
(7, 7, 'paypal', 'MU20WSDV2323686157278772928UYP', '2024-11-22 19:54:35'),
(8, 8, 'paypal', 'IL969596804058985544260', '2024-11-22 19:54:35'),
(9, 9, 'credit_card', '6011198324681465', '2024-11-22 19:54:35'),
(10, 10, 'iban', 'DO1992GA51824645783716034776', '2024-11-22 19:54:35');

-- --------------------------------------------------------

--
-- Structure de la table `photo`
--

CREATE TABLE `photo` (
  `photo_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `photo_url` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `photo`
--

INSERT INTO `photo` (`photo_id`, `user_id`, `product_id`, `photo_url`, `created_at`) VALUES
(1, 1, 1, 'https://via.placeholder.com/640x480.png/008888?text=products+sample+id', '2024-11-22 19:54:35'),
(2, 2, 6, 'https://via.placeholder.com/640x480.png/00ff44?text=products+sample+reprehenderit', '2024-11-22 19:54:35'),
(3, 3, 9, 'https://via.placeholder.com/640x480.png/006611?text=products+sample+error', '2024-11-22 19:54:35'),
(4, 4, 5, 'https://via.placeholder.com/640x480.png/001177?text=products+sample+sint', '2024-11-22 19:54:35'),
(5, 5, 2, 'https://via.placeholder.com/640x480.png/00bbbb?text=products+sample+ex', '2024-11-22 19:54:35'),
(6, 6, 9, 'https://via.placeholder.com/640x480.png/003377?text=products+sample+quisquam', '2024-11-22 19:54:35'),
(7, 7, 3, 'https://via.placeholder.com/640x480.png/0066ff?text=products+sample+similique', '2024-11-22 19:54:35'),
(8, 8, 6, 'https://via.placeholder.com/640x480.png/00bb99?text=products+sample+aliquam', '2024-11-22 19:54:35'),
(9, 9, 8, 'https://via.placeholder.com/640x480.png/00cccc?text=products+sample+nisi', '2024-11-22 19:54:35'),
(10, 10, 7, 'https://via.placeholder.com/640x480.png/00ff00?text=products+sample+et', '2024-11-22 19:54:35');

-- --------------------------------------------------------

--
-- Structure de la table `product`
--

CREATE TABLE `product` (
  `product_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `stock` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `product`
--

INSERT INTO `product` (`product_id`, `name`, `description`, `price`, `stock`) VALUES
(1, 'magnam', 'Rerum atque tempore qui ut non quis doloribus.', 367.85, 53),
(2, 'debitis', 'Dolor rerum debitis quia minima sit dolorum temporibus.', 95.43, 27),
(3, 'adipisci', 'Dolores ut fugit fugit soluta vero facere.', 161.66, 100),
(4, 'molestiae', 'Exercitationem porro alias rerum in nemo ducimus aliquid.', 421.59, 61),
(5, 'laboriosam', 'Deleniti est accusamus doloremque laboriosam impedit.', 372.19, 60),
(6, 'rem', 'Libero id non ipsa ex dolorem omnis.', 361.34, 88),
(7, 'reprehenderit', 'Modi dicta quos voluptatum voluptates officiis modi perferendis praesentium.', 203.91, 85),
(8, 'cupiditate', 'Reiciendis adipisci exercitationem et sequi vel voluptate dolorem a.', 403.51, 37),
(9, 'possimus', 'Natus tenetur dicta eum error dolorum voluptatibus.', 257.64, 32),
(10, 'in', 'Quod tenetur quaerat non enim dolorum non.', 475.57, 58);

-- --------------------------------------------------------

--
-- Structure de la table `product cart`
--

CREATE TABLE `product cart` (
  `cart_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `product cart`
--

INSERT INTO `product cart` (`cart_id`, `product_id`, `quantity`) VALUES
(1, 1, 5),
(1, 2, 1),
(1, 3, 2),
(1, 4, 3),
(1, 5, 1),
(1, 6, 1),
(1, 7, 3),
(1, 8, 3),
(1, 9, 3),
(1, 10, 4),
(2, 1, 1),
(2, 2, 5),
(2, 3, 5),
(2, 4, 5),
(2, 5, 4),
(2, 6, 1),
(2, 7, 3),
(2, 8, 2),
(2, 9, 3),
(2, 10, 1),
(3, 1, 2),
(3, 2, 3),
(3, 3, 4),
(3, 4, 3),
(3, 5, 1),
(3, 6, 4),
(3, 7, 3),
(3, 8, 3),
(3, 9, 1),
(3, 10, 2),
(4, 1, 3),
(4, 2, 1),
(4, 3, 2),
(4, 4, 2),
(4, 5, 3),
(4, 6, 5),
(4, 7, 3),
(4, 8, 3),
(4, 9, 2),
(4, 10, 3),
(5, 1, 3),
(5, 2, 3),
(5, 3, 3),
(5, 4, 5),
(5, 5, 1),
(5, 6, 3),
(5, 7, 3),
(5, 8, 4),
(5, 9, 3),
(5, 10, 5),
(6, 1, 2),
(6, 2, 1),
(6, 3, 2),
(6, 4, 2),
(6, 5, 3),
(6, 6, 4),
(6, 7, 3),
(6, 8, 3),
(6, 9, 2),
(6, 10, 2),
(7, 1, 1),
(7, 2, 5),
(7, 3, 5),
(7, 4, 2),
(7, 5, 3),
(7, 6, 2),
(7, 7, 2),
(7, 8, 3),
(7, 9, 2),
(7, 10, 2),
(8, 1, 1),
(8, 2, 5),
(8, 3, 2),
(8, 4, 3),
(8, 5, 1),
(8, 6, 3),
(8, 7, 3),
(8, 8, 3),
(8, 9, 5),
(8, 10, 5),
(9, 1, 2),
(9, 2, 1),
(9, 3, 4),
(9, 4, 2),
(9, 5, 4),
(9, 6, 1),
(9, 7, 5),
(9, 8, 2),
(9, 9, 1),
(9, 10, 5),
(10, 1, 2),
(10, 2, 4),
(10, 3, 2),
(10, 4, 5),
(10, 5, 5),
(10, 6, 4),
(10, 7, 2),
(10, 8, 5),
(10, 9, 1),
(10, 10, 4);

-- --------------------------------------------------------

--
-- Structure de la table `rate`
--

CREATE TABLE `rate` (
  `rate_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `rating` int(1) NOT NULL,
  `review` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `rate`
--

INSERT INTO `rate` (`rate_id`, `user_id`, `product_id`, `rating`, `review`, `created_at`) VALUES
(1, 1, 6, 4, 'Sint reprehenderit rem aliquam hic et amet.', '2024-11-22 19:54:35'),
(2, 2, 6, 2, 'Nobis dolorem fuga similique facere vel.', '2024-11-22 19:54:35'),
(3, 3, 10, 3, 'Et ut repellendus ducimus non.', '2024-11-22 19:54:35'),
(4, 4, 1, 2, 'Quia temporibus voluptatem ducimus qui sint aut.', '2024-11-22 19:54:35'),
(5, 5, 10, 2, 'Incidunt rem a sunt nam.', '2024-11-22 19:54:35'),
(6, 6, 9, 4, 'Et cum omnis magnam repellendus aut quae neque.', '2024-11-22 19:54:35'),
(7, 7, 3, 5, 'Ut doloribus aperiam eos consequuntur quia rerum consequatur.', '2024-11-22 19:54:35'),
(8, 8, 8, 5, 'Eius est repellendus dolorum atque qui ut qui.', '2024-11-22 19:54:35'),
(9, 9, 9, 1, 'Perferendis qui occaecati impedit molestiae nisi perferendis aut.', '2024-11-22 19:54:35'),
(10, 10, 1, 4, 'Voluptas vel quis et praesentium dignissimos.', '2024-11-22 19:54:35');

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`user_id`, `username`, `first_name`, `last_name`, `email`, `password`, `created_date`) VALUES
(1, 'iblanc', '', '', 'augustin.godard@yahoo.fr', '$2y$10$6iDUTErAfgQ0ioZcwC6lmuXxWK1Qa14SZc7MgtwCeUUcr60t4tS1O', '0000-00-00'),
(2, 'gonzalez.theodore', '', '', 'aubert.marine@yahoo.fr', '$2y$10$c7Xf5ANA29NlL2JmuOX1/uqH3fYd0NytI58I05HXsFghTcJuysfoS', '0000-00-00'),
(3, 'bsimon', '', '', 'rene32@hotmail.fr', '$2y$10$BLDUK6V9XqJy8jnhEisFcu4zuPM6Nu7V/WyDB2iWdifSzXGuNxPgy', '0000-00-00'),
(4, 'frederique.delannoy', '', '', 'payet.jacques@laposte.net', '$2y$10$KD0is5TZm9Egasep7fmVwutEHjTp3jD7MTUIpRTOpvMshynvO0lPm', '0000-00-00'),
(5, 'lcolin', '', '', 'blanchard.zoe@lefebvre.fr', '$2y$10$2/HUbjmGOIw4K69xDp265unYdMlHa9bo4dQ1e4Y6ApCLRvq6dXi0m', '0000-00-00'),
(6, 'perez.celine', '', '', 'igeorges@mace.fr', '$2y$10$RviJZwMZ4EdszKj1UqS.fO7oPaodHI.utox0Sf06AB1nCPp.orJGm', '0000-00-00'),
(7, 'edith32', '', '', 'frederique.thierry@thibault.net', '$2y$10$0QRl3P.i7BCsrZ3clJDcSO244LY9sV9ap69Tn5NynVt2/Q4hBZoyK', '0000-00-00'),
(8, 'boulanger.marguerite', '', '', 'mmaillot@tessier.fr', '$2y$10$svjA4BNBk9YV74FgsnFbkuCsMaLV3K.1oh8el1hVDybJmVZSuPATW', '0000-00-00'),
(9, 'pblanchard', '', '', 'pgosselin@imbert.com', '$2y$10$Ii5qTx10qefb.BVR.vOSf.tUbXdWixdj7SmJm7BFx3JbO0lXK3SR.', '0000-00-00'),
(10, 'adrien99', '', '', 'hugues.peltier@dbmail.com', '$2y$10$TVLtSEhSl4WvjrcIn6NtK.nzE6P/YyJfw7GTQQnuoAZPw9/5H1eau', '0000-00-00');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`address_id`),
  ADD KEY `fk_user_address` (`user_id`);

--
-- Index pour la table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `fk_user_cart` (`user_id`);

--
-- Index pour la table `command`
--
ALTER TABLE `command`
  ADD PRIMARY KEY (`command_id`),
  ADD KEY `fk_user_command` (`user_id`),
  ADD KEY `fk_cart_command` (`cart_id`);

--
-- Index pour la table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`invoice_id`),
  ADD KEY `fk_user_invoice` (`user_id`),
  ADD KEY `fk_command_invoice` (`command_id`),
  ADD KEY `fk_payment_id` (`payment_id`);

--
-- Index pour la table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Index pour la table `photo`
--
ALTER TABLE `photo`
  ADD PRIMARY KEY (`photo_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Index pour la table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_id`);

--
-- Index pour la table `product cart`
--
ALTER TABLE `product cart`
  ADD UNIQUE KEY `unique_cart_product` (`cart_id`,`product_id`),
  ADD KEY `fk_product_product_cart` (`product_id`);

--
-- Index pour la table `rate`
--
ALTER TABLE `rate`
  ADD PRIMARY KEY (`rate_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Index pour la table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `unique_email` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `address`
--
ALTER TABLE `address`
  MODIFY `address_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `cart`
--
ALTER TABLE `cart`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `command`
--
ALTER TABLE `command`
  MODIFY `command_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `invoice_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `payment`
--
ALTER TABLE `payment`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `photo`
--
ALTER TABLE `photo`
  MODIFY `photo_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `product`
--
ALTER TABLE `product`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `rate`
--
ALTER TABLE `rate`
  MODIFY `rate_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `address`
--
ALTER TABLE `address`
  ADD CONSTRAINT `address_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `fk_user_address` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Contraintes pour la table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `fk_user_cart` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Contraintes pour la table `command`
--
ALTER TABLE `command`
  ADD CONSTRAINT `command_ibfk_1` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`),
  ADD CONSTRAINT `command_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `fk_cart_command` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`),
  ADD CONSTRAINT `fk_user_command` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Contraintes pour la table `invoices`
--
ALTER TABLE `invoices`
  ADD CONSTRAINT `fk_command_invoice` FOREIGN KEY (`command_id`) REFERENCES `command` (`command_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`payment_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_user_invoice` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `photo`
--
ALTER TABLE `photo`
  ADD CONSTRAINT `photo_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `photo_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `product cart`
--
ALTER TABLE `product cart`
  ADD CONSTRAINT `fk_cart_product_cart` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`),
  ADD CONSTRAINT `fk_product_product_cart` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  ADD CONSTRAINT `product cart_ibfk_1` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`),
  ADD CONSTRAINT `product cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

--
-- Contraintes pour la table `rate`
--
ALTER TABLE `rate`
  ADD CONSTRAINT `rate_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `rate_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
